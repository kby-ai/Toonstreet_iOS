//
//  TSBook.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class TSBook: TSModel {

    var title:String = ""
    var synopsis:String = ""
    var publisher:String = ""
    var category:String = ""
    var cover:String = ""
    var episodes:[TSEpisodes] = []
    
    
    override init() {
        super.init()
    }
    
    init(dictObj:NSDictionary) {
        
        if (dictObj["title"] as? String) != nil{
            title = dictObj["title"] as? String ?? ""
        }
        
        if (dictObj["synopsis"] as? String) != nil{
            synopsis = dictObj["synopsis"] as? String ?? ""
        }
        
        if (dictObj["publisher"] as? String) != nil{
            publisher = dictObj["publisher"] as? String ?? ""
        }
        
        if (dictObj["category"] as? String) != nil{
            category = dictObj["category"] as? String ?? ""
        }
        
        if (dictObj["cover"] as? String) != nil{
            cover = dictObj["cover"] as? String ?? ""
        }
//        episodes
        if let arrValue = dictObj["episodes"] as? [NSDictionary]{
            episodes = []
            for value in arrValue{
                episodes.append(TSEpisodes.init(dictObj: value))
            }
        }
        
        
    }
}
