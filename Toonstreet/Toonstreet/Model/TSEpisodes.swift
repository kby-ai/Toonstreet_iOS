//
//  TSEpisodes.swift
//  Toonstreet
//
//  Created by Kavin Soni on 06/12/21.
//

import UIKit

class TSEpisodes: TSModel {
    

        var title:String = ""
        var price:String = ""
        var strDescription:String = ""
        var cover:String = ""
        var strContent:[String] = []
        var artist:String = ""
        var writer:String = ""
        var isPurchased:Int = 0


    
    
        override init() {
            super.init()
        }
        
        init(dictObj:NSDictionary) {
            
            if (dictObj["title"] as? String) != nil{
                title = dictObj["title"] as? String ?? ""
            }
            
            if (dictObj["price"] as? String) != nil{
                price = dictObj["price"] as? String ?? ""
            }else if (dictObj["price"] as? Double) != nil{
                let priceDouble = dictObj["price"] as? Double ?? 0.0
                price = "\(priceDouble)"
            }else if (dictObj["price"] as? Int) != nil{
                let priceDouble = dictObj["price"] as? Int ?? 0
                price = "\(priceDouble)"
            }
            
            if (dictObj["artist"] as? String) != nil{
                artist = dictObj["artist"] as? String ?? ""
            }
            
            if (dictObj["writer"] as? String) != nil{
                writer = dictObj["writer"] as? String ?? ""
            }
            
            if (dictObj["description"] as? String) != nil{
                strDescription = dictObj["description"] as? String ?? ""
            }
            
            if (dictObj["cover"] as? String) != nil{
                cover = dictObj["cover"] as? String ?? ""
            }
            
            if (dictObj["isPurchased"] as? Int) != nil{
                isPurchased = dictObj["isPurchased"] as? Int ?? 0
            }
            
            if let content = dictObj["contents"] as? [String]{
                strContent = content;
            }
            
           
            
//            if (dictObj["contents"] as? String) != nil{
//                cover = dictObj["cover"] as? String ?? ""
//            }

            
            
        
    }

}
