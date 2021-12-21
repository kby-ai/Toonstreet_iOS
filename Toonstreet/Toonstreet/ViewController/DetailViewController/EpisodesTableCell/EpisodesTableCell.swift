//
//  EpisodesTableCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import SDWebImage
import FirebaseStorage

class EpisodesTableCell: UITableViewCell {

    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblRates: TSLabel!
    @IBOutlet weak var lblTitle: TSLabel!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.imgBook.layer.cornerRadius = 10
            self.imgBook.clipsToBounds = true
            
            self.btnDownload.layer.cornerRadius = 10
            self.btnDownload.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupEpisodCell(objEpisode:TSEpisodes){
        
//        self.lblTitle.text = objEpisode.title
        btnDownload.setTitle("  \(objEpisode.price)", for: .normal)
        btnDownload.setTitleColor(UIColor.black, for: .normal)
//        btnDownload.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//        btnDownload.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//        btnDownload.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        
        if objEpisode.cover != ""{
        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: objEpisode.cover)

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
//              print(url)
              self.imgBook.sd_setImage(with: url, completed: nil)

          }
        }

        }
    }
    
}
