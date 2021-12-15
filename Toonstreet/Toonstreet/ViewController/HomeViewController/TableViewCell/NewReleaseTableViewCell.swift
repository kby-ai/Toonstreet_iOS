//
//  NewReleaseTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class NewReleaseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var lblSubTitle:TSLabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var viewData:UIView!
    @IBOutlet weak var imageViewBookCoverPhoto:UIImageView!
    @IBOutlet weak var coverPhotoBlurView:UIView!
    @IBOutlet weak var bookPhotoView:UIView!
    @IBOutlet weak var imageViewBookPhoto:UIImageView!
    @IBOutlet weak var labelView:UIView!
    @IBOutlet weak var lblBookTitle:TSLabel!
    @IBOutlet weak var lblBookType:TSLabel!
    @IBOutlet weak var lblBookSubTitle:TSLabel!
    @IBOutlet weak var lblBookDescription:TSLabel!
    @IBOutlet weak var pageView:UIView!
    private var didSelectCellItem:HomeScreenBookTableViewCellSelectionHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.commonInit()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func commonInit(){
        self.lblTitle.text = "New Release!"
        self.lblTitle.numberOfLines = 1
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.appFont_Bold(Size: 20)
        
        
        self.lblSubTitle.text = "Read the latest comic recommendations"
        self.lblSubTitle.numberOfLines = 0
        self.lblSubTitle.textColor = UIColor.white
        self.lblSubTitle.font = UIFont.appFont_FontRegular(Size: 10.0)
        
        
        self.mainView.backgroundColor = UIColor.Theme.themeBlackColor
        self.viewData.backgroundColor = UIColor.clear
        self.viewData.layer.cornerRadius = 10
        self.viewData.layer.masksToBounds = true
        self.viewData.clipsToBounds = true 
        
        self.coverPhotoBlurView.backgroundColor = UIColor.Theme.newReleaseTransparentBlackColor
        
        self.labelView.backgroundColor = UIColor.clear
        self.labelView.clipsToBounds = true
        
        self.lblBookTitle.text = "OVERLORD"
        self.lblBookTitle.numberOfLines = 1
        self.lblBookTitle.textColor = UIColor.white
        self.lblBookTitle.font = UIFont.font_extrabold(16.0)
       
        self.lblBookType.text = "Action, Mystery, Comedy"
        self.lblBookType.numberOfLines = 1
        self.lblBookType.textColor = UIColor.white
        self.lblBookType.font = UIFont.appFont_FontRegular(Size: 10.0)
        
        self.lblBookSubTitle.text = "Synopsis"
        self.lblBookSubTitle.numberOfLines = 1
        self.lblBookSubTitle.textColor = UIColor.white
        self.lblBookSubTitle.font = UIFont.appFont_Bold(Size: 10)
        
        
        self.lblBookDescription.text = "The final hour of the popular virtual reality game Yggdrasil has come. However, Momonga, a powerful wi..."
        self.lblBookDescription.numberOfLines = 3
        self.lblBookDescription.textColor = UIColor.white
        self.lblBookDescription.font = UIFont.font_regular(10.0)
     
        self.bookPhotoView.clipsToBounds = true
        self.bookPhotoView.layer.cornerRadius = 10
        self.bookPhotoView.layer.masksToBounds = true
        self.bookPhotoView.layer.borderColor = UIColor.white.cgColor
        self.bookPhotoView.layer.borderWidth = 5.0
        
       
        
        //self.addBlurEffect()
    }
    private func addBlurEffect(){
        //self.coverPhotoBlurView.alpha = 0.85
        let blurEffect = UIBlurEffect(style: .extraLight)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = UIColor.Theme.newReleaseTransparentBlackColor
        self.coverPhotoBlurView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.viewData.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: self.viewData.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: self.viewData.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: self.viewData.widthAnchor)
        ])
        
//        // 1
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        // 2
//        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
//        // 3
//        //vibrancyView.contentView.addSubview(optionsView)
//        // 4
//        blurView.contentView.addSubview(vibrancyView)
//
//        NSLayoutConstraint.activate([
//          vibrancyView
//            .heightAnchor
//            .constraint(equalTo: blurView.contentView.heightAnchor),
//          vibrancyView
//            .widthAnchor
//            .constraint(equalTo: blurView.contentView.widthAnchor),
//          vibrancyView
//            .centerXAnchor
//            .constraint(equalTo: blurView.contentView.centerXAnchor),
//          vibrancyView
//            .centerYAnchor
//            .constraint(equalTo: blurView.contentView.centerYAnchor)
//        ])
        
    }
}
