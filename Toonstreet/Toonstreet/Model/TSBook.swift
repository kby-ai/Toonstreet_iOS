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
    var lastIndex:Int = -1
    var isReadStatus:Int = 0
    var selectedEpison:[String] = []
    var isPurchased:Int = 0
    
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
        
        if (dictObj["isReadStatus"] as? Int) != nil{
            isReadStatus = dictObj["isReadStatus"] as? Int ?? 0
        }
        if (dictObj["lastIndex"] as? Int) != nil{
            lastIndex = dictObj["lastIndex"] as? Int ?? -1
        }
        
        if (dictObj["selectedEpison"] as? [String]) != nil{
            selectedEpison = dictObj["selectedEpison"] as? [String] ?? []
        }
     
        if (dictObj["isPurchased"] as? Int) != nil{
            isPurchased = dictObj["isPurchased"] as? Int ?? 0
        }
        
//        episodes
        if let arrValue = dictObj["issues"] as? [NSDictionary]{// episodes
            episodes = []
            for value in arrValue{
                episodes.append(TSEpisodes.init(dictObj: value))
            }
        }        
    }
}
