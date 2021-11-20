//
//  TSTabBarControllerViewController.swift
//  CustomTabNavigation
//
//  Created by Kavin Soni on 20/11/21.
//


import UIKit

class TSTabBarControllerViewController: UITabBarController {
    
    var customTabBar: TSTabNavigationMenu!
    var tabBarHeight: CGFloat = 58.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        //delegate = self
    }
    
    private func loadTabBar() {
        let tabItems: [TSTabItem] = [.home, .discover, .profile]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 0 // default our selected index to the first item
    }
    
    // Build the custom tab bar and hide default
    private func setupCustomTabBar(_ items: [TSTabItem], completion: @escaping ([UIViewController]) -> Void){
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight) // had to change from let frame = tabBar.frame because the default height of 49 was being passed instead of 67. The background wasn't fitting correctly so had to incrrease height by 1. Not quite sure why...
        
        
        print(UIScreen.main.bounds)
        var controllers = [UIViewController]()
        
        // hide the tab bar
        //tabBar.isHidden = false
        
        self.customTabBar = TSTabNavigationMenu(menuItems: items, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        
//        customTabBar.image = UIImage(named: "tabBarbg")
//        customTabBar.isUserInteractionEnabled = true
        // Add it to the view
        self.view.addSubview(customTabBar)
        
        
        
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.topAnchor.constraint(equalTo: tabBar.topAnchor),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            
//            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
//            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBar.frame.height), // Fixed height for nav menu
//            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        
        print(customTabBar.frame)
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController) // we fetch the matching view controller and append here
        }
        
        self.view.layoutIfNeeded() // important step
        completion(controllers) // setup complete. handoff here
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
        print("selected: \(self.selectedIndex) ")
        print("controller: \(self.viewControllers![self.selectedIndex])")
    }
    
}
