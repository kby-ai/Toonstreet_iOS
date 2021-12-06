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
        
        
        override init() {
            super.init()
        }
        
        init(dictObj:NSDictionary) {
            
            if (dictObj["title"] as? String) != nil{
                title = dictObj["title"] as? String ?? ""
            }
            
            if (dictObj["price"] as? String) != nil{
                price = dictObj["price"] as? String ?? ""
            }
            
            if (dictObj["description"] as? String) != nil{
                strDescription = dictObj["description"] as? String ?? ""
            }
            
            if (dictObj["cover"] as? String) != nil{
                cover = dictObj["cover"] as? String ?? ""
            }
            
            if let content = dictObj["contents"] as? [String]{
                strContent = content;
//                for cont in content{
//                    strContent
//                }
            }
//            if (dictObj["contents"] as? String) != nil{
//                cover = dictObj["cover"] as? String ?? ""
//            }

            
            
        
    }

}
