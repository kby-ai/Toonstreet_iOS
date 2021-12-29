//
//  DetailViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import FirebaseStorage
import SDWebImage

class DetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objBook:TSBook?
    var isPass:Bool?
    var objReadingDict:NSDictionary?

    var arrGenre:[String] = []//["Action","Adventure","Comedy","Drama","Fantasy","Game"]
    
    @IBOutlet weak var lblTitle2: TSLabel!
    @IBOutlet weak var lblStatus: TSLabel!
    @IBOutlet weak var lblAltTitle: TSLabel!
//    @IBOutlet weak var lblTitle2: UIView!
    @IBOutlet weak var lblAuther: TSLabel!
    @IBOutlet weak var lblPublisher: TSLabel!
    @IBOutlet weak var lblDetails: TSLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentController: TSScollViewSegment!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnSubscribe: TSButton!
    @IBOutlet weak var lblStaticRating: TSLabel!
    @IBOutlet weak var lblRateValue: TSLabel!
//    @IBOutlet weak var lblAuther: TSLabel!
    @IBOutlet weak var lblTitle: TSLabel!
    @IBOutlet weak var viewEpisod: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var tblEpisod: UITableView!
    @IBOutlet weak var lblEpisodesTitle: TSLabel!
    @IBOutlet weak var genreCollectionView: GenreCollectionView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet var collectionViewHeight:NSLayoutConstraint!
    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var mainView:UIView!
    
    @IBOutlet weak var lblAuther2: TSLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.tabBarController?.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        self.tblEpisod.reloadData()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setupUI() {
        
//        arrGenre
        self.leftBarButtonItems = [.BackArrow]

        self.scrollView.resizeScrollViewContentSize()
//        self.tblEpisod.register(UINib.init(nibName: "EpisodesTableCell", bundle: nil), forCellReuseIdentifier:"EpisodesTableCell")
        
        self.lblEpisodesTitle.font = UIFont.font_extrabold(15)
        self.lblEpisodesTitle.textColor = UIColor.Theme.textYellowColor
        
        self.tblEpisod.register(UINib.init(nibName: "EpisodesTableCell", bundle: nil), forCellReuseIdentifier: "EpisodesTableCell")

        
//        print(self.objBook?.category)
        
        self.loadCollectionView()
        
        self.tblEpisod.dataSource = self
        self.tblEpisod.delegate = self
        self.tblEpisod.separatorStyle = .none
        
        DispatchQueue.main.async {
            self.imgProduct.layer.cornerRadius = 10
            self.imgProduct.clipsToBounds = true
            self.btnSubscribe.setTitleColor(UIColor.black, for: .normal)
            
        }
            

        self.lblTitle.font = .font_extrabold(18)
        self.lblAuther.font = .font_semibold(12)
        self.lblRateValue.font = .font_semibold(12)
        self.lblStaticRating.font = .font_semibold(12)
        // Segment Controller
        segmentController.segmentStyle = .textOnly
        segmentController.insertSegment(withTitle: "Episodes", at: 0)
        segmentController.insertSegment(withTitle: "Details", at: 1)
        segmentController.selectedSegmentIndex = 0
        segmentController.underlineSelected = true
        
        if segmentController.selectedSegmentIndex == 0{
            viewEpisod.isHidden = false
            viewDetails.isHidden = true
        }else{
            viewEpisod.isHidden = true
            viewDetails.isHidden = false
        }
        segmentController.addTarget(self, action: #selector(self.segmentSelected(sender:)), for: .valueChanged)

          // change some colors
        segmentController.segmentContentColor = UIColor.gray
        segmentController.selectedSegmentContentColor = UIColor.white
        segmentController.backgroundColor = UIColor.Theme.themeBlackColor
        segmentController.tintColor = UIColor.white
        
          // Turn off all segments been fixed/equal width.
          // The width of each segment would be based on the text length and font size.
          segmentController.fixedSegmentWidth = true
      
        
        self.lblEpisodesTitle.text = self.objBook?.title
        self.lblDetails.text = self.objBook?.synopsis
        self.lblAuther.text = self.objBook?.publisher
//        self.lblAuther2.text = self.objBook?.publisher
        self.lblTitle2.text = self.objBook?.title
        self.lblTitle.text = self.objBook?.title
        self.lblPublisher.text = "By \(self.objBook?.publisher ?? "")"

    }
    @objc func segmentSelected(sender:TSScollViewSegment) {
          print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        if sender.selectedSegmentIndex == 0{
            viewEpisod.isHidden = false
            viewDetails.isHidden = true
        }else{
            viewEpisod.isHidden = true
            viewDetails.isHidden = false
            self.genreCollectionView.reloadData()
        }
      }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        self.lblTitle.text = self.objBook?.title ?? "OVERLOAD"
        self.lblAuther.text = self.objBook?.publisher ?? ""
//        self.navigationController?.navigationBar.topItem?.title = self.objBook?.title
        self.setupCoverImage()
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight(){
       
        let height = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    private func loadCollectionView(){
        
        self.arrGenre = self.objBook?.category.components(separatedBy: ",") ?? []

        self.genreCollectionView.loadItems(items: self.arrGenre)
        self.contentView.layoutIfNeeded()
        self.viewDetails.layoutIfNeeded()
    }
    
    //MARK: Button Action
    @IBAction func btnShareClicked(_ sender: Any) {
        
//        let fileURL = NSURL(fileURLWithPath: self.objBook.d)
        let shareTitle = self.objBook?.title
        let shareImage = self.imgProduct.image
        let shareDetail = self.objBook?.synopsis

        // Create the Array which includes the files you want to share
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(shareTitle)
        filesToShare.append(shareImage)
        filesToShare.append(shareDetail)

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnSubscribeClicked(_ sender: Any) {
    }
    
    
    func setupCoverImage(){
        if self.objBook?.cover != ""{
        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: self.objBook?.cover ?? "")

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
  
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
                      self?.imgProduct.image = img

                  }
              )
              
          }
        }

        }
    }
    
 
    
    //MARK: Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objBook?.episodes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EpisodesTableCell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableCell") as! EpisodesTableCell
