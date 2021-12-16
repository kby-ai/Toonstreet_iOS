//
//  ReleaseSoonCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import SDWebImage
import FirebaseStorage

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.imgViewBookProfile.image = UIImage()
////        self.imgViewBookProfile.image = nil
        self.imgViewBookProfile.image = UIImage.init(named: "dummy_image")
//
//        self.imgViewBookProfile.sd_cancelCurrentImageLoad()
//        self.imgViewBookProfile.image = nil
        self.imgViewBookProfile.sd_cancelCurrentImageLoad()
        
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
    
    func setupCellData(objBook:TSBook){

        self.lblTitle.text = objBook.title
        self.lblType.text = objBook.category
        
        if objBook.cover != ""{

        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: objBook.cover)

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
              print(url)
//              self.imgViewBookProfile.sd_imageIndicator = SDWebImageActivityIndicator.white
////              self.imgViewBookProfile.sd_setImage(with: url, completed: nil)
//              self.imgViewBookProfile.sd_setImage(with: url, placeholderImage: UIImage(named: ""))

              SDWebImageManager.shared.loadImage(
                with: url,//.(imageShape: .square),
                options: .handleCookies, // or .highPriority
                  progress: nil,
                  completed: { [weak self] (image, data, error, cacheType, finished, url) in
                      guard let sself = self else { return }

                      if let err = error {
                          // Do something with the error
                          return
                      }

                      guard let img = image else {
                          // No image handle this error
                          return

                      }
                      self?.imgViewBookProfile.image = img

                  }
              )
              
              
          }
        }
        }
    }
    
}
