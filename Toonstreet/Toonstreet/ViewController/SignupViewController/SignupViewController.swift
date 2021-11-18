//
//  SignupViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 19/11/21.
//

import UIKit
import Firebase

class SignupModel:NSObject{
    var userName:String = ""
    var email:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    var isCheckTerms:Bool = false
    var termsOfServiceURL:String = "www.google.com"
    var privacyPlocyURL:String = "www.google.com"
    
    
    override init(){
        super.init()
    }
}


class SignupViewController: BaseViewController {
    
    
    //VARIABLE
    var btnEye = UIButton(type: .custom)
    var isShowPassword:Bool = false
    
    var btnEyeConfirm = UIButton(type: .custom)
    var isShowPasswordConfirm:Bool = false
    
    
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
        self.setupUI()
    }
    
    //MARK: SetupUI
     func setupUI(){
            
         self.txtEmail.keyboardType = .emailAddress
         self.txtPassword.isSecureTextEntry = true
         self.txtConfirm.isSecureTextEntry = true
         
         self.view.backgroundColor = UIColor.Theme.themeBlackColor
         
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
//        self.txtPassword.rightViewImage = UIImage.init(named: "eye")
        self.txtPassword.textfieldValueChangeHandler = {  (textfield) in
            
            self.model.password = textfield.text ?? ""
        }
        
        self.txtConfirm.leftViewImage = UIImage.init(named: "lock")
//        self.txtConfirm.rightViewImage = UIImage.init(named: "eye")
        self.txtConfirm.textfieldValueChangeHandler = {  (textfield) in
            
            self.model.confirmPassword = textfield.text ?? ""
        }
        
         self.btnCheckmark.tsButtonType = .image(image: UIImage.init(named: "checkbox") ?? UIImage())//.image(image: UIImage.init(named: "checkbox"))
        self.btnSignup.tsButtonType = .solid
        self.setupTextView()
         self.setPasswordVisableMethod()
         self.setPasswordVisableMethodConfirm()
    }
    
    
    //MARK: Password visable methods
    func setPasswordVisableMethod(){
        btnEye.setImage(UIImage(named: "eye"), for: .normal)
        btnEye.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        btnEye.frame = CGRect(x: CGFloat(txtPassword.frame.size.width - 22), y: CGFloat(5), width: CGFloat(15), height: CGFloat(15))
        btnEye.addTarget(self, action: #selector(self.btnShowPasswordInPWD), for: .touchUpInside)
        txtPassword.rightView = btnEye
        txtPassword.rightViewMode = .always
    }
    
    //MARK: Button to visable password Or Hide Password
    @objc func btnShowPasswordInPWD() -> Void
    {
        if isShowPassword == false{
            self.txtPassword.isSecureTextEntry = false
            isShowPassword = true
            self.btnEye.setImage(UIImage(named: "eye"), for: .normal)//eyeopen
            
        }else{
            self.btnEye.setImage(UIImage(named: "eye"), for: .normal)//eyeclose
            self.txtPassword.isSecureTextEntry = true
            isShowPassword = false
        }
    }
    
    //MARK: Password visable methods
    func setPasswordVisableMethodConfirm(){
        btnEyeConfirm.setImage(UIImage(named: "eye"), for: .normal)
        btnEyeConfirm.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        btnEyeConfirm.frame = CGRect(x: CGFloat(txtPassword.frame.size.width - 22), y: CGFloat(5), width: CGFloat(15), height: CGFloat(15))
        btnEyeConfirm.addTarget(self, action: #selector(self.btnShowPasswordInPWDConfirm), for: .touchUpInside)
        txtConfirm.rightView = btnEyeConfirm
        txtConfirm.rightViewMode = .always
    }
    
    //MARK: Button to visable password Or Hide Password
    @objc func btnShowPasswordInPWDConfirm() -> Void
    {
        if isShowPassword == false{
            self.txtConfirm.isSecureTextEntry = false
            isShowPasswordConfirm = true
            self.btnEyeConfirm.setImage(UIImage(named: "eye"), for: .normal)//eyeopen
            
        }else{
            self.btnEyeConfirm.setImage(UIImage(named: "eye"), for: .normal)//eyeclose
            self.txtConfirm.isSecureTextEntry = true
            isShowPasswordConfirm = false
        }
    }
        //MARK: Setup Attributed textview
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
        
        txtViewTermsAndPrivacyPolicy.attributedText = attributedString
        txtViewTermsAndPrivacyPolicy.font = UIFont.appFont_FontRegular(Size: 13)
        txtViewTermsAndPrivacyPolicy.textColor = UIColor.white
    }
    
    
 
    
    //MARK: Firebase Auth signup
    
        func signupFirebaseAuthMethod(email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
    
            
            do{
                
                
                let userNameStr = try self.isEmptyCheckUserName(txtUsername.text)
                let emailStr = try self.isEmptyCheckEmail(email)

                let passwordStr = try self.validatePassword(password)
                let passwordConfirmStr = try self.validatePassword(password)

//                    TSLoader.shared.showLoader()
                if passwordStr != passwordConfirmStr {
                    throw ValidationError.passwordNotMatch
                }
                Auth.auth().createUser(withEmail: emailStr, password: passwordStr) { authResult, error in
                      
                    print(authResult)

    //              guard let strongSelf = self else { return }
                    if error != nil{
//                            TSLoader.shared.hideLoader()
                        completion(.failure(error!))
//                            TSLoader.shared.hideLoader()
                        UIAlertController.alert(message: error!.localizedDescription)
                    }else{
            
    
//                            TSLoader.shared.hideLoader()
//                            UserDefaults.standard.set(true, forKey: "isLogin") //Bool
//                            UserDefaults.standard.synchronize()
                        completion(.success(true))

                    }
                }
    
            }catch {
//                    TSLoader.shared.hideLoader()
                UIAlertController.alert(message: error.localizedDescription)
                completion(.failure(error))
            }
            
            
    
           
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
    
    
  
    
    
    
    //MARK: Button Signup Clicked
    
    
    @IBAction func btnSignupClicked(_ sender: Any) {
        
       
        
        self.signupFirebaseAuthMethod(email: self.txtEmail.text ?? "", password: self.txtPassword.text ?? "") { [unowned self] result in
            switch result {
                case .success:
                //enter userdata to firestore
                    self.signupSuccess()
                case .failure(let error):
                    self.didFailToLogin(withError: error)
            }
        }
    }
    
    
    //MARK: Login Success
    func signupSuccess() {
        
        print("Signup Success")
        let tabBar:TabBarController = UIStoryboard(storyboard: .Main).instantiateViewController()
        self.navigationController?.pushViewController(tabBar, animated: true)
    }

    //Handle Error
    func didFailToLogin(withError error: Error) {
        print(error)
    }
    
}

//MARK: - TextViewDelegate
extension SignupViewController:UITextViewDelegate{
   
    
    func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange) -> Bool
    {
        if (url.absoluteString == self.model.termsOfServiceURL)
        {
            self.view.endEditing(true)
            UIApplication.shared.openURL(URL.init(string: self.model.termsOfServiceURL)!)
            
        }
        else if (url.absoluteString == self.model.privacyPlocyURL)
        {
            self.view.endEditing(true)
            UIApplication.shared.openURL(URL.init(string: self.model.privacyPlocyURL)!)
        }
        return false
    }
}
