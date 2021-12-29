//
//  PDFTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/12/21.
//

import UIKit
import SDWebImage
import FirebaseStorage

class PDFTableViewCell: UITableViewCell {

    @IBOutlet weak var imgComic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgComic.enableZoom()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(imgUrl:String){
        
        if imgUrl != ""{
        let storage = Storage.storage()
            let starsRef = storage.reference(forURL: imgUrl)

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
//              print(url)
              self.imgComic.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached)

          }
        }

        }
    }
    
}
