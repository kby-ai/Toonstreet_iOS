//
//  NewReleaseTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import Combine
import FirebaseStorage
import SDWebImage
class NewReleaseTableViewCell: UITableViewCell {
    
    var arrComic:[TSBook] = []
    var selectedIndex = 0;
    typealias NewReleaseComic = ((TSBook)->(Void))
    
    var blockNewReleaseComic:NewReleaseComic?
    
    private var subscriber: AnyCancellable?

    @IBOutlet weak var btnReleaseAll: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
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
        
     
        self.bookPhotoView.clipsToBounds = true
        self.bookPhotoView.layer.cornerRadius = 10
        self.bookPhotoView.layer.masksToBounds = true
        self.bookPhotoView.layer.borderColor = UIColor.white.cgColor
        self.bookPhotoView.layer.borderWidth = 5.0
                
        self.pageController.numberOfPages = self.arrComic.count
        //self.addBlurEffect()
        self.setupGesture()
        
        
//        self.continueReadingCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
//
//            if let value = self?.didSelectCellItem{
//                value(HomeType.ReleaseSoon,aryBook[index])
//            }
//        }
        
    }
    
    func setupData(index:Int){
        
        self.lblBookTitle.text = arrComic[index].title//"OVERLORD"
        self.lblBookTitle.numberOfLines = 1
        self.lblBookTitle.textColor = UIColor.white
        self.lblBookTitle.font = UIFont.font_extrabold(16.0)
       
        self.lblBookType.text = arrComic[index].category//"Action, Mystery, Comedy"
        self.lblBookType.numberOfLines = 1
        self.lblBookType.textColor = UIColor.white
        self.lblBookType.font = UIFont.appFont_FontRegular(Size: 10.0)
        
        self.lblBookSubTitle.text = "Synopsis"
        self.lblBookSubTitle.numberOfLines = 1
        self.lblBookSubTitle.textColor = UIColor.white
        self.lblBookSubTitle.font = UIFont.appFont_Bold(Size: 10)
        
        
        self.lblBookDescription.text =  arrComic[index].synopsis//"The final hour of the popular virtual reality game Yggdrasil has come. However, Momonga, a powerful wi..."
        self.lblBookDescription.numberOfLines = 3
        self.lblBookDescription.textColor = UIColor.white
        self.lblBookDescription.font = UIFont.font_regular(10.0)
        
        self.pageController.isUserInteractionEnabled = false
    
        self.pageController.currentPage = index
    
        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: arrComic[selectedIndex].cover )
         
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
         
              if (url != nil) {
                  self.imageViewBookPhoto.sd_setImage(with: url, completed: nil)
                  self.imageViewBookCoverPhoto.sd_setImage(with: url, completed: nil)

              }
          }
        }
        
        
//        self.imageViewBookPhoto.image
    }
    
  
func didSelectCellItem(withHandler handler:HomeScreenBookTableViewCellSelectionHandler?){
    if let value = handler{
        self.didSelectCellItem = value
    }
}

  
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return arrComic.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
    func addAndReloadCell(arr:[TSBook]){
          
        self.arrComic = arr
        self.pageController.numberOfPages = self.arrComic.count
        if  self.arrComic.count > 0{
            self.setupData(index: selectedIndex)

        }

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
    
    private func setupGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.viewPDF.addGestureRecognizer(swipeRight)
        self.mainView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.viewPDF.addGestureRecognizer(swipeLeft)
        self.mainView.addGestureRecognizer(swipeLeft)

        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didPressPartButton))
        singleTapGesture.numberOfTapsRequired = 1
        self.mainView.addGestureRecognizer(singleTapGesture)
        
        
    }
    
    
    @objc func didPressPartButton(gesture: UIGestureRecognizer) {
        print(didPressPartButton)
        
        if blockNewReleaseComic != nil{
            blockNewReleaseComic!(self.arrComic[selectedIndex])
        }
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.left:
                    print("Swiped Left")

                    selectedIndex = selectedIndex + 1

                    if selectedIndex < self.arrComic.count {

                        if arrComic.count > 0{
                                self.setupData(index: selectedIndex)

                            }

                        }else{ selectedIndex = selectedIndex - 1}

                    
                case UISwipeGestureRecognizer.Direction.right:
                    print("Swiped right")
                    
                    if selectedIndex > 0 {
                        selectedIndex = selectedIndex - 1
                        
                        if arrComic.count > 0{
                            self.setupData(index: selectedIndex)
                        }

                        
                    }
                   
//                    if pdfView.canGoToPreviousPage {
//                        pdfView.goToPreviousPage(nil)
//                    }
                default:
                    break
                }
            }
        }
    
    
    func setImage(to url: URL , imageView:UIImageView) {
//        subscriber = TSImageManager.shared.imagePublisher(for: url, errorImage: UIImage(systemName: "dummy_image")).assign(to: \.imageView?.image, on: self)
        
//              .assign(to: self.imgViewProfile.image ?? , on: self)
    }
}
