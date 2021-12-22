//
//  PDFViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit
import PDFKit
import WebKit
import FirebaseStorage
import SDWebImage

class PDFViewController: BaseViewController {

    var isLastEpisode:Bool?
    var episodeList:[String]?
    var bookTitle:String?
    var passIndex:Int = 0
    var selectedIndex:Int = 0
    var selectedComic:TSBook?
    
    @IBOutlet weak var webKit: WKWebView!
    @IBOutlet weak var imgComic: UIImageView!

    @IBOutlet weak var btnPrevious:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var viewPDF: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.passIndex != 0) {
            self.selectedIndex = passIndex
        }else{
            self.selectedIndex = 0
        }
//        self.leftBarButtonItems = [.BackArrow]
        self.rightBarButtonItems = [.close]

//        self.setupPDFView()
        self.setupGesture()
        self.imgComic.enableZoom()
        self.addContinueReading()
            
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.tabBarController?.tabBar.isHidden = true///false
        
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
  
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Add Continue reading
    func addContinueReading(){
    
        self.selectedComic?.isReadStatus = 1
        self.selectedComic?.lastIndex = self.selectedIndex
        
        TSFirebaseAPI.shared.AddContinueReadingData(readingUserID: self.bookTitle ?? "", comic: self.selectedComic ?? TSBook(), comicIndex: self.episodeList ?? [""])
    }
    
    
    func removeContinueReading(){
        TSFirebaseAPI.shared.RemoveContinueReadingData(readingUserID: self.bookTitle ?? "")
    }
    

    private func setupGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.up
//        self.viewPDF.addGestureRecognizer(swipeRight)
        self.imgComic.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.down
//        self.viewPDF.addGestureRecognizer(swipeLeft)
        self.imgComic.addGestureRecognizer(swipeLeft)

    }
    private func updateButtonViewUI(){
        if selectedIndex == 0{
            self.btnPrevious.isEnabled = false
        }else{
            self.btnPrevious.isEnabled = true
        }
        
        if selectedIndex + 1 == self.episodeList?.count{
            self.btnNext.isEnabled = false
        }else{
            self.btnNext.isEnabled = true
        }
        
//        if pdfView.canGoToPreviousPage{
//            self.btnPrevious.isEnabled = true
//        }
//        else {
//            self.btnPrevious.isEnabled = false
//        }
//        if pdfView.canGoToNextPage{
//            self.btnNext.isEnabled = true
//
//        }else {
//            self.btnPrevious.isEnabled = false
//        }
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.up:
                    print("Swiped Left")
//                    if pdfView.canGoToNextPage {
//                        pdfView.goToNextPage(nil)
//                    }
                    
                    
                    selectedIndex = selectedIndex + 1

                        if selectedIndex < self.episodeList?.count ?? 0{

                            
                            if episodeList?.count ?? 0 > 0{

                            let storage = Storage.storage()
                            let starsRef = storage.reference(forURL: episodeList?[selectedIndex] ?? "")
                             
                            starsRef.downloadURL { url, error in
                              if let error = error {
                                // Handle any errors
                                  print(error)
                              } else {
                                // Get the download URL for 'images/stars.jpg'
                             
                                  if (url != nil) {
                                      self.imgComic.sd_setImage(with: url, completed: nil)
                                      self.imgComic.slideUpFromBottom()
                                  }
                              }
                            }
                            }

                        }else{ selectedIndex = selectedIndex - 1}
                    updateButtonViewUI()

                    
                case UISwipeGestureRecognizer.Direction.down:
                    print("Swiped right")
                    
                    if selectedIndex > 0 {
                        selectedIndex = selectedIndex - 1
                        
                        if episodeList?.count ?? 0 > 0{

                        let storage = Storage.storage()
                        let starsRef = storage.reference(forURL: episodeList?[selectedIndex] ?? "")
                         
                        starsRef.downloadURL { url, error in
                          if let error = error {
                            // Handle any errors
                              print(error)
                          } else {
                            // Get the download URL for 'images/stars.jpg'
                         
                              if (url != nil) {
                                  self.imgComic.sd_setImage(with: url, completed: nil)
                                  self.imgComic.slideUpFromTop()

                              }
                          }
                        }
                        }

                        
                    }
                   
                    updateButtonViewUI()
//                    if pdfView.canGoToPreviousPage {
//                        pdfView.goToPreviousPage(nil)
//                    }
                default:
                    break
                }
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.topItem?.title = bookTitle ?? ""

        self.addCoverImage()
       
        
        
        addContinueReading();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addContinueReading();

        if isLastEpisode == true && selectedIndex + 1 == self.episodeList?.count{
            removeContinueReading()
        }
    }
    
    func addCoverImage(){
        if episodeList?.count ?? 0 > 0{

        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: episodeList?[selectedIndex] ?? "")
         
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
         
              if (url != nil) {
                  self.imgComic.sd_setImage(with: url, completed: nil)
              }
          }
        }
        }
    }
    
    @IBAction func btnPreviousClick(_ sender: Any) {
        
        if selectedIndex > 0 {
            selectedIndex = selectedIndex - 1
        }
        
        if episodeList?.count ?? 0 > 0{

        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: episodeList?[selectedIndex] ?? "")
         
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
         
              if (url != nil) {
                  self.imgComic.sd_setImage(with: url, completed: nil)
              }
          }
        }
        }
        updateButtonViewUI()
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        
        selectedIndex = selectedIndex + 1

        if selectedIndex < self.episodeList?.count ?? 0 {
        
        
        if episodeList?.count ?? 0 > 0{

        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: episodeList?[selectedIndex] ?? "")
         
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
         
              if (url != nil) {
                  self.imgComic.sd_setImage(with: url, completed: nil)
              }
          }
        }
        }
        }else{
            selectedIndex = selectedIndex - 1
        }
        updateButtonViewUI()
    }
    
    
    
}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
extension UITabBar {
func tabsVisiblty(_ isVisiblty: Bool = true){
    if isVisiblty {
        self.isHidden = false
        self.layer.zPosition = 0
    } else {
        self.isHidden = true
        self.layer.zPosition = -1
    }
}
}


extension UIView {
   // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    
    func slideUpFromTop(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()

        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }

        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed

        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    
    func slideUpFromBottom(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()

        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }

        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromTop
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed

        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}
