//
//  TSTabNavigationMenu.swift
//  CustomTabNavigation
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class TSTabNavigationMenu: UIImageView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    private var aryTabItems:[TSTabItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TSTabItem], frame: CGRect) {
        self.init(frame: frame)
        
        print(frame)
        
        self.image = UIImage(named: "tabBarbg")
        self.isUserInteractionEnabled = true
        
//        UIGraphicsBeginImageContext(self.frame.size)
//        UIImage(named: "tabBarbg.png")?.draw(in: self.bounds)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        if let image = image {
//            self.backgroundColor = UIColor(patternImage: image)
//        }
        
        
        //self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.aryTabItems = menuItems
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth), // fixing width
                
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0)
    }
    
    func createTabItem(item: TSTabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let selectedItemView = UIImageView(frame: CGRect.zero)
        
        // adding tags to get views for modification when selected/unselected
        
        tabBarItem.tag = 11
        itemTitleLabel.tag = 12
        itemIconView.tag = 13
        selectedItemView.tag = 14
        /*
        selectedItemView.image = UIImage(named: "selectedTab")
        selectedItemView.translatesAutoresizingMaskIntoConstraints = false
        selectedItemView.clipsToBounds = true
        tabBarItem.addSubview(selectedItemView)
        NSLayoutConstraint.activate([
            selectedItemView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            selectedItemView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: 9),
            selectedItemView.heightAnchor.constraint(equalToConstant: 30),
            selectedItemView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        selectedItemView.layer.cornerRadius = 10
        tabBarItem.sendSubviewToBack(selectedItemView)
        
        selectedItemView.isHidden = true
        */
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont.systemFont(ofSize: 12)
        itemTitleLabel.textColor = .white // changing color to white
        itemTitleLabel.textAlignment = .left
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        itemTitleLabel.isHidden = false // hiding label for now
        
        itemIconView.image = item.icon!.withRenderingMode(.automatic)
        itemIconView.tintColor = UIColor.white
        itemIconView.contentMode = .scaleAspectFit // added to stop stretching
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 20), // Fixed height for our tab item(25pts) changed to 15
            itemIconView.widthAnchor.constraint(equalToConstant: 20), // Fixed width for our tab item icon changed to 15
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -10), // adding to make icon exact center
            //itemIconView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8), // Position menu item icon 8pts from the top of it's parent view; commenting old y position
            //itemIconView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: 35), s: fixed height of its superview so don't need this, thus commenting
            
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13), // Fixed height for title label
            //itemTitleLabel.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor), // Position label full width across tab bar item
            itemTitleLabel.centerXAnchor.constraint(equalTo: itemIconView.centerXAnchor, constant: 0),
            //itemTitleLabel.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: 8),
            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: 4), // Position title label 4pts below item icon, s: changinf postion of label so don't need this
            ])
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap))) // Each item should be able to trigger and action on tap
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        
        let tabToActivate = self.subviews[tab]
        if let label = tabToActivate.viewWithTag(12) as? UILabel{
            label.textColor = UIColor.yellow
        }
        if let imageView = tabToActivate.viewWithTag(13) as? UIImageView{
            imageView.image = self.aryTabItems[tab].selectedIcon!.withRenderingMode(.automatic)
        }
        
        
        self.itemTapped?(tab)
        
        self.activeItem = tab
    }
    
    func deactivateTab(tab: Int) {
        
        let inactiveTab = self.subviews[tab]
        if let label = inactiveTab.viewWithTag(12) as? UILabel{
            label.textColor = UIColor.white
        }
        if let imageView = inactiveTab.viewWithTag(13) as? UIImageView{
            imageView.image = self.aryTabItems[tab].icon!.withRenderingMode(.automatic)
        }
        
        
       
        
    }
}
