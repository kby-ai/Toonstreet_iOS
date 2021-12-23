//
//  AllEpisodeViewController.swift
//  Toonstreet
//
//  Created by kavin soni on 21/12/21.
//

import UIKit

class AllEpisodeViewController: BaseViewController {
    var type:HomeType?
    
    var arrComics:[TSBook] = []
    var arrNewRelease:[TSBook] = []
    var arrPurchasedComic:[TSBook] = []

    
    
    //MARK: - IBOutlet
    @IBOutlet weak var bookListCollectionView:BookListCollectionView!
    
    
    //MARK: - Variable
    private var model = DiscoverModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.txtSearch.barTintColor = UIColor.white
//        txtSearch.setTextColor(color: UIColor.white)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        TSFirebaseAPI.shared.checkComicReadingAvailability(completion: { [unowned self] available in
            
            if available == true{
                self.fetchComicData()
//                self.tblHomeTableView.setTableViewData(isContinueReading: false)

            }else{
                self.fetchContinueReadingData()
//                self.tblHomeTableView.setTableViewData(isContinueReading: true)

            }
            
        })

    
    //        if arrComics?.count ?? 0 > 0{
//            self.bookListCollectionView.setAndReloadTableView(arr: arrComics!)
//        }

    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//
//    }
    
     override func setupUI(){
         

//        itemCollectionView.loadItems(items: self.model.aryDaily)
//        bookListCollectionView.loadBooks(withBooks: [])//,TSBook(),TSBook(),TSBook(),TSBook()

//        mainView.backgroundColor = UIColor.Theme.themeBlackColor
         self.leftBarButtonItems = [.BackArrow]

         
         self.bookListCollectionView.setDidSelectPhotoHandler { aryBook, index in
             self.openDetailScreen(book: aryBook[index])
         }
         
         
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
  
    
    
    func fetchContinueReadingData(){
        
        self.arrPurchasedComic = []
        
        TSFirebaseAPI.shared.fetchPurchaseData {  [unowned self] arrPurchase in
            
            self.arrPurchasedComic = arrPurchase
        }
        
        
        TSFirebaseAPI.shared.fetchContinueReadingData { [unowned self] dict in
//                self.objReadingDict = dict
            self.fetchComicData()
        }
        
        
    }
    
    
    func fetchComicData(){

        TSFirebaseAPI.shared.arrContinueReading = []
                                           
        self.arrComics = []

        TSFirebaseAPI.shared.fetchPopularData { [unowned self] arrBook in
            
            self.arrComics = arrBook
//            self.tblHomeTableView.setAndReloadTableViewComics(arr: self.arrComics, arrContinueReading: TSFirebaseAPI.shared.arrContinueReading)\
            
            if self.type == .MostPopular{
                bookListCollectionView.setAndReloadTableView(arr: self.arrComics)
            }else if self.type == .ResumeReading{
                bookListCollectionView.setAndReloadTableView(arr: TSFirebaseAPI.shared.arrContinueReading)
            }
        }
       
        
        self.arrNewRelease = []
        
        TSFirebaseAPI.shared.fetchNewReleaseData { [unowned self] arrBook in
            self.arrNewRelease = arrBook
            if self.type == .NewRelease{
                bookListCollectionView.setAndReloadTableView(arr: self.arrNewRelease)
            } else if self.type == .ResumeReading
            {
                bookListCollectionView.setAndReloadTableView(arr: TSFirebaseAPI.shared.arrContinueReading)
            }
//            self.tblHomeTableView.setAndReloadTableViewNewRelease(arr: self.arrNewRelease, arrContinueReading: TSFirebaseAPI.shared.arrContinueReading)
        }
        
      
    }
    
    
    func fetchPurchasedData(){
        
//        TSFirebaseAPI.shared.arrPurchasedComic = []
        TSFirebaseAPI.shared.arrContinueReading = []
        
        
        TSFirebaseAPI.shared.fetchContinueReadingData { [unowned self] dict in
//            self.objReadingDict = dict
            self.fetchComicData()
            
           
            
        }
        
    }
    
}
