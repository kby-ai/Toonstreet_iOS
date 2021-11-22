//
//  SliderCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "SliderCollectionViewCellIdentifier"
    
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var lblValue:TSLabel!
    @IBOutlet weak var selectionIndicationView:UIView!
    var isCellSelected:Bool = false {
        didSet{
            self.updateUI()
        }
    }
    var item:String = ""{
        didSet{
            self.updateUI()
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func commonInit(){
       
        self.lblValue.textColor = UIColor.white
        self.lblValue.font = UIFont.font_regular(12.0)
        
        
        self.selectionIndicationView.backgroundColor = UIColor.white
        self.mainView.backgroundColor = UIColor.clear
    }
    private func updateUI(){
        self.lblValue.text = item
        self.selectionIndicationView.isHidden = !isCellSelected
        if self.isCellSelected {
            self.lblValue.textColor = UIColor.white
        }else {
            self.lblValue.textColor = UIColor.Theme.lightGrayColor
        }
    }
}
