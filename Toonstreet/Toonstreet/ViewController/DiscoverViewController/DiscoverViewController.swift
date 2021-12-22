//
//  DiscoverViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestoreSwift


enum DiscoveryCategory{
//    case Daily //temp comment
    case Genre
}
class DiscoverModel:TSModel{
    var category:DiscoveryCategory = .Genre
    var strSearchTitles:String = ""
    
//    var aryDaily:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var aryGenre:[String] = ["Trending","New releases","Adventure","Action","Romance","Drama","Comedy","Thriller","Superhero","Sci-fi","Mystery","Fantasy"]
    
    override init(){
        
    }
}
class DiscoverViewController: BaseViewController,UISearchBarDelegate {
    
    var arrComics:[TSBook] = []
    var searchActive = false;
    var arrFiltered:[TSBook] = []
    var commicFilter:[TSBook] = []
    @IBOutlet weak var txtSearch: UISearchBar!
    //MARK: - IBOutlet
    @IBOutlet weak var itemCollectionView:SliderCollectionView!
    @IBOutlet weak var bookListCollectionView:BookListCollectionView!
    @IBOutlet weak var btnDaily:TSButton!
    @IBOutlet weak var btnGenre:TSButton!
    @IBOutlet weak var searchBarView:UIView!
    @IBOutlet weak var categoryView:UIView!
    @IBOutlet weak var sliderView:UIView!
    @IBOutlet weak var booklistView:UIView!
    @IBOutlet weak var mainView:UIView!
    
    
    //MARK: - Variable
    private var model = DiscoverModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSearch.tintColor = UIColor.white
//        self.txtSearch.barTintColor = UIColor.white
//        txtSearch.setTextColor(color: UIColor.white)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white

        
     

//        let alignedFlowLayout = AlignedCollectionViewFlowLayout(
//            horizontalAlignment: .left,
//            verticalAlignment: .top
//        )

//        bookListCollectionView.collectionViewLayout = alignedFlowLayout
        
        
        self.txtSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var newAttributesArray = [UICollectionViewLayoutAttributes]()
//        let superAttributesArray = super.layoutAttributesForElements(in: rect)!
//        for (index, attributes) in superAttributesArray.enumerated() {
//            if index == 0 || superAttributesArray[index - 1].frame.origin.y != attributes.frame.origin.y {
//                attributes.frame.origin.x = sectionInset.left
//            } else {
//                let previousAttributes = superAttributesArray[index - 1]
//                let previousFrameRight = previousAttributes.frame.origin.x + previousAttributes.frame.width
//                attributes.frame.origin.x = previousFrameRight + minimumInteritemSpacing
//            }
//            newAttributesArray.append(attributes)
//        }
//        return newAttributesArray
//    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true

    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//
//    }
    
     override func setupUI(){
         
         self.fetchComicData()

         self.model.category = .Genre
        self.updateCategoryUI()
//        itemCollectionView.loadItems(items: self.model.aryDaily)
//        bookListCollectionView.loadBooks(withBooks: [])//,TSBook(),TSBook(),TSBook(),TSBook()

        mainView.backgroundColor = UIColor.Theme.themeBlackColor
        
        self.searchBarView.backgroundColor = UIColor.clear
        self.categoryView.backgroundColor = UIColor.clear
        self.sliderView.backgroundColor = UIColor.clear
        self.booklistView.backgroundColor = UIColor.clear
        
         
         self.bookListCollectionView.setDidSelectPhotoHandler { aryBook, index in
             self.openDetailScreen(book: aryBook[index])
         }
         
         
         self.itemCollectionView.setDidSelectPhotoHandler { (aryBook, index,  selectedItem, selectedItemIndex) in
             print(selectedItem)
             
             if self.model.category == .Genre {
                 self.commicFilter = []
             
             for objComic in self.arrComics {
                 if objComic.category.contains(selectedItem){
                     self.commicFilter.append(objComic)
                 }
             }
                 self.bookListCollectionView.backgroundView = nil

                 self.bookListCollectionView.setAndReloadTableView(arr: self.commicFilter)

                 if self.commicFilter.count > 0{
                     self.bookListCollectionView.backgroundView = nil
                 } else {
                     // Display a message when the table is empty
                     self.createEmptyCollectionView(collectionView: self.bookListCollectionView)
                 }

             }else{
                 self.bookListCollectionView.backgroundView = nil

                self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
             }
//             if commicFilter.count > 0{

//             }else{
//                 self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)

//             }

//             self?.openDetailScreen(book: arrComics])
         }
//         self.itemCollectionView.didSelectBookSelectionHandler = { (aryBook,index, selectedItem, selectedItemIndex) in
//             
//         }
         
//        self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.white)//temp comment
        self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.Theme.lightGrayColor)
        
