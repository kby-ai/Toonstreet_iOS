//
//  GenreCollectionCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 23/11/21.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    static let identifer = "GenreCollectionCellIdentifier"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBack: UIView!
    var strCategory:String = ""{
        didSet{
            self.updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.commonInit()
    }
    
    
    private func commonInit(){
       
        self.viewBack.layer.cornerRadius = 10
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.font_semibold(15)
        self.viewBack.clipsToBounds = true
        
        self.viewBack.layer.borderColor = UIColor.lightGray.cgColor
        self.viewBack.layer.borderWidth  = 1.0
        
    }
    private func updateUI(){
        self.lblTitle.text = strCategory
    
        
    }
    
}