//        let cell:EpisodesTableCell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableCell") as! EpisodesTableCell
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0{
            cell.viewBack.backgroundColor = UIColor.Theme.themeBlackColor
        }else{
            cell.viewBack.backgroundColor = UIColor.Theme.themeLightBlackColor
        }
        cell.setupEpisodCell(objEpisode: objBook?.episodes[indexPath.row] ?? TSEpisodes())
        cell.btnInfo.tag = indexPath.row
        cell.btnInfo.addTarget(self, action: #selector(self.btnInfoClicked(_sender:)), for: .touchUpInside)
        
        cell.lblTitle.text = "Episode \(indexPath.row + 1)"
        
        if objBook?.index.count ?? 0 > 0 {
            if (objBook?.index.contains(indexPath.row) == true){
                cell.btnDownload.isHidden = true
                objBook?.episodes[indexPath.row].isPurchased = 1
            }else{
                objBook?.episodes[indexPath.row].isPurchased = 0
                cell.btnDownload.isHidden = false
                cell.btnDownload.tag = indexPath.row
                cell.btnDownload.addTarget(self, action: #selector(self.btnPurchaseClicked(_sender: )), for: .touchUpInside)
            }
        }else{
            cell.btnDownload.isHidden = false
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(self.btnPurchaseClicked(_sender: )), for: .touchUpInside)
        }
    
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PDFViewController
        
        if self.objBook?.episodes[indexPath.row].isPurchased == 1{
        if let objPDFVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController{
//            self.hidesBottomBarWhenPushed = true
            objPDFVC.selectedComic = self.objBook
            objPDFVC.bookTitle = self.objBook?.title ?? ""
            objPDFVC.episodeList = self.objBook?.episodes[indexPath.row].strContent
            objPDFVC.selectedEpisode = self.objBook?.episodes[indexPath.row]

            if indexPath.row + 1 == self.objBook?.episodes.count{
                objPDFVC.isLastEpisode = true
            }
            objPDFVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

            objPDFVC.blockDetailButtonClicked = { [unowned self]() in
                        if let objAllEpisodeVC = self.storyboard?.instantiateViewController(withIdentifier: "EpidsodeDetailsViewController") as? EpidsodeDetailsViewController{
                            objAllEpisodeVC.episodes = self.objBook?.episodes[indexPath.row]
                            objAllEpisodeVC.bookTitle = self.objBook?.title ?? ""
                            objAllEpisodeVC.episodeList = self.objBook?.episodes[indexPath.row].strContent
                            objAllEpisodeVC.selectedComic = self.objBook
                            objAllEpisodeVC.isFromBlock = true
                            objAllEpisodeVC.blockRedirectToPDF = {

                                    self.navigationController?.present(objPDFVC, animated: false, completion: nil)

                            }
                            self.navigationController?.pushViewController(objAllEpisodeVC, animated: true)
                        }
            }

            
            
            self.navigationController?.present(objPDFVC, animated: true, completion: nil)

//            self.navigationController?.pushViewController(objPDFVC, animated: true)
        }
        }else{
            print("Please purchase book")
            UIAlertController.alert(message: "Please purchase book.")

//
            }
        }
    
    
