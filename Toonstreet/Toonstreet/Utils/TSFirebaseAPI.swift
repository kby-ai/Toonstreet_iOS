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

    
    
}
class TSFirebaseAPI: NSObject {
    
    static var shared:TSFirebaseAPI = TSFirebaseAPI()

    
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
                ref.child("ContinueReading").child("\(TSUser.shared.uID)").child("\(readingUserID)").setValue(dict)//.child(authResult.uid)
        
    }
    
    
    //check comic reading availability
    func checkComicReadingAvailability(completion: @escaping (_ available:Bool)->()){

        
        var ref = Database.database().reference(fromURL: FirebaseBaseURL)

        ref = Database.database().reference().child(APIKey.continueReading).child("\(TSUser.shared.uID)")
        
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
    
    func addCoins(newPoint:Int){
        
        self.getCoins { [unowned self] available in
            
            TSUser.shared.coins = TSUser.shared.coins + newPoint
            TSUser.shared.saveUserDetails()
            
            let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                        
            ref.child(APIKey.points).child("\(TSUser.shared.uID)").setValue(TSUser.shared.coins)//.child(authResult.uid)
            
        }

        
   
        
    }
    
    func redeemCoins(redeemPoint:Int){
        
        self.getCoins { [unowned self] available in
            
            if  TSUser.shared.coins >= redeemPoint{
                
           
            TSUser.shared.coins = TSUser.shared.coins - redeemPoint
            TSUser.shared.saveUserDetails()
            
            let ref = Database.database().reference(fromURL: FirebaseBaseURL)
                        
            ref.child(APIKey.points).child("\(TSUser.shared.uID)").setValue(TSUser.shared.coins)//.child(authResult.uid)
            
            }else{
                print("Show error")
            }
            
        }

    }
    
    
    func getCoins(completion: @escaping (_ available:Bool)->()){

        var ref = Database.database().reference(fromURL: FirebaseBaseURL)

        ref = Database.database().reference().child(APIKey.points).child("\(TSUser.shared.uID)")//.child("\(readingUserID)")
        
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

    
}
