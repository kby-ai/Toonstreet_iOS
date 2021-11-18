//
//  TSLoader.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit
import SVProgressHUD

class TSLoader: NSObject {
    
    static let shared = TSLoader()
    
    override private init() {
        super.init()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setBackgroundColor(UIColor.Theme.textYellowColor)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
    
    func showLoader(WithMessage message:String = "Loading") -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    func hideLoader() -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.dismiss()
        }
    }
}