         itemCollectionView.loadItems(items: self.model.aryGenre)
         self.updateCategoryUI()

         
        //tabBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        
    }
    private func updateCategoryUI(){
//        if self.model.category == .Genre {
//            self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.Theme.lightGrayColor) //temp comment
//            self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.white)
            
//        }//temp coment this section
//        else if self.model.category == .Daily{
//            self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.white)
//            self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.Theme.lightGrayColor)
//        }
        
//        if self.model.category == .Genre {
        self.commicFilter = []
        
        for objComic in self.arrComics {
            if objComic.category.contains(self.model.aryGenre[0]){
                commicFilter.append(objComic)
            }
        }
        self.bookListCollectionView.backgroundView = nil

            self.bookListCollectionView.setAndReloadTableView(arr: commicFilter)
            
            if commicFilter.count > 0{
                self.bookListCollectionView.backgroundView = nil
            } else {
                // Display a message when the table is empty
                self.createEmptyCollectionView(collectionView: self.bookListCollectionView)
            }

            

//        }else{
//            self.bookListCollectionView.backgroundView = nil
//            self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
//        }
    }
   
    //MARK: - Button Action
    @IBAction func btnDailyCategorySelection(_ sender:UIButton){
//        self.model.category = .Daily
//        self.updateCategoryUI()
//        itemCollectionView.loadItems(items: self.model.aryDaily)
    }
    @IBAction func btnGenreCategorySelection(_ sender:UIButton){
        self.model.category = .Genre
        self.updateCategoryUI()
        itemCollectionView.loadItems(items: self.model.aryGenre)
    }
    
    
    
    
    private func openDetailScreen(book:TSBook){
        print("Data")
        
        if let objDetailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            let purchasedDict1 =  TSFirebaseAPI.shared.arrPurchasedComicDict.filter({$0.value(forKey: "title" ) as? String == book.title})

            if purchasedDict1.count>0{
            let objBook1 = TSBook.init(dictObj: purchasedDict1[0])
                objDetailView.objBook = objBook1
            }else{
                objDetailView.objBook = book
            }
            
            self.navigationController?.pushViewController(objDetailView, animated: true )
        }

    }
    
    func fetchComicData(){

        TSFirebaseAPI.shared.arrContinueReading = []
//        TSFirebaseAPI.shared.arrPurchasedComic = []

        self.arrComics = []

        TSFirebaseAPI.shared.fetchPopularData { [unowned self] arrBook in
            
            for book in arrBook{
                self.arrComics.append(book)
            }

            self.bookListCollectionView.backgroundView = nil

        self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
          self.updateCategoryUI()
        }
       
        
        
        TSFirebaseAPI.shared.fetchNewReleaseData { [unowned self] arrBook in
//            self.arrNewRelease = arrBook
            
            for book in arrBook{
                self.arrComics.append(book)
            }
            self.bookListCollectionView.backgroundView = nil

            self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
              self.updateCategoryUI()
            
//            self.tblHomeTableView.setAndReloadTableViewNewRelease(arr: self.arrNewRelease, arrContinueReading: TSFirebaseAPI.shared.arrContinueReading)
        }
    }
    
//    func fetchComicData(){
//
//
//        let ref = Database.database().reference(fromURL: FirebaseBaseURL)
//
//        _ = ref.child("popular").observeSingleEvent(of: .value, with: { (snapshot) in
//            print(snapshot)
//            self.arrComics = []
//            guard let value = snapshot.value else { return }
//
//
//            if let arrValue = value as? [NSDictionary]{
//                for objDict in arrValue{
//                    print(objDict)
//                    self.arrComics.append(TSBook.init(dictObj:objDict))
//                }
//            }
//            self.bookListCollectionView.backgroundView = nil
//            self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
//            self.updateCategoryUI()
//
//        })
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchActive = false

    }
    
  

   func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       searchActive = true
   }

   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       searchActive = false
   }
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchActive = false
   }
  

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

       self.arrFiltered = []
       self.arrFiltered = commicFilter.filter { $0.title.lowercased().contains(searchText.lowercased()) }

//       arrFiltered = arrComics.filter( $0.title.contains(searchText))
//       arrFiltered = arrComics.filter({ (text) -> Bool in
//           let tmp:NSString = text as NSString
//           let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//           return range.location != NSNotFound
//       })

       if (arrFiltered.count == 0){
           searchActive = false
           self.bookListCollectionView.backgroundView = nil
           self.bookListCollectionView.setAndReloadTableView(arr: self.commicFilter)
       }
       else{
           
           self.bookListCollectionView.backgroundView = nil
           searchActive = true
           self.bookListCollectionView.setAndReloadTableView(arr: self.arrFiltered)

       }
       

       
//       self.itemCollectionView.reloadData()
   }
}

//public extension UISearchBar {
//
//    public func setTextColor(color: UIColor) {
//        let svs = subviews.flatMap { $0.subviews }
//        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
//        tf.textColor = color
//    }
//}
