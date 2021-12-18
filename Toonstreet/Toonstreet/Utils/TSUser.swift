//
//  TSUser.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class TSUser: NSObject,NSCoding {
    
    static var shared:TSUser = TSUser()
    
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    var username:String = ""
    
    var uID:String = ""
    var coins:Int = 0

//    var isLogin:Bool = false

    private override init() {
        super.init()
        if let encodeObject:Data = UserDefaults.standard.object(forKey: "TSUser") as? Data
        {
            if let saveObj:TSUser = NSKeyedUnarchiver.unarchiveObject(with: encodeObject) as? TSUser
            {
                self.loadUserDetails(withUserClass: saveObj);
            }
            else
            {
                print("Did not load the user class")
            }
        }
        else
        {
            self.clearUserDetails()
            print("Did not load the user class")
        }
    }
    required init(coder decoder: NSCoder) {
        
        if let value = decoder.decodeObject(forKey: "firstName") as? String{
            self.firstName = value
        }
        if let value = decoder.decodeObject(forKey: "lastName") as? String{
            self.lastName = value
        }
        if let value = decoder.decodeObject(forKey: "email") as? String{
            self.email = value
        }
        if let value = decoder.decodeObject(forKey: "username") as? String{
            self.username = value
        }
        if let value = decoder.decodeObject(forKey: "uID") as? String{
            self.uID = value
        }
        if let value = decoder.decodeInteger(forKey: "coins") as? Int{
            self.coins = value
        }
        
        
        
//        if let value = decoder.decodeObject(forKey: "isLogin") as? Bool{
//            self.isLogin = value
//        }
        
        

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.email, forKey:"email")
        coder.encode(self.username, forKey:"username")
        coder.encode(self.uID, forKey:"uID")
        coder.encode(self.coins, forKey:"coins")

        
    }
    
    func insertCurrentUserValue(withContent content:NSDictionary) -> Void
    {
         
        if let value = content.value(forKey: "first_name") as? String {
            TSUser.shared.firstName = value
        }
        if let value = content.value(forKey: "last_name") as? String {
            TSUser.shared.lastName = value
        }
        if let value = content.value(forKey: "username") as? String {
            TSUser.shared.username = value
        }

        if let value = content.value(forKey: "email") as? String {
            TSUser.shared.email = value
        }
        
//        if let value = content.value(forKey: "isLogin") as? Bool {
//            TSUser.shared.isLogin = value
//        }
        
        if let value = content.value(forKey: "uID") as? String {
            TSUser.shared.uID = value
        }
        if let value = content.value(forKey: "coins") as? Int {
            TSUser.shared.coins = value
        }
        
       
        self.saveUserDetails();
    }
    /***********************************************/
    /*                 Save Current User Details                      */
    /***********************************************/
    func saveUserDetails() -> Void {
        
        do{
            let currentUserRef:Data = try NSKeyedArchiver.archivedData(withRootObject: self)
            UserDefaults.standard.set(currentUserRef, forKey: "TSUser")
            UserDefaults.standard.synchronize()
        }catch{
            print(error.localizedDescription)
        }
    }
    /***********************************************/
    /*                 Load Current User Details                      */
    /***********************************************/
    private func loadUserDetails(withUserClass user:TSUser) -> Void
    {
        
        self.firstName = user.firstName;
        self.lastName = user.lastName;
        self.email = user.email;
        self.username = user.username;
        
//        self.isLogin = user.isLogin
        self.uID =  user.uID;
        
        self.coins = user.coins
    }
    /***********************************************/
    /*    Clear Current User Details               */
    /***********************************************/
    func clearUserDetails() -> Void {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.username = "";
        self.coins = 0
//        self.isLogin = false
        self.uID = ""

        self.saveUserDetails()
        
    }
    
}
