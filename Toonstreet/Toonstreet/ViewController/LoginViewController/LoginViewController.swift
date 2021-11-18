//
//  LoginViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {

    
    //VARIABLE
    var btnEye = UIButton(type: .custom)
//    private let validationService:ValidationService
    var isShowPassword:Bool = false

    @IBOutlet weak var txtViewSignupButton:UILabel!

    @IBOutlet weak var lblStaticUser: TSLabel!
    @IBOutlet weak var lblStaticPassword: TSLabel!
    @IBOutlet weak var txtUsername: TSTextField!
    @IBOutlet weak var txtPassword: TSTextField!

    @IBOutlet weak var btnLogin: TSButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Setup UI
    func setupUI(){
        self.txtUsername.keyboardType = .emailAddress
        self.txtPassword.isSecureTextEntry = true
        self.txtUsername.leftViewImage = UIImage.init(named: "icon")
        self.txtPassword.leftViewImage = UIImage.init(named: "lock")
        self.view.backgroundColor = UIColor.Theme.themeBlackColor
        self.setPasswordVisableMethod()
        self.setupTextView()
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
  
    
    private func setupTextView() -> Void {
        let str = "Dont have account yet? "
        let attributedString = NSMutableAttributedString(string: str)
        var foundRange = attributedString.mutableString.range(of: "Signup")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Theme.textYellowColor, range: foundRange)

        
        
        
        let simpleText = NSMutableAttributedString(string: "Dont have account yet? ")
                simpleText.addAttribute(NSAttributedString.Key.font,
                                        value: UIFont.appFont_Bold(Size: 14.0),
                                  range: NSRange(location: 0, length: simpleText.length))
        simpleText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: simpleText.length))
                
                let termsOfService = NSMutableAttributedString(string: "Signup!")
                termsOfService.addAttribute(NSAttributedString.Key.font,
                                            value: UIFont.appFont_Bold(Size:14.0),
                                              range: NSRange(location: 0, length: termsOfService.length))
        termsOfService.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Theme.textYellowColor, range: NSRange(location: 0, length: termsOfService.length))
                simpleText.append(termsOfService)
        
        self.txtViewSignupButton.attributedText = simpleText
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(btnSignupPush))
        self.txtViewSignupButton.isUserInteractionEnabled = true
        self.txtViewSignupButton.addGestureRecognizer(tapGesture)
    }
    
    
    
    //MARK: Buttons Action
    
    @objc func btnSignupPush(){
           
           if let objSignupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
               self.navigationController?.pushViewController(objSignupVC, animated: true )
           }
       }
    
    
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        
        self.loginFirebaseAuthMethod(email: self.txtUsername.text ?? "", password: self.txtPassword.text ?? "") { [unowned self] result in
            switch result {
                case .success:
                    self.loginSuccess()
                case .failure(let error):
                    self.didFailToLogin(withError: error)
            }
        }
        
    }
    
    
    
    
    //MARK:Firebase Login Method
    
    func loginFirebaseAuthMethod(email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
                do{
                    let emailStr = try self.isEmptyCheckEmail(email)
                    let passwordStr = try self.validatePassword(password)
//                    TSLoader.shared.showLoader()
        
                    Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { [weak self] authResult, error in
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

    
    //MARK: Login Success
    func loginSuccess() {
        
        print("Login Success")
        let tabBar:TabBarController = UIStoryboard(storyboard: .Main).instantiateViewController()
        self.navigationController?.pushViewController(tabBar, animated: true)
    }

    //Handle Error
    func didFailToLogin(withError error: Error) {
        print(error)
    }
    
    
    

}
