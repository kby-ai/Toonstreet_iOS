//
//  MyListCollectionViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit
import FirebaseStorage
import SDWebImage
import Combine

class MyListCollectionViewCell: UICollectionViewCell {
    static let identifer = "MyListCollectionViewCell"
    
    private var subscriber: AnyCancellable?

    
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        self.imgViewProfile.image = UIImage()
//        self.imgViewProfile.image = UIImage.init(named: "dummy_image")
////        self.imgViewProfile.image = nil
//        self.imgViewProfile.sd_cancelCurrentImageLoad()
//
//    }
    

      override func prepareForReuse() {
          super.prepareForReuse()
          subscriber?.cancel()
          self.imgViewProfile?.image = UIImage(systemName: "dummy_image")
      }

      func setImage(to url: URL) {
          subscriber = TSImageManager.shared.imagePublisher(for: url, errorImage: UIImage(systemName: "dummy_image")).assign(to: \.self.imgViewProfile.image, on: self)
          
//              .assign(to: self.imgViewProfile.image ?? , on: self)
      }
    
    
    
    func setupCellData(objBook:TSBook){

        self.lblTitle.text = objBook.title
        self.lblAuthor.text = objBook.category
        
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
              if (url != nil) {
                  self.setImage(to: url!)
              }
          }
        }
        }
    }
}
