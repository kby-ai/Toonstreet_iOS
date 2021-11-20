//
//  ResumeReadingCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class ResumeReadingCollectionViewCell: UICollectionViewCell {
    static let identifer = "ResumeReadingCollectionViewCellIdentifier"
    
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var imgViewProfile:UIImageView!
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var lblAuthor:TSLabel!
    
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
        self.imgViewProfile.layer.cornerRadius = 14.0
        self.imgViewProfile.layer.masksToBounds = true
        
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.font_extrabold(16.0)
        self.lblTitle.text = "Blush-DC: Himitsu"
        
        
        self.lblAuthor.textColor = UIColor.white
        self.lblAuthor.font = UIFont.font_regular(14.0)
        self.lblAuthor.text = "Romance"
        
        self.mainView.backgroundColor = UIColor.clear
    }
}
