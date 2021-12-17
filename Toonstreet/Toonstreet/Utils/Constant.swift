//
//  Constant.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import Foundation
import UIKit


@available(iOS 13.0, *)
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

@available(iOS 13.0, *)
let scene = UIApplication.shared.connectedScenes.first


//let baseObj = Basevc()
//let AppDelObj : AppDelegate = AppDelegate().sharedInstance
typealias tblCellDelegate = UITableViewDelegate & UITableViewDataSource


let AppName =  "Toonstreet"

//Screen Bounds
let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

//MARK:- font style
var kFontBold = "NunitoSans-Bold"
var kFontExtraBold = "NunitoSans-ExtraBold"
//var kFontLight = "Raleway-Light"
//var kFontMedium = "Raleway-Medium"
var kFontRegular = "NunitoSans-Regular"
var kFontSemiBold = "NunitoSans-SemiBold"
//var kFontThin = "Raleway-Thin"
var kAppLanguage:String = "es"


//FirebaseURL

var FirebaseBaseURL = "https://toonstreetbackend-default-rtdb.firebaseio.com/"


//MARK: Key

//MARK: Alert Titles

let kAlert =  "Alert!"
let kOk = "OK"


//MARK: Alert messages

let kPlzCheckInternetConnection = "Please check your internet connection."



struct Keys {
    static let kId = "id"
    static let kName = "name"
    static let kFirst_flight = "first_flight"
    static let kActive = "active"
    static let kBoosters = "boosters"
    static let kCountry = "country"
    static let kCost_per_launch = "cost_per_launch"
    static let kCostPerLaunch = "costPerLaunch"

    static let kCompany = "company"
    static let kDescription = "descriptionRocket"
    static let kFlickr_images = "flickr_images"
    static let kFlickrImages = "flickrImages"

    static let kStages = "stages"
    static let kType = "type"
    static let kWikipedia = "wikipedia"
    static let kIsFavourite = "isFavourite"

    
}


//MARK:- UIDevice type

extension UIDevice {
    enum DeviceTypes {
        case iPad
        case iPhone4_4s
        case iPhone5_5s
        case iPhone6_6s
        case iPhone6p_6ps
        case iPhonex_xs
        case iPhonexr_xsmax
    }
    
    static var deviceType : DeviceTypes {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .iPad
        }
        
        switch UIScreen.main.bounds.height {
        case 480.0:
            return .iPhone4_4s
        case 568.0:
            return .iPhone5_5s
        case 667.0:
            return .iPhone6_6s
        case 736.0:
            return .iPhone6p_6ps
        case 812.0:
            return .iPhonex_xs
        case 896.0:
            return .iPhonexr_xsmax
        default:
            return .iPhonexr_xsmax
        }
    }
}



