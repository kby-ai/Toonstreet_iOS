//
//  Extension.swift
//  Toonstreet
//
//  Created by Kavin Soni on 18/11/21.
//

import Foundation
import UIKit
import CoreImage


extension UIFont {
   

    class func appFont_Bold(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name:  kFontBold, size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
        }
    }
    
//    class func appFont_FontExtraBold(Size:CGFloat)->UIFont{
//        
//        if let font = UIFont.init(name: kFontExtraBold, size: CGFloat(Size).proportionalFontSize()){
//            return font
//        } else {
//            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
//        }
//    }

//    class func appFont_FontLight(Size:CGFloat)->UIFont{
//
//        if let font = UIFont.init(name: kFontLight, size:CGFloat(Size).proportionalFontSize()){
//            return font
//        } else {
//            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
//        }
//    }
    
//    class func appFont_FontMedium(Size:CGFloat)->UIFont{
//
//           if let font = UIFont.init(name: kFontMedium, size:CGFloat(Size).proportionalFontSize()){
//               return font
//           } else {
//               return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
//           }
//       }
    
    class func appFont_FontRegular(Size:CGFloat)->UIFont{
           
           if let font = UIFont.init(name: kFontRegular, size:CGFloat(Size).proportionalFontSize()){
               return font
           } else {
               return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
           }
       }
    
    
    
//    class func appFont_FontSemiBold(Size:CGFloat)->UIFont{
//
//           if let font = UIFont.init(name: kFontSemiBold, size:CGFloat(Size).proportionalFontSize()){
//               return font
//           } else {
//               return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
//           }
//       }
    
    
    
//    class func appFont_FontThin(Size:CGFloat)->UIFont{
//
//           if let font = UIFont.init(name: kFontThin, size:CGFloat(Size).proportionalFontSize()){
//               return font
//           } else {
//               return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
//           }
//       }

    //GET Font Weight
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }
    
    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }
    static var delatFontSize : CGFloat {
           return 0.0
       }

    class func font_bold(_ size : CGFloat) -> UIFont {
        return UIFont(name: kFontBold, size: size+delatFontSize)!;
    }
    class func font_extrabold(_ size : CGFloat) -> UIFont {
        return UIFont(name: kFontExtraBold, size: size+delatFontSize)!;
    }
//    class func font_light(_ size : CGFloat) -> UIFont {
//        return UIFont(name: kFontLight, size: size+delatFontSize)!;
//    }
//    class func font_medium(_ size : CGFloat) -> UIFont {
//        return UIFont(name: kFontMedium, size: size+delatFontSize)!;
//    }
    class func font_regular(_ size : CGFloat) -> UIFont {
        return UIFont(name: kFontRegular, size: size+delatFontSize)!;
    }
    class func font_semibold(_ size : CGFloat) -> UIFont {
        return UIFont(name: kFontSemiBold, size: size+delatFontSize)!;
    }
//    class func font_thin(_ size : CGFloat) -> UIFont {
//        return UIFont(name: kFontThin, size: size+delatFontSize)!;
//    }
    
    var getCustomFont: UIFont {
        
        
        let weight = self.weight
        switch weight {
        case UIFont.Weight.bold:
            //SET Font NAME
            return UIFont(name: "Raleway-Bold", size: self.pointSize) ?? self
//        case UIFont.Weight.heavy:
//            return UIFont(name: "Raleway-ExtraBold", size: self.pointSize) ?? self
        case UIFont.Weight.light:
            return UIFont(name: "Raleway-Light", size: self.pointSize) ?? self
        case UIFont.Weight.medium:
            return UIFont(name: "Raleway-Medium", size: self.pointSize) ?? self
        case UIFont.Weight.regular:
            return UIFont(name: "Raleway-Regular", size: self.pointSize) ?? self
        case UIFont.Weight.semibold:
            return UIFont(name: "Raleway-SemiBold", size: self.pointSize) ?? self
        case UIFont.Weight.thin:
            return UIFont(name: "Raleway-Thin", size: self.pointSize) ?? self
        default:
            break
        }
        return self
    }
}


extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension CGFloat{
    
    init?(_ str: String) {
        guard let float = Float(str) else { return nil }
        self = CGFloat(float)
    }

    
    func twoDigitValue() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
    
        
//        let str : NSString = formatter.stringFromNumber(NSNumber(self))!
        let str = formatter.string(from: NSNumber(value: Double(self)))
        return str! as String;
    }

    
    
    func proportionalFontSize() -> CGFloat {
        
        var sizeToCheckAgainst = self
        
            switch (UIDevice.deviceType) {
                case .iPhone4_4s,
                     .iPhone5_5s :
                    sizeToCheckAgainst -= 1;
                case .iPhone6_6s :
                    sizeToCheckAgainst += 0;
                case .iPhone6p_6ps :
                    sizeToCheckAgainst += 0;
                case .iPhonex_xs,.iPhonexr_xsmax:
                    sizeToCheckAgainst += 0;
                case .iPad :
                    sizeToCheckAgainst += 9;
                }
                return sizeToCheckAgainst
    }
}



