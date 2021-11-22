//
//  ContinueReadingCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class ContinueReadingCollectionViewCell: UICollectionViewCell {
    static let identifer = "ContinueReadingCollectionViewCellIdentifier"
    
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
    
    private func commonInit(){
        self.imgViewProfile.layer.cornerRadius = 10.0
        self.imgViewProfile.layer.masksToBounds = true
        
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.font_extrabold(14.0)
        self.lblTitle.text = "/Blush-DC: Himitsu"
        
        
        self.lblType.textColor = UIColor.white
        self.lblType.font = UIFont.font_regular(12.0)
        self.lblType.text = "Romance"
        
        self.mainView.backgroundColor = UIColor.clear
    }
}