@objc func btnPurchaseClicked(_sender:UIButton){
    
    let indexPath = _sender.tag
    
    UIAlertController.showAlert(andMessage: "Are you sure you want to purchase this episode", andButtonTitles: ["YES","Not now"]) { index in
                if index == 0{
//self.objBook ?? TSBook()
                    var purchasedDict = NSMutableDictionary()
                    
                    let purchasedDict1 =  TSFirebaseAPI.shared.arrPopularComicDict.filter({$0.value(forKey: "title" ) as? String == self.objBook?.title})
                    
                    if purchasedDict1.count > 0{
                        purchasedDict = purchasedDict1[0] as! NSMutableDictionary
                    }else{
                        let purchasedDict2 =  TSFirebaseAPI.shared.arrNewReleaseDict.filter({$0.value(forKey: "title" ) as? String == self.objBook?.title})
                        
                        if purchasedDict2.count > 0{
                            purchasedDict = purchasedDict2[0] as! NSMutableDictionary
                        }
                    }
                                     
                    TSFirebaseAPI.shared.purchaseBook(bookCoin: 4, book: purchasedDict , episode: indexPath) { [unowned self] status in
                        if status == true{
                            self.objBook?.isPurchased = 1
                            self.objBook?.episodes[index].isPurchased = 1
                            self.objBook?.index.append(indexPath)
                            UIAlertController.showAlert(withTitle: "Success!", andMessage: "Episode purchased successfully", andButtonTitles: ["OK"]){ [unowned self] index in

                                if let objPDFVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController{
                        //          self.hidesBottomBarWhenPushed = true

                                    objPDFVC.selectedComic = self.objBook
                                    objPDFVC.bookTitle = self.objBook?.title ?? ""
                                    objPDFVC.episodeList = self.objBook?.episodes[indexPath].strContent

                                    
                                    if index + 1 == self.objBook?.episodes.count{
                                        objPDFVC.isLastEpisode = true
                                    }
                                    objPDFVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

                                    self.navigationController?.present(objPDFVC, animated: true, completion: nil)

//                                    self.navigationController?.pushViewController(objPDFVC, animated: true)
                                }
                            }
                        }else{
                            self.self.objBook?.episodes[indexPath].isPurchased = 0
                        }
                    }
                }
        }
}
    @objc func btnInfoClicked(_sender:UIButton){
        let index = _sender.tag
        if let objPDFVC = self.storyboard?.instantiateViewController(withIdentifier: "EpidsodeDetailsViewController") as? EpidsodeDetailsViewController{
            objPDFVC.episodes = self.objBook?.episodes[index]
            objPDFVC.bookTitle = self.objBook?.title ?? ""
            objPDFVC.episodeList = self.objBook?.episodes[index].strContent
            objPDFVC.selectedComic = self.objBook

//            if index == self.objBook?.episodes.count ?? 0 - 1{
//                objPDFVC.isLastEpisode = true
//            }
            
        self.navigationController?.pushViewController(objPDFVC, animated: true)
        }
    }
}
/*
extension DetailViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrGenre.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as? GenreCollectionCell
 else { preconditionFailure("Faile?d to load collection view cell") }
        cell.strCategory = self.arrGenre[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let handler = self.didSelectBookSelectionHandler{
//            handler(self.arrGenre,indexPath.item)
//        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let label = TSLabel(frame: CGRect.zero)
//        label.text = arrGenre[indexPath.item]
//        label.sizeToFit()
//        return CGSize(width:200, height: 32)//label.frame.width + 50
//
//    }
//
    

    
    
}
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//                let label = TSLabel(frame: CGRect.zero)
//                label.text = arrGenre[indexPath.item]
//        label.font = UIFont.font_semibold(15)
//                label.sizeToFit()
//                return CGSize(width: label.frame.width+20, height: label.frame.height+20)
        let item = arrGenre[indexPath.item]
                let itemSize = item.size(withAttributes: [
                    NSAttributedString.Key.font : UIFont.font_semibold(15)
                ])
        print("Cell:: Index :: \(indexPath.item) Cell Size :: \(itemSize.width+20) * \(itemSize.height+20)")
        return CGSize(width: itemSize.width + 20 , height: itemSize.height+20)


        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
}
 */

extension UIScrollView {

    func resizeScrollViewContentSize() {

        var contentRect = CGRect.zero

        for view in self.subviews {

            contentRect = contentRect.union(view.frame)

        }

        self.contentSize = contentRect.size

    }

}

