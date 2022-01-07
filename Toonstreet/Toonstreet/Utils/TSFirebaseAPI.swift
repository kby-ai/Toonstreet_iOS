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
//    static let purchasedBook = "PurchasedBook"
    static let purchasedBookDict = "PurchasedBook"

    static let popular = "popular"
    static let newrelease = "newrelease"
    static let purchasedByPublisher = "PurchasedByPublisher"

//    static let purchasedBookIndex = "PurchasedBookIndex"
    
//    static let purchasedComic = "PurchasedComic"
//    static let continueReadingComic = "ContinueReadingComic"


}
class TSFirebaseAPI: NSObject {
    
    static var shared:TSFirebaseAPI = TSFirebaseAPI()

    
    var listReadComic:[String] = []
    var listPurchasedComic:[String] = []
    var listPurchasedEpisode:NSMutableDictionary = NSMutableDictionary()

    var arrContinueReading:[TSBook] = []
//    var arrPurchasedComic:[TSBook] = []

    
    var arrNewReleaseDict:[NSDictionary] = []
    var arrPopularComicDict:[NSDictionary] = []
    var arrPurchasedComicDict:[NSDictionary] = []

    
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

    
    func purchaseBook(bookId:String , bookCoin:Int , book:NSDictionary, episode:Int , completion: @escaping (_ status:Bool , _ key:String )->()){
        
        let refPurchase = Database.database().reference(fromURL: FirebaseBaseURL)

        self.redeemCoins(redeemPoint: bookCoin) { available in
            
            if available == true{
                                            
                let bookMutableDict:NSMutableDictionary = NSMutableDictionary()
                var arrPurchasedIndex:[Int] = []
                bookMutableDict.setDictionary(book as! [AnyHashable : Any])

                if let arrIndex = book.value(forKey: "index") as? [Int]{
                    arrPurchasedIndex = arrIndex
                    arrPurchasedIndex.append(episode)
                    
                    bookMutableDict.setValue(arrPurchasedIndex, forKey: "index")
                }else{
                    bookMutableDict.setValue([episode], forKey: "index")
                }
                
                
//                bookMutableDict["issues"][]
                
                if let value = bookMutableDict["issues"] as? Array<Any>{
                    
                    if let dict = value[episode] as? NSDictionary{
                        let todaysDate = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM"
                        let DateInFormat = dateFormatter.string(from: todaysDate)
                        dict.setValue(DateInFormat, forKey: "purchased_date")
                    }
                    
                    
                }
               
                
                
                
                var arrIssuesDict:[NSDictionary] = []
                if let arrIssues = book.value(forKey: "issues") as? [NSDictionary]{
  
                    for index in 0..<arrIssues.count{
//
                        let dict:NSMutableDictionary = arrIssues[index] as! NSMutableDictionary
                        dict.setValue(index, forKey: "episode_number")
                        arrIssuesDict.append(dict)
                    }
                }
                
                bookMutableDict.setValue(arrIssuesDict, forKey: "issues")
//                bookDict = book;
                
                
                
//
                
                
                
                if bookId != "" {
                    refPurchase.child(APIKey.purchasedBookDict).child(TSUser.shared.uID).child(bookId).setValue(bookMutableDict)
                    completion(true , bookId)
                }else{
                    
//                    refPurchase.child(APIKey.purchasedBookDict).child(TSUser.shared.uID).observe(.childAdded)
//                       { (snapshot:DataSnapshot) in
//                           print(snapshot.key)
//                           guard let value = snapshot.value else { return }
//
//                           completion(true , snapshot.key)
//                           //-MsnFbqiVc76vNKLp0AQ , Msn5RH9OHIE5LVUIUkk
//                       }
                    
                    let keyValue = refPurchase.child(APIKey.purchasedBookDict).child(TSUser.shared.uID).childByAutoId().key

                    refPurchase.child(APIKey.purchasedBookDict).child(TSUser.shared.uID).child(keyValue ?? "").setValue(bookMutableDict)
                    completion(true , keyValue ?? "")
                  
                    
                }

                
                
                
                
                
//                do {
//                       try await ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).child(book.title).setValue("\(episode)").childByAutoId()//.child(authResult.uid) //childbyautoid
//
//                   } catch {
//                       print(error)
//                   }

//                    ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).child(book.title).setValue(1)//.child(authResult.uid)
                
            }
            else{
                completion(false , "")

            }
          
        }

        
        
                
      
        
        
      
    }
    
    
    func fetchPopularData(completion: @escaping (_ arrBook:[TSBook])->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.popular).observeSingleEvent(of: .value, with: { (snapshot) in

            var arr:[TSBook] = []
            self.arrPopularComicDict = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrPopularComicDict.append(objDict)
                    let objBook = TSBook.init(dictObj:objDict)
                    if self.listReadComic.contains(objBook.title){
                        objBook.isReadStatus = 1
                        self.arrContinueReading.append(objBook)
                    }else{
                        objBook.isReadStatus = 0
                    }
                    
//                    if self.listPurchasedComic.contains(objBook.title){
//                        objBook.isPurchased = 1
//
//                        if let arrIndex = self.listPurchasedEpisode.value(forKey: objBook.title) as? [Int]{
//
//                            for episodeIndex in 0..<objBook.episodes.count{
//                                if arrIndex.contains(episodeIndex){
//                                    objBook.episodes[episodeIndex].isPurchased = 1
//                                }else{
//                                    objBook.episodes[episodeIndex].isPurchased = 0
//                                }
//                            }
//
//                        }
//                        self.arrPurchasedComic.append(objBook)
//                    }else{
//                        objBook.isPurchased = 0
//                    }
                    
                    arr.append(objBook)
                    
                    
                    //listPurchasedEpisode
                }
                completion(arr)
            }
        })
    }
    
    
    
    
    func fetchNewReleaseData(completion: @escaping (_ arrBook:[TSBook])->()){
        
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)

        _ = ref.child(APIKey.newrelease).observeSingleEvent(of: .value, with: { (snapshot) in

            var arr:[TSBook] = []
            self.arrNewReleaseDict = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    
                    self.arrNewReleaseDict.append(objDict)
                    let objBook = TSBook.init(dictObj:objDict)
                    if self.listReadComic.contains(objBook.title){
                        objBook.isReadStatus = 1
                        self.arrContinueReading.append(objBook)
                    }else{
                        objBook.isReadStatus = 0
                    }
                    
//                    if self.listPurchasedComic.contains(objBook.title){
//                        objBook.isPurchased = 1
//                        if let arrIndex = self.listPurchasedEpisode.value(forKey: objBook.title) as? [Int]{
//
//                            for episodeIndex in 0..<objBook.episodes.count{
//                                if arrIndex.contains(episodeIndex+1){
//                                    objBook.episodes[episodeIndex].isPurchased = 1
//                                }else{
//                                    objBook.episodes[episodeIndex].isPurchased = 0
//                                }
//                            }
//                        }
//                        self.arrPurchasedComic.append(objBook)
//                    }else{
//                        objBook.isPurchased = 0
//                    }
                                        
                    arr.append(objBook)
                    
                    //listPurchasedEpisode
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
    
    
    func fetchPurchaseData(completion: @escaping (_ arrBook:[TSBook])->()){
        
        
        var arrPurchased:[TSBook] = []
        let ref = Database.database().reference(fromURL: FirebaseBaseURL)
        _ = ref.child(APIKey.purchasedBookDict).child(TSUser.shared.uID).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            self.arrPurchasedComicDict = []
            
            guard let value = snapshot.value else { return }

            if let objDict = value as? NSDictionary {
                
                for strKey in objDict.allKeys{
                    if let dictObj = objDict.value(forKey: strKey as! String) as? NSDictionary{
                        
                        dictObj.setValue(strKey, forKey: "bookId")
                        self.arrPurchasedComicDict.append(dictObj)
                        
                        let tsBook = TSBook.init(dictObj:dictObj)
                        if let indexArr = dictObj.value(forKey: "index") as? [Int]{
                            for episode in 0..<tsBook.episodes.count {
                                if indexArr.contains(episode){
                                    tsBook.episodes[episode].isPurchased = 1
                                }else{
                                    tsBook.episodes[episode].isPurchased = 0
                                }
                            }
                        }
                        arrPurchased.append(tsBook)
                    }
                    
                }
                completion(arrPurchased)
            }else{
                completion(arrPurchased)
            }
        })
        
        
//        for episode in listPurchasedComic {
//
//            _ = ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).child(episode).observeSingleEvent(of: .value, with: { (snapshot) in
//
////                print(snapshot)
//
//                self.listPurchasedEpisode = []
//                guard let value = snapshot.value else { return }
//
//                if let arrValue = value as? NSDictionary {
//
////                    for strKey in arrValue.allKeys{
////                        self.listPurchasedEpisode.append(strKey as? String ?? "")
////                    }
//
//                    completion(true)
//                }else{
//                    completion(true)
//                }
//            })
//        }
//        ref.child(APIKey.purchasedBook).child(TSUser.shared.uID).child(book.title).child("\(episode)")
        
        
        
        
        //
    }
}
