//
//  EpidsodeDetailsViewController.swift
//  Toonstreet
//
//  Created by kavin soni on 21/12/21.
//

import UIKit
import SDWebImage
import FirebaseStorage

class EpidsodeDetailsViewController: BaseViewController {

    var isLastEpisode:Bool?
    var episodeList:[String]?
    var bookTitle:String?
    var passIndex:Int = 0
    var selectedIndex:Int = 0
    var episodes:TSEpisodes?
    var selectedComic:TSBook?
    
    
    @IBOutlet weak var lblProduction: TSLabel!
    @IBOutlet weak var lblTitle: TSLabel!
    @IBOutlet weak var imgEpisode: UIImageView!
    
    @IBOutlet weak var lblDetails: TSLabel!
    
    @IBOutlet weak var lblAutherStatic: TSLabel!
    @IBOutlet weak var lblAuther1: TSLabel!
    @IBOutlet weak var lblWriterStatic: TSLabel!
    
    @IBOutlet weak var lblWriter: TSLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
        // Do any additional setup after loading the view.
    }

    
    override func setupUI() -> Void {
        
        self.lblTitle.font = .font_extrabold(18)
//        self.lblAuther.font = .font_semibold(12)
//        self.lblRateValue.font = .font_semibold(12)
//        self.lblStaticRating.font = .font_semibold(12)
        self.leftBarButtonItems = [.BackArrow]


    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    func setupData(){
        self.lblProduction.text = ""//"By \(episodes?.artist)"
        if episodes?.title != ""{
            self.lblTitle.text = episodes?.title
        }else{
            self.lblTitle.text = "Episode \(selectedIndex + 1)"
        }
        
        self.lblDetails.text = episodes?.strDescription
        self.lblWriter.text = episodes?.writer
        self.lblAuther1.text = episodes?.artist
        
        if self.episodes?.cover != ""{
        let storage = Storage.storage()
            let starsRef = storage.reference(forURL: self.episodes?.cover ?? "")

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
//              print(url)
              self.imgEpisode.sd_setImage(with: url, completed: nil)

          }
        }

        }
        
        
        
    }
    @IBAction func btnReadClick(_ sender: Any) {
        
        if let objPDFVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController{
//            self.hidesBottomBarWhenPushed = true
            objPDFVC.selectedComic = self.selectedComic
            objPDFVC.bookTitle = self.bookTitle
            objPDFVC.episodeList = self.episodeList
            objPDFVC.isLastEpisode = self.isLastEpisode
            
            self.navigationController?.pushViewController(objPDFVC, animated: true)
        }
        
        
    }
    
}
