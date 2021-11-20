//
//  ReleaseSoonCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class ReleaseSoonCollectionViewCell: UICollectionViewCell {
    static let identifer = "ReleaseSoonCollectionViewCellIdentifier"
    
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var imgViewBookProfile:UIImageView!
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var lblType:TSLabel!
    @IBOutlet weak var titleView:UIView!
    
    
    
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
        
        self.mainView.layer.cornerRadius = 10.0
        self.mainView.layer.masksToBounds = true
        self.mainView.backgroundColor = UIColor.clear
        self.mainView.clipsToBounds = true
        
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.font_semibold(14.0)
        self.lblTitle.text = "Solo Leveling"
        
        
        self.lblType.textColor = UIColor.white
        self.lblType.font = UIFont.font_regular(10.0)
        self.lblType.text = "Action, Adventure, Fantasy, Shounen"
        
       
        self.titleView.backgroundColor = UIColor.Theme.transparentBlackColor
        
    }
}