extension UIView{
    
    func addDropShadow() -> Void {
          self.layer.masksToBounds = false;
          self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
          self.layer.shadowRadius = 3;
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowOpacity = 0.4;
      }
}


extension UIColor {
    struct Theme {
        static var themeLightBlackColor: UIColor { return UIColor(named: "lightBlack")! }
        static var themeBlackColor: UIColor { return UIColor(named: "themeBlack")! }
        static var textYellowColor: UIColor { return UIColor(named: "themeYellow")! }
        static var transparentBlackColor: UIColor { return UIColor(named: "transparentBlack")! }
        static var newReleaseTransparentBlackColor: UIColor { return UIColor(named: "newReleaseTransperantView")! }
        static var lightGrayColor: UIColor { return UIColor(named: "lightGrayColor")! }
        
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}



extension String{
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidMobileNo() -> Bool {
        let mobileNoRegEx = "^614\\d{8}\\$+"
        let mobileTest = NSPredicate(format:"SELF MATCHES %@", mobileNoRegEx)
        return mobileTest.evaluate(with: self)
    }
    
    func ausMobileNoConvertTo0() -> String {
        return self.replacingOccurrences(of: "+61 ", with: "0")
    }
    
    func isValidPassword() -> Bool {
        let strPasswordValue = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strPasswordValue.count >= 8
    }
    
    func trimBlankSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
        func capitalizingFirstLetter() -> String {
          return prefix(1).uppercased() + self.lowercased().dropFirst()
        }

        mutating func capitalizeFirstLetter() {
          self = self.capitalizingFirstLetter()
        }
}

extension UIApplication{
    @available(iOS 13.0, *)
    var keyWindowRef:UIWindow?{
        return UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
    
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindowRef?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
    
}

extension UIAlertController {
    
    static func alertAfterDelay(WithMessage message: String, andTitle title: String = kAlert) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            UIAlertController.alert(message: message)
        }
    }
    
    static func alert(message: String, andSelectionHandler selectionHandler:((Int)->())? = nil) {
        self.showAlert(andMessage: message, andButtonTitles: [kOk], andSelectionHandler: selectionHandler)
    }
    
    static func showAlert(withTitle title:String = kAlert,andMessage message:String, andButtonTitles aryButtons:[String], andSelectionHandler selectionHandler:((Int)->())?) -> Void{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index,title) in aryButtons.enumerated(){
            let action = UIAlertAction.init(title: title, style: aryButtons.count == 1 ? UIAlertAction.Style.cancel : UIAlertAction.Style.default) { (alertAction) in
                selectionHandler?(index)
            }
            alertController.addAction(action)
        }
        
        if let rootController = UIApplication.getTopMostViewController(){
            rootController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showActionSheet(withTitle title:String = kAlert,andMessage message:String, andButtonTitles aryButtons:[String], andCancelButton cancelButtonTitle:String, andSelectionHandler selectionHandler:((Int)->())?) -> Void{
        
        let alertController = UIAlertController(title: title == "" ? nil : title, message: message == "" ? nil : message, preferredStyle: .actionSheet)
        
        let action = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertAction.Style.cancel) { (alertAction) in
            selectionHandler?(0)
        }
        alertController.addAction(action)
        
        for (index,title) in aryButtons.enumerated(){
            let action = UIAlertAction.init(title: title, style: UIAlertAction.Style.default) { (alertAction) in
                selectionHandler?(index+1)
            }
            alertController.addAction(action)
        }
        
        if let rootController = UIApplication.getTopMostViewController(){
            rootController.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIStoryboard {
    
    // all the storyboard we have in our application
    
    enum Storyboard: String {
        case Main
        
        var filename: String {
            //Note:- Make sure that you u have to add same as your storyboard name
           // if not then rawValue.capitalized are allways do your 1st letter in capitalized and other are make sure it's small letter
            print(rawValue.capitalized)
            return rawValue.capitalized
        }
    }
    
    
    // MARK: - Convenience Initializers
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    //go to StoryboardIdentifiable
  func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        print(T.storyboardIdentifier)

        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}

//MARK:- StoryboardIdentifier
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

//MARK:- StoryboardIdentifier
extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

//MARK:- UIViewController and StoryboardIdentifier
extension UIViewController : StoryboardIdentifiable { }
