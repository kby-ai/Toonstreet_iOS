//
//  TSTextField.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import UIKit


    enum TextFieldValidation
    {
        case none
        case Numbers
        case Character
        case NumberWithCharacter
        case CharacterWithFixFirstLetter
        case CharacterWithSpace
        case Amount
        case Phonenumber
    }

    typealias TextFieldValueChangeHandler = ((UITextField)->Void)
    typealias TextFieldDidBeginHandler = ((UITextField)->Void)
    typealias TextFieldLeftViewTapHandler = ((UITextField)->Void)

class TSTextField:  UITextField,UITextFieldDelegate{

        var textfieldValueChangeHandler:TextFieldValueChangeHandler?
        var textfieldLeftviewHandler:TextFieldLeftViewTapHandler?
        var textfieldRightviewHandler:TextFieldLeftViewTapHandler?
        var textfieldDidBeginHandler:TextFieldDidBeginHandler?
        
        var leftViewImage:UIImage?{
            didSet{
                self.addLeftView()
            }
        }

        var rightViewImage:UIImage?{
            didSet{
                self.addRightView()
            }
        }
        private var textFieldInsets = CGPoint(x: 0, y: 0)
        private let leftViewWidth:CGFloat = 40.0
        private let rightViewWidth:CGFloat = 40.0
        private var allowedCharacters:String = ""
        ///default character limit is 20
        var maxCharacterLimit:Int = 200 ;
        var enablePaste:Bool = true
        fileprivate var xSpace:CGFloat = 10.0
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
           
        }
        override func awakeFromNib() {
            super.awakeFromNib()
            self.commonInit()
        }
        func addLeftView(){
            let leftMargine:CGFloat = 8.0
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.leftViewWidth, height: self.bounds.size.height))
            view.backgroundColor = UIColor.clear
            
            let imgView:UIImageView = UIImageView.init(frame: CGRect.init(x: leftMargine, y: 0.0, width: leftViewWidth-leftMargine, height: self.bounds.size.height))
            imgView.image = self.leftViewImage
            imgView.isUserInteractionEnabled = true
            imgView.contentMode = .center
            view.addSubview(imgView)
            
            if self.textfieldLeftviewHandler != nil{
                let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapOnLeftViewClick))
                tapGesture.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tapGesture)
                
            }
            
            self.textFieldInsets = CGPoint(x: 0, y: 0)
            self.leftView = view
            self.leftViewMode = .always
            //self.updateControl(false)
        }
        func addRightView(){
            let rightMargine:CGFloat = 8.0
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.rightViewWidth, height: self.bounds.size.height))
            view.backgroundColor = UIColor.clear
            
            let imgView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0.0, width: leftViewWidth-rightMargine, height: self.bounds.size.height))
            imgView.image = self.rightViewImage
            imgView.isUserInteractionEnabled = true
            imgView.contentMode = .center
            view.addSubview(imgView)
            
            if self.textfieldRightviewHandler != nil{
                let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapOnLeftViewClick))
                tapGesture.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tapGesture)
                
            }
            
            self.rightView = view
            self.rightViewMode = .always
            
            //self.updateControl(false)
        }
        @objc func tapOnLeftViewClick(){
            if let handler = self.textfieldLeftviewHandler{
                handler(self)
            }
        }
        @objc func tapOnRightViewClick(){
            if let handler = self.textfieldRightviewHandler{
                handler(self)
            }
        }
        var textFieldValidation:TextFieldValidation = .none
        {
            didSet{
                switch self.textFieldValidation {
                case .Numbers:
                    self.keyboardType = .decimalPad
                    //self.addDoneButtonOnKeypad()
                    self.allowedCharacters = "0123456789"
                    break;
                case .NumberWithCharacter:
                    self.allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 +#*"
                    break
                case .Character:
                    self.allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    break;
                case .CharacterWithFixFirstLetter:
                    self.allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    break;
                case .CharacterWithSpace:
                    self.allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
                    break;
                case .Amount:
                    self.keyboardType = .decimalPad
                    self.addDoneButtonOnKeypad()
                    self.allowedCharacters = "1234567890. "
                    break;
                case .Phonenumber:
                    self.allowedCharacters = "0123456789+*# "
                    break;
                default:
                    self.allowedCharacters = ""
                }
            }
        }
        
        private func commonInit(){
            self.delegate = self
            
            //createTitleLabel()
            
            //updateColors()
            //addEditingChangedObserver()
            
            self.tintColor = UIColor.white
            self.textColor = UIColor.white
            self.font = UIFont.systemFont(ofSize: 17.0)
            self.backgroundColor = UIColor.clear

            self.textFieldInsets = CGPoint(x: 20, y: 0)
            self.borderStyle = .none
            self.addTarget(self, action: #selector(textfieldValueChangeEvent(textfield:)), for: .editingChanged)
            
        }
        
        func updateBorder(){
            self.layer.borderWidth = 0.5
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.cornerRadius = 8.0 //self.bounds.size.height / 2
            self.layer.masksToBounds = true
        }
        override func draw(_ rect: CGRect) {
            self.updateBorder()
        }
        @objc func textfieldValueChangeEvent(textfield:TSTextField){
            if let handler = self.textfieldValueChangeHandler{
                handler(self)
            }
        }
        func addDoneButtonOnKeypad() -> Void
        {
            if self.keyboardType == .numberPad || self.keyboardType == .decimalPad
            {
                let btnDone:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40.0))
                btnDone.setTitle("Done", for: .normal)
                //btnDone.ozButtonType = .baclgroundColor
                btnDone.addTarget(self, action: #selector(TSTextField.btnDone_Click(sender:)), for: .touchUpInside);
                self.inputAccessoryView = btnDone;
                
            }
            
        }
        @objc func btnDone_Click(sender:UIButton) -> Void
        {
            self.resignFirstResponder()
            
        }
        // MARK: - Overrides
        
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            
            var xValue:CGFloat = textFieldInsets.x
            var width:CGFloat = bounds.width - (xValue*2)
            var yValue:CGFloat = bounds.origin.y
            let height:CGFloat = bounds.height
            
            if self.leftViewImage != nil {
                xValue += leftViewWidth
                width -= leftViewWidth
            }

            if self.rightViewImage != nil{
                width -= rightViewWidth
            }
            return CGRect.init(x: xValue, y: yValue, width: width, height: height)
            

            
        }
        
        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            
            var xValue:CGFloat = textFieldInsets.x
            var width:CGFloat = bounds.width - (xValue*2)
            var yValue:CGFloat =  bounds.origin.y
            let height:CGFloat = bounds.height
            
            if self.leftViewImage != nil {
                xValue += leftViewWidth
                width -= leftViewWidth
            }

            if self.rightViewImage != nil{
                width -= rightViewWidth
            }
            return CGRect.init(x: xValue, y: yValue, width: width, height: height)
            


            print(bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y))
            return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
        }
        
        //MARK:- Delegate Methods
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            return textField.resignFirstResponder()
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if let handler = self.textfieldDidBeginHandler{
                handler(self)
            }
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if newLength <= maxCharacterLimit {
                
                switch self.textFieldValidation {
                case .none:
                    
                    return true
                case .CharacterWithFixFirstLetter:
                    
                    if ((range.location == 0) && (string == " ") )
                    {
                        return false
                    }
                    
                    let cs = CharacterSet.init(charactersIn: allowedCharacters).inverted
                    let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
                    return (string == filtered)
                    
                case .CharacterWithSpace:
                    if ((range.location == 0) && (string == " ") )
                    {
                        return false
                    }
                    
                    let cs = CharacterSet.init(charactersIn: allowedCharacters).inverted
                    let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
                    return (string == filtered)
                case .Amount:
                    if ((range.location == 0) && (string == " ") )
                    {
                        return false
                    }
                    let strText:String = (textField.text?.appending(string))!
                    print(strText)
                    let dotValidation:NSArray = strText.components(separatedBy: ".") as NSArray
                    print(dotValidation)
                    if dotValidation.count > 2
                    {
                        return false
                    }
                    else
                    {
                        if dotValidation.count > 1
                        {
                            let desimalPointCount:String = (dotValidation[1] as? String)!
                            if desimalPointCount.count > 2
                            {
                                return false
                            }
                            else
                            {
                                let cs = CharacterSet.init(charactersIn: allowedCharacters).inverted
                                let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
                                return (string == filtered)
                            }
                        }
                        else
                        {
                            
                            let cs = CharacterSet.init(charactersIn: allowedCharacters).inverted
                            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
                            return (string == filtered)
                            
                        }
                        
                    }
                    
                default:
                    let cs = CharacterSet.init(charactersIn: allowedCharacters).inverted
                    let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
                    return (string == filtered)
                    
                }
                
            }
            else
            {
                return false
            }
            
            //return newLength >= maxCharacterLimit
            
            
            
        }
        
    //    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    //        super.canPerformAction(action, withSender: sender)
    //        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
    //            if enablePaste {
    //                return true
    //
    //            }else{
    //                return false
    //            }
    //        }
    //        return false
    //    }
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
           if nextResponderOverride != nil {
             return false
           } else {
             return super.canPerformAction(action, withSender: sender)
           }
            
        }
        weak var nextResponderOverride: UIResponder?

         override var next: UIResponder? {
           if nextResponderOverride != nil {
             return nextResponderOverride
           } else {
             return super.next
           }
         }
    }

