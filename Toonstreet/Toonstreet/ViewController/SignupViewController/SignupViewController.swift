//
//  SignupViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit
import SafariServices
class SignupModel:NSObject{
    var userName:String = ""
    var email:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    var isCheckTerms:Bool = false
    var termsOfServiceURL:String = "https://www.google.com"
    var privacyPlocyURL:String = "https://www.google.com"
    
    override init(){
        super.init()
    }
}

class SignupViewController: BaseViewController {

    @IBOutlet weak var txtUsername:TSTextField!
    @IBOutlet weak var txtEmail:TSTextField!
    @IBOutlet weak var txtPassword:TSTextField!
    @IBOutlet weak var txtConfirm:TSTextField!
    @IBOutlet weak var btnCheckmark:TSButton!
    @IBOutlet weak var btnSignup:TSButton!
    @IBOutlet weak var txtViewTermsAndPrivacyPolicy:UITextView!
    private var model:SignupModel = SignupModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI(){
            
        self.leftBarButtonItems = [.BackArrow]
        self.txtUsername.leftViewImage = UIImage.init(named: "icon")
        self.txtUsername.textfieldValueChangeHandler = {  (textfield) in
            
            self.model.userName = textfield.text ?? ""
        }
        
        
        self.txtEmail.leftViewImage = UIImage.init(named: "email")
        self.txtEmail.textfieldValueChangeHandler = {  (textfield) in
            self.model.email = textfield.text ?? ""
        }
        
        self.txtPassword.leftViewImage = UIImage.init(named: "lock")
        self.txtPassword.rightViewImage = UIImage.init(named: "eye")
        self.txtPassword.textfieldValueChangeHandler = {  (textfield) in
            
            self.model.password = textfield.text ?? ""
        }
        
        self.txtConfirm.leftViewImage = UIImage.init(named: "lock")
        self.txtConfirm.rightViewImage = UIImage.init(named: "eye")
        self.txtConfirm.textfieldValueChangeHandler = {  (textfield) in
            
            self.model.confirmPassword = textfield.text ?? ""
        }
        
         self.btnCheckmark.tsButtonType = .image(image: UIImage.init(named: "checkbox") ?? UIImage())//.image(UIImage.init(named: "checkbox")!)
        self.btnSignup.tsButtonType = .solid
        self.setupTextView()
        self.updateCheckboxUI()
         self.view.backgroundColor = UIColor.Theme.themeBlackColor

    }

    private func setupTextView() -> Void {
        
        self.txtViewTermsAndPrivacyPolicy.delegate = self
        let str = "I agree to the ToonStreet Terms of Service and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: str)
        var foundRange = attributedString.mutableString.range(of: "Terms of Service")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Theme.textYellowColor, range: foundRange)
        attributedString.addAttribute(NSAttributedString.Key.link, value: self.model.termsOfServiceURL, range: foundRange)
        foundRange = attributedString.mutableString.range(of: "Privacy Policy")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Theme.textYellowColor, range: foundRange)
        attributedString.addAttribute(NSAttributedString.Key.link, value: self.model.privacyPlocyURL, range: foundRange)
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.textYellowColor,
        ]
        txtViewTermsAndPrivacyPolicy.linkTextAttributes = linkAttributes
        txtViewTermsAndPrivacyPolicy.attributedText = attributedString
        txtViewTermsAndPrivacyPolicy.font = UIFont.appFont_FontRegular(Size: 13)
        txtViewTermsAndPrivacyPolicy.textColor = UIColor.white
       
    }
    private func updateCheckboxUI(){
        if self.model.isCheckTerms {
            self.btnCheckmark.tsButtonType = .image(image: UIImage.init(named: "selected_checkbox") ?? UIImage())
        }else {
            self.btnCheckmark.tsButtonType = .image(image:UIImage.init(named: "checkbox") ?? UIImage())
        }
    }
        //MARK: - Button Action
    @IBAction func buttonCheckbox_clicked(_ sender:UIButton){
        self.model.isCheckTerms = !self.model.isCheckTerms
        self.updateCheckboxUI()
    }

}
//MARK: - TextViewDelegate
extension SignupViewController:UITextViewDelegate{


    func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange) -> Bool
    {
        if (url.absoluteString == self.model.termsOfServiceURL)
        {
            textView.resignFirstResponder()
            self.openURLInSafari(url: self.model.termsOfServiceURL)
        }
        else if (url.absoluteString == self.model.privacyPlocyURL)
        {
            textView.resignFirstResponder()
            self.openURLInSafari(url: self.model.privacyPlocyURL)
            
        }
        return false
    }
    private func openURLInSafari(url:String){
        guard let link = URL.init(string: url) else {return}
        
        let svc = SFSafariViewController(url: link)
        present(svc, animated: true, completion: nil)
    }
}
