//
//  TSFirebaseAPI.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/12/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestoreSwift



struct APIKey {
    static let users = "users"
    static let points = "Points"
    static let continueReading = "ContinueReading"
    static let purchasedBook = "PurchasedBook"
    static let popular = "popular"
    static let newrelease = "newrelease"

    
    
}
class TSFirebaseAPI: NSObject {
    
    static var shared:TSFirebaseAPI = TSFirebaseAPI()

    
    var listReadComic:[String] = []
    var listPurchasedComic:[String] = []

    var arrContinueReading:[TSBook] = []
    var arrPurchasedComic:[TSBook] = []

    
    
    private override init() {
        super.init()
    }
    
    //to get User data
    func getUserData(){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        
        _ = ref.child(APIKey.users).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            guard let value = snapshot.value else { return }
            
            if let dictValue = value as? NSDictionary{
                for objDict in dictValue.allKeys{
                    if let objDict = dictValue.value(forKey: objDict as! String) as? NSDictionary{
                        if objDict.value(forKey: "email") as! String == TSUser.shared.email{
                            print(objDict)
                            TSUser.shared.email = objDict.value(forKey: "email") as! String
                            TSUser.shared.username = objDict.value(forKey: "username") as! String
                            TSUser.shared.uID = objDict.value(forKey: "uid") as! String
                            TSUser.shared.saveUserDetails()
                        }
                    }
                }
            }
        })
    }
    
    
    // Add continue reading data
    
    func AddContinueReadingData(readingUserID:String , comic:TSBook , comicIndex:[String]){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                
        let dict = ["index":"\(comic.lastIndex)","episode":comicIndex] as? [String : Any]
        ref.child(APIKey.continueReading).child(TSUser.shared.uID).child("\(readingUserID)").setValue(dict)//.child(authResult.uid)
        
    }
    
    func RemoveContinueReadingData(readingUserID:String){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                
        ref.child(APIKey.continueReading).child(TSUser.shared.uID).child("\(readingUserID)").removeValue()//.child(authResult.uid)
        
    }
    
    //check comic reading availability
    func checkComicReadingAvailability(completion: @escaping (_ available:Bool)->()){
        
        var ref = Database.database().reference(fromURL: FirebaseBaseURL)

        ref = Database.database().reference().child(APIKey.continueReading).child(TSUser.shared.uID)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                completion(false)
                return
            }else{
                completion(true)
            }
        }
    }
    
    
    
    //add points
    
    func addCoins(newPoint:Int , completion: @escaping (_ coin:Int)->()){
        
        self.getCoins { [unowned self] available in
            
            TSUser.shared.coins = TSUser.shared.coins + newPoint
            TSUser.shared.saveUserDetails()
            
            let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                        
            ref.child(APIKey.points).child(TSUser.shared.uID).setValue(TSUser.shared.coins)//.child(authResult.uid)
            
            completion(TSUser.shared.coins)
        }
    }
    
    func redeemCoins(redeemPoint:Int , completion: @escaping (_ available:Bool)->()){
        
        self.getCoins { [unowned self] available in
            
            if  TSUser.shared.coins >= redeemPoint{
                
            TSUser.shared.coins = TSUser.shared.coins - redeemPoint
            TSUser.shared.saveUserDetails()
            
            let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                        
            ref.child(APIKey.points).child(TSUser.shared.uID).setValue(TSUser.shared.coins)//.child(authResult.uid)
            
            completion(true)
                
            }else{
                UIAlertController.showAlert(andMessage: "You have insufficient coin in your account please purchase coin.", andButtonTitles: ["OK"]) { index in
                    
                    completion(false)

                }

            }
            
        }

    }
    
    
    func getCoins(completion: @escaping (_ available:Bool)->()){

        var ref = Database.database().reference(fromURL: FirebaseBaseURL)

        ref = Database.database().reference().child(APIKey.points).child(TSUser.shared.uID)//.child("\(readingUserID)")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
            
            guard let value = snapshot.value else { return }
            
            if let coinValue = value as? Int{
                TSUser.shared.coins = coinValue
                TSUser.shared.saveUserDetails()
            }
            
            if snapshot.exists(){
                completion(false)
                return
            }else{
                completion(true)
            }
        }
    }

    
    func purchaseBook(bookCoin:Int , book:TSBook, completion: @escaping (_ status:Bool)->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        self.redeemCoins(redeemPoint: bookCoin) { available in
            
            if available == true{
                DispatchQueue.main.async {
                    ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).child(book.title).setValue(1)//.child(authResult.uid)
                }
                
                completion(true)
            }
            else{
                completion(false)

            }
          
        }

        
        
                
      
        
        
      
    }
    
    
    func fetchPopularData(completion: @escaping (_ arrBook:[TSBook])->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.popular).observeSingleEvent(of: .value, with: { (snapshot) in

            var arr:[TSBook] = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
//                    print(objDict)
                    
                    let objBook = TSBook.init(dictObj:objDict)
                    if self.listReadComic.contains(objBook.title){
                        objBook.isReadStatus = 1
                        self.arrContinueReading.append(objBook)
                    }else{
                        objBook.isReadStatus = 0
                    }
                    
                    if self.listPurchasedComic.contains(objBook.title){
                        objBook.isPurchased = 1

                        self.arrPurchasedComic.append(objBook)
                    }else{
                        objBook.isPurchased = 0
                    }
                    
                    arr.append(objBook)
                }
                completion(arr)
            }
        })
    }
    
    
    
    
    func fetchNewReleaseData(completion: @escaping (_ arrBook:[TSBook])->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.newrelease).observeSingleEvent(of: .value, with: { (snapshot) in

            var arr:[TSBook] = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
//                    print(objDict)
                    
                    let objBook = TSBook.init(dictObj:objDict)
                    if self.listReadComic.contains(objBook.title){
                        objBook.isReadStatus = 1
                        self.arrContinueReading.append(objBook)
                    }else{
                        objBook.isReadStatus = 0
                    }
                    
                    if self.listPurchasedComic.contains(objBook.title){
                        objBook.isPurchased = 1
                        self.arrPurchasedComic.append(objBook)
                    }else{
                        objBook.isPurchased = 0
                    }
                                        
                    arr.append(objBook)
                }
                completion(arr)
            }
            
        })
    }
    
    
    
    
    func fetchContinueReadingData(completion: @escaping (_ dict:NSDictionary)->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.continueReading).child(TSUser.shared.uID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.listReadComic = []
            guard let value = snapshot.value else { return }


            if let arrValue = value as? NSDictionary {
                
//                self.objReadingDict = arrValue;
                
                for strKey in arrValue.allKeys{
                    self.listReadComic.append(strKey as? String ?? "")
                }
                
                completion(arrValue)
//                self.fetchComicData()
            }
        })
    }
    
    
//    _ = ref.child("newrelease").observeSingleEvent(of: .value, with: { (snapshot) in
//        print(snapshot)
//        self.arrNewRelease = []
//        guard let value = snapshot.value else { return }
//
//
//        if let arrValue = value as? [NSDictionary]{
//            for objDict in arrValue{
//                print(objDict)
//
//                let objBook = TSBook.init(dictObj:objDict)
//                if self.listReadComic.contains(objBook.title){
//                    self.arrContinueReading.append(objBook)
//                }
//                self.arrNewRelease.append(objBook)
//            }
//        }
//
//        self.tblHomeTableView.setAndReloadTableViewNewRelease(arr: self.arrNewRelease, arrContinueReading: self.arrContinueReading)
//    })
    
    
    func fetchPurchaseData(completion: @escaping (_ status:Bool)->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            self.listPurchasedComic = []
            guard let value = snapshot.value else { return }


            if let arrValue = value as? NSDictionary {
                                
                for strKey in arrValue.allKeys{
                    self.listPurchasedComic.append(strKey as? String ?? "")
                }
                
                completion(true)
            }else{
                completion(true)
            }
        })
    }
}
