//
//  SignupViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit
import SafariServices
import Firebase


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
            self.txtPassword.isSecureTextEntry = true
            self.model.password = textfield.text ?? ""
        }
        
        self.txtConfirm.leftViewImage = UIImage.init(named: "lock")
        self.txtConfirm.rightViewImage = UIImage.init(named: "eye")
        self.txtConfirm.textfieldValueChangeHandler = {  (textfield) in
            self.txtConfirm.isSecureTextEntry = true

            self.model.confirmPassword = textfield.text ?? ""
        }
        
         self.btnCheckmark.tsButtonType = .image(image: UIImage.init(named: "checkbox") ?? UIImage())//.image(UIImage.init(named: "checkbox")!)
        self.btnSignup.tsButtonType = .solid
        self.setupTextView()
        self.updateCheckboxUI()
         self.view.backgroundColor = UIColor.Theme.themeBlackColor

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
       if isShowPasswordConfirm == false{
           self.txtConfirm.isSecureTextEntry = false
           isShowPasswordConfirm = true
           self.btnEyeConfirm.setImage(UIImage(named: "eye"), for: .normal)//eyeopen
           
       }else{
           self.btnEyeConfirm.setImage(UIImage(named: "eye"), for: .normal)//eyeclose
           self.txtConfirm.isSecureTextEntry = true
           isShowPasswordConfirm = false
       }
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
    
    
    
       
       //MARK: Firebase Auth signup
       
           func signupFirebaseAuthMethod(email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
       
               
               do{
                   
                   
                   let userNameStr = try self.isEmptyCheckUserName(txtUsername.text)
                   let emailStr = try self.isEmptyCheckEmail(email)

                   let passwordStr = try self.validatePassword(password)
                   let passwordConfirmStr = try self.validatePassword(password)

                       TSLoader.shared.showLoader()
                   if passwordStr != passwordConfirmStr {
                       throw ValidationError.passwordNotMatch
                   }
                   Auth.auth().createUser(withEmail: emailStr, password: passwordStr) { authResult, error in
                         
//                       print(authResult)

                       self.checkUsernameAvailability(completion: { [unowned self] isAvailable in
                           
                           if isAvailable == false{
                               
                               let user = Auth.auth().currentUser

                               user?.delete { error in
                                 if let error = error {
                                   // An error happened.
                                     TSLoader.shared.hideLoader()

                                 } else {
                                   // Account deleted.
                                     TSLoader.shared.hideLoader()

                                     UIAlertController.alert(message: "The username is already in use bye another account.")

                                 }
                               }
                               
                           }else{
                               
                               let ref = Database.database().reference(fromURL: "https://toonstreetbackend-default-rtdb.firebaseio.com/")

                               ref.child("users").child("\(userNameStr)").setValue(["username": userNameStr,"email":emailStr,"password":emailStr,"uid":authResult?.user.uid ?? ""])//.child(authResult.uid)

               //              guard let strongSelf = self else { return }
                               if error != nil{
                                       TSLoader.shared.hideLoader()
                                   completion(.failure(error!))
                                       TSLoader.shared.hideLoader()
                                   UIAlertController.alert(message: error!.localizedDescription)
                               }else{
                       
                                   TSUser.shared.uID = authResult?.user.uid ?? ""
                                   TSUser.shared.saveUserDetails()
                                   
                                       TSLoader.shared.hideLoader()
                                   completion(.success(true))

                               }
                               
                           }
                       })
                      
                   }
       
               }catch {
                       TSLoader.shared.hideLoader()
                   UIAlertController.alert(message: error.localizedDescription)
                   completion(.failure(error))
               }
               
           }
           

    func checkUsernameAvailability(completion: @escaping (_ available:Bool)->()){
        guard let lowercasedText = txtUsername.text?.lowercased() else {completion(false); return}
        
        var ref = Database.database().reference(fromURL: "https://toonstreetbackend-default-rtdb.firebaseio.com/")

       ref = Database.database().reference().child("users").child("\(lowercasedText)")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                completion(false)
                return
            }else{
                completion(true)
            }
        }
    }
    
       
       
      
       
     
       
       
       
       //MARK: Button Signup Clicked
       
       
       @IBAction func btnSignupClicked(_ sender: Any) {
           
           if model.isCheckTerms == false{
               UIAlertController.alert(message: "Please confirm terms and condition first.")

               return
           }
           
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
           
           
           UserDefaults.standard.set(true, forKey: "isLogin") //Bool
           UserDefaults.standard.synchronize()
           
           
           if let objTabbar = self.storyboard?.instantiateViewController(withIdentifier: "TSTabBarControllerViewController") as? TSTabBarControllerViewController{
               appDelegate.window?.rootViewController = objTabbar
               //self.navigationController?.pushViewController(objSignupVC, animated: true )
           }
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
