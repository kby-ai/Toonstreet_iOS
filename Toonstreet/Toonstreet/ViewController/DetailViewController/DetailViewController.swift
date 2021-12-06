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
    
    var arrGenre = ["Action","Adventure","Comedy","Drama","Fantasy","Game"]
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentController: TSScollViewSegment!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnSubscribe: TSButton!
    @IBOutlet weak var lblStaticRating: TSLabel!
    @IBOutlet weak var lblRateValue: TSLabel!
    @IBOutlet weak var lblAuther: TSLabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        self.collectionView.register(UINib.init(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView.collectionViewLayout = layout
//        self.collectionView.delegate = self
//
        
        layout.scrollDirection = .vertical //.horizontal
//        layout.itemSize = cellSize'
        layout.itemSize =  CGSize(width:100, height: 32)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)

        */
        
    }
        
    
    
    
    override func setupUI() {
        
        
       
        self.leftBarButtonItems = [.BackArrow]

        
        self.scrollView.resizeScrollViewContentSize()
//        self.tblEpisod.register(UINib.init(nibName: "EpisodesTableCell", bundle: nil), forCellReuseIdentifier:"EpisodesTableCell")
        
        self.lblEpisodesTitle.font = UIFont.font_extrabold(15)
        self.lblEpisodesTitle.textColor = UIColor.Theme.textYellowColor
        
        self.tblEpisod.register(UINib.init(nibName: "EpisodesTableCell", bundle: nil), forCellReuseIdentifier: "EpisodesTableCell")

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
        
        if self.objBook?.cover != ""{
        let storage = Storage.storage()
        let starsRef = storage.reference(forURL: self.objBook?.cover ?? "")

//         Fetch the download URL
        starsRef.downloadURL { url, error in
          if let error = error {
            // Handle any errors
              print(error)
          } else {
            // Get the download URL for 'images/stars.jpg'
//              print(url)
              self.imgProduct.sd_setImage(with: url, completed: nil)

          }
        }

        }
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
        self.genreCollectionView.loadItems(items: self.arrGenre)
        self.contentView.layoutIfNeeded()
        self.viewDetails.layoutIfNeeded()
    }
    
    //MARK: Button Action
    @IBAction func btnShareClicked(_ sender: Any) {
    }
    
    @IBAction func btnSubscribeClicked(_ sender: Any) {
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
    
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PDFViewController
        
        if let objPDFVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController{
            self.hidesBottomBarWhenPushed = true
            objPDFVC.episodeList = self.objBook?.episodes[indexPath.row].strContent
            self.navigationController?.pushViewController(objPDFVC, animated: true )
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
            else { preconditionFailure("Failed to load collection view cell") }
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

