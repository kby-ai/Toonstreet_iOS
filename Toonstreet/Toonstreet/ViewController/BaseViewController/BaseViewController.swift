//
//  BaseViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit



enum NavigationBarButtonItem
{
    case BackArrow
    
    func getImage() -> UIImage {
        switch self {
        case .BackArrow:
            return #imageLiteral(resourceName: "back")
        }
    }
    
    func getButtonName() -> String {
        switch self {

        default:
            return ""
        }
    }
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.setupUI()
        // Do any additional setup after loading the view.
    }
    

    var rightBarButtonItems:[NavigationBarButtonItem] = []{
        didSet{
            var leftBarButtonItems:[UIBarButtonItem] = []
            let leadingSpaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            leadingSpaceItem.width =  -8.0;
            leftBarButtonItems.append(leadingSpaceItem)
            for item in self.rightBarButtonItems{
                let btnNavigationItem = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
                btnNavigationItem.setImage(item.getImage(), for: UIControl.State.normal)
                btnNavigationItem.setImage(item.getImage(), for: UIControl.State.selected)
                btnNavigationItem.setTitle(item.getButtonName(), for: UIControl.State.normal)
                btnNavigationItem.titleLabel?.font = UIFont.appFont_FontRegular(Size: 18.0)
                switch item {
                case .BackArrow:
                    btnNavigationItem.addTarget(self, action: #selector(BaseViewController.navigationBackButton_Clicked), for: UIControl.Event.touchUpInside)
                    break
                    
                }
                leftBarButtonItems.append(UIBarButtonItem.init(customView: btnNavigationItem))
            }
            self.navigationItem.rightBarButtonItems = leftBarButtonItems
        }
    }
    
    var leftBarButtonItems:[NavigationBarButtonItem] = []{
        didSet{
            var leftBarButtonItems:[UIBarButtonItem] = []
            let leadingSpaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            leadingSpaceItem.width = -8.0;
            leftBarButtonItems.append(leadingSpaceItem)
            
            for item in self.leftBarButtonItems{
                let btnNavigationItem = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
                btnNavigationItem.setImage(item.getImage(), for: UIControl.State.normal)
                btnNavigationItem.setImage(item.getImage(), for: UIControl.State.selected)
                btnNavigationItem.setTitle(item.getButtonName(), for: UIControl.State.normal)
                btnNavigationItem.titleLabel?.font = UIFont.appFont_FontRegular(Size: 18.0)
                switch item {
                
                case .BackArrow:
                    btnNavigationItem.addTarget(self, action: #selector(BaseViewController.navigationBackButton_Clicked), for: UIControl.Event.touchUpInside)
                    break
                    
                
                    
                }
                leftBarButtonItems.append(UIBarButtonItem.init(customView: btnNavigationItem))
            }
            self.navigationItem.leftBarButtonItems = leftBarButtonItems
        }
    }
    
    @objc func navigationBackButton_Clicked()->(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    func setupUI(){
//        self.view.backgroundColor = UIColor.Theme.themeBlackColor
//    }

}
