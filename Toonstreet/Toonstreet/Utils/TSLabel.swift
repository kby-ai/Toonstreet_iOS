

import UIKit

class TSLabel: UILabel {
    
    
    //MARK:- Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    //MARK:- Common Init
    func commonInit() -> Void
    {
        self.numberOfLines = 0
        //Kavin-Update
        self.font = self.font.withSize(self.font.pointSize.proportionalFontSize());
        //self.textColor = self.isDarkMode() ? UIColor.lightGray : UIColor.black
        // Write common things here
        // E.g Set common label font size and color here
    }

}
