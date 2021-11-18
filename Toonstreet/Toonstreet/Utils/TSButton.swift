import UIKit


enum TSButtonType {
    case none
    case solid
    case image(image:UIImage)
    
}
class TSButton: UIButton {
    
    var tsButtonType:TSButtonType = .solid{
        didSet{
            self.updateUIAccordingToButtonType()
        }
    }
    
    private let solidButtonColor = UIColor.yellow
    
    
    //MARK:- Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    //MARK:- Private Helper Methods
    fileprivate func commonInit()->(){
        self.isExclusiveTouch = true
        
        self.updateUIAccordingToButtonType()
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        if let availableSubView = self.imageView{
            self.bringSubviewToFront(availableSubView)
//            availableSubView.contentMode = .center
        }
    }
    
    func updateUIAccordingToButtonType() -> Void {
        switch self.tsButtonType {
        case .none:
            
            break
        case .solid:
            self.layer.cornerRadius = 5.0
         
            self.layer.cornerRadius = 10//self.layer.frame.size.height/1.7
            self.layer.masksToBounds = true
            self.backgroundColor = UIColor.Theme.textYellowColor
            self.setTitleColor(UIColor.Theme.themeBlackColor, for: .normal)
            self.titleLabel?.font = UIFont.appFont_Bold(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))
            self.layoutIfNeeded()
            self.titleLabel?.textColor = UIColor.Theme.themeBlackColor
            
            break
        case .image(image: let image):
            self.backgroundColor = UIColor.clear
            self.setTitle("", for: .normal)
            self.setImage(image, for: .normal)
        default:

            self.setTitleColor(UIColor.white, for: UIControl.State.normal)

            break
            
        }
    }
}

