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
    case Daily
    case Genre
}
class DiscoverModel:TSModel{
    var category:DiscoveryCategory = .Daily
    var strSearchTitles:String = ""
    var aryDaily:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var aryGenre:[String] = ["Trending","New releases","Adventure","Action","Romance","Drama","Comedy","Thriller","Superhero","Sci-fi","Mystery","Fantasy"]
    
    override init(){
        
    }
}
class DiscoverViewController: BaseViewController {
    
    var arrComics:[TSBook] = []

    
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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    
     override func setupUI(){
        self.model.category = .Daily
        self.updateCategoryUI()
        itemCollectionView.loadItems(items: self.model.aryDaily)
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
             
             var commicFilter:[TSBook] = []
             
             for objComic in self.arrComics {
                 if objComic.category.contains(selectedItem){
                     commicFilter.append(objComic)
                 }
             }
             
             if commicFilter.count > 0{
                 self.bookListCollectionView.setAndReloadTableView(arr: commicFilter)

             }else{
                 self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)

             }

//             self?.openDetailScreen(book: arrComics])
         }
//         self.itemCollectionView.didSelectBookSelectionHandler = { (aryBook,index, selectedItem, selectedItemIndex) in
//             
//         }
         
        self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.white)
        self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.Theme.lightGrayColor)
        
         self.fetchComicData()
        //tabBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        
    }
    private func updateCategoryUI(){
        if self.model.category == .Genre {
            self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.Theme.lightGrayColor)
            self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.white)
            
        }else if self.model.category == .Daily{
            self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.white)
            self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.Theme.lightGrayColor)
        }
    }
    
    //MARK: - Button Action
    @IBAction func btnDailyCategorySelection(_ sender:UIButton){
        self.model.category = .Daily
        self.updateCategoryUI()
        itemCollectionView.loadItems(items: self.model.aryDaily)
    }
    @IBAction func btnGenreCategorySelection(_ sender:UIButton){
        self.model.category = .Genre
        self.updateCategoryUI()
        itemCollectionView.loadItems(items: self.model.aryGenre)
    }
    
    
    
    
    private func openDetailScreen(book:TSBook){
        print("Data")
        
        if let objDetailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            objDetailView.objBook = book
            self.navigationController?.pushViewController(objDetailView, animated: true )
        }

    }
    
    
    func fetchComicData(){
        
        
        let ref = Database.database().reference(fromURL: "https://toonstreetbackend-default-rtdb.firebaseio.com/")

        _ = ref.child("comics").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.arrComics = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrComics.append(TSBook.init(dictObj:objDict))
                }
            }
  
            self.bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
        })
    }
    
}
