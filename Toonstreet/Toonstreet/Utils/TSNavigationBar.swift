//
//  TSNavigationBar.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit

class TSNavigationBar: UINavigationBar {
    
   
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()->Void
    {
        //Kavin-Update
        self.backgroundColor = UIColor.Theme.themeBlackColor
        self.barTintColor = UIColor.Theme.themeBlackColor
        
        self.isTranslucent = false
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)]
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
//        self.addRoundShadow()
       
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.Theme.themeBlackColor
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        

         //self.navigationItem.prompt = "No Internet Connection."
        //self.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.red]
        
       // self.addNoInternetAvailableView()
       // isShowNoInterviewAvailable = true
        
       // self.showNoInternetAvailableView(withInternetAvailable: false  )
        
        //no internet available view display
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}


