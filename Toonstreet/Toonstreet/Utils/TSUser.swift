//
//  TSUser.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class TSUser: NSObject {
    
    static var shared:TSUser = TSUser()
    
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    var phoneNumber:String = ""
    var uID:String = ""
    var isLogin:Bool = false

    private override init() {
        super.init()
        if let encodeObject:Data = UserDefaults.standard.object(forKey: "TSUser") as! Data?
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
        
        self.firstName =  decoder.decodeObject(forKey: "firstName") as! String
        self.lastName =  decoder.decodeObject(forKey: "lastName") as! String
        self.email =  decoder.decodeObject(forKey: "email") as! String
        self.phoneNumber = decoder.decodeObject(forKey: "phoneNumber") as! String
        
        self.uID = decoder.decodeObject(forKey: "uID") as! String
        self.isLogin = decoder.decodeBool(forKey: "isLogin") as! Bool

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.email, forKey:"email")
        coder.encode(self.phoneNumber, forKey:"phoneNumber")
        
        coder.encode(self.uID, forKey:"uID")
        coder.encode(self.isLogin, forKey:"isLogin")

     
    }
    
    func insertCurrentUserValue(withContent content:NSDictionary) -> Void
    {
         
        if let value = content.value(forKey: "first_name") as? String {
            TSUser.shared.firstName = value
        }
        if let value = content.value(forKey: "last_name") as? String {
            TSUser.shared.lastName = value
        }
        if let value = content.value(forKey: "phoneNumber") as? String {
            TSUser.shared.phoneNumber = value
        }

        if let value = content.value(forKey: "email") as? String {
            TSUser.shared.email = value
        }
        
        if let value = content.value(forKey: "isLogin") as? Bool {
            TSUser.shared.isLogin = value
        }
        if let value = content.value(forKey: "uID") as? String {
            TSUser.shared.uID = value
        }
       
        self.saveUserDetails();
    }
    /***********************************************/
    /*                 Save Current User Details                      */
    /***********************************************/
    func saveUserDetails() -> Void {
        let currentUserRef:Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(currentUserRef, forKey: "TSUser")
        UserDefaults.standard.synchronize()
    }
    /***********************************************/
    /*                 Load Current User Details                      */
    /***********************************************/
    private func loadUserDetails(withUserClass user:TSUser) -> Void
    {
        
        self.firstName = user.firstName;
        self.lastName = user.lastName;
        self.email = user.email;
        self.phoneNumber = user.phoneNumber;
        
        self.isLogin = user.isLogin
        self.uID =  user.uID;
    }
    /***********************************************/
    /*    Clear Current User Details               */
    /***********************************************/
    func clearUserDetails() -> Void {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phoneNumber = "";
        
        self.isLogin = false
        self.uID = ""

        self.saveUserDetails()
        
    }
    
}
