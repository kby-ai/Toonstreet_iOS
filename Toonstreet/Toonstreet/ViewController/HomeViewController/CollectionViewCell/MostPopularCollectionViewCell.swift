//
//  MostPopularCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {
    static let identifer = "MostPopularCollectionViewCellIdentifier"
    
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var imgViewProfile:UIImageView!
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var lblType:TSLabel!
    
    
    var assetIdentifier: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    func updateUI(withIsHideType isHide:Bool){
        self.lblType.isHidden = isHide
    }
    private func commonInit(){
        self.imgViewProfile.layer.cornerRadius = 10.0
        self.imgViewProfile.layer.masksToBounds = true
        
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.font_extrabold(12.0)
        self.lblTitle.text = "Nanatsu no Taizai"
        
        
        self.lblType.textColor = UIColor.white
        self.lblType.font = UIFont.font_regular(10.0)
        self.lblType.text = "Fantasy, Shounen"
        
        self.mainView.backgroundColor = UIColor.clear
    }
}
