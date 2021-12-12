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

        self.setupUI()
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
    
    
    func setupUI(){
        self.view.backgroundColor = UIColor.Theme.themeBlackColor
    }

    
    //MARK: Validation
    func validatePassword(_ password:String?) throws -> String {
        guard let password = password else {throw ValidationError.enterPassword}
        guard password != "" else {throw ValidationError.enterPassword}
        guard password.count >= 6 else {throw ValidationError.passwordTooShort}

        return password
    }

   
    func isEmptyCheckEmail(_ text:String?) throws -> String  {

            guard let textField = text else {throw ValidationError.enterEmail}
            guard textField != ""  else {throw ValidationError.enterEmail}

            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValidEmail = emailTest.evaluate(with: text)
            if isValidEmail == false{
                throw ValidationError.enterValidEmail
            }
            return textField

    }
    
    func isEmptyCheckUserName(_ text:String?) throws -> String  {

            guard let textField = text else {throw ValidationError.enterUserName}
         
            return textField

    }
    
    
    func createEmptyTableView(tblView:UITableView) -> Void {
        let messageLabel = UILabel()//UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height/2))
        messageLabel.text = "No Record Found"
        messageLabel.textColor = UIColor.black
//            messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.font_bold(26)
        tblView.backgroundView = messageLabel
        tblView.backgroundView?.backgroundColor = UIColor.white
    }
    
    func createEmptyCollectionView(collectionView:UICollectionView) -> Void {
        let messageLabel = UILabel()//UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height/2))
        messageLabel.text = "No Record Found"
        messageLabel.textColor = UIColor.white
//            messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.font_bold(26)
        collectionView.backgroundView = messageLabel
        collectionView.backgroundView?.backgroundColor = UIColor.clear
    }
}
