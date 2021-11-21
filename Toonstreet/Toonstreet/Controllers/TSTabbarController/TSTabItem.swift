//
//  TSTabItem.swift
//  CustomTabNavigation
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

enum TSTabItem: String, CaseIterable {
case home = "home"
case discover = "discover"
case profile = "profile"



var viewController: UIViewController {
    switch self {
    case .home:
        return HomeScreenViewController()
    case .discover:
        return DiscoverViewController()
    case .profile:
        return ProfileViewController()
    }
}

var icon: UIImage? {
    switch self {
    case .home:
        return UIImage(named: "home_tab")!
    case .discover:
        return UIImage(named: "discover_tab")!
    case .profile:
        return UIImage(named: "profile_tab")!
    }
}

    var selectedIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "home_tab_selected")!
        case .discover:
            return UIImage(named: "discover_tab_selected")!
        case .profile:
            return UIImage(named: "profile_tab_selected")!
        }
    }
    
    var displayTitle: String {
    return self.rawValue.capitalized(with: nil)
    }
    
    private func HomeScreenViewController()->UIViewController{
    #warning("Replace with Your Original Controller")
        let storyboard = UIStoryboard.init(storyboard: UIStoryboard.Storyboard.Main, bundle: nil)
        if let objHomeVC = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController{
            return objHomeVC
        }
        return UIViewController()
    }
    private func DiscoverViewController()->UIViewController{
    #warning("Replace with Your Original Controller")
        let storyboard = UIStoryboard.init(storyboard: UIStoryboard.Storyboard.Main, bundle: nil)
        if let objDiscoverVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            return objDiscoverVC
        }
        return UIViewController()
    }
    private func ProfileViewController()->UIViewController{
        
        
    #warning("Replace with Your Original Controller")
        
//                    let storyboard = UIStoryboard.init(storyboard: UIStoryboard.Storyboard.Main, bundle: nil)
//                if let objProfileVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
//                    return objProfileVC
//                }
//                return UIViewController()
        
            let storyboard = UIStoryboard.init(storyboard: UIStoryboard.Storyboard.Main, bundle: nil)
        if let objProfileVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            return objProfileVC
        }
        return UIViewController()
    }
}
