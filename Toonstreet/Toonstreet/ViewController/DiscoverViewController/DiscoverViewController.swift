//
//  DiscoverViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit
enum DiscoveryCategory{
    case Daily
    case Genre
}
class DiscoverModel:TSModel{
    var category:DiscoveryCategory = .Daily
    var strSearchTitles:String = ""
    var aryDaily:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var aryGenre:[String] = ["Drama","Fantasy","Comedy","Action","Romance","Superhero"]
    
    override init(){
        
    }
}
class DiscoverViewController: BaseViewController {
    
    
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
    
     override func setupUI(){
        self.model.category = .Daily
        self.updateCategoryUI()
        itemCollectionView.loadItems(items: self.model.aryDaily)
        bookListCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook(),TSBook(),TSBook(),])

        mainView.backgroundColor = UIColor.Theme.themeBlackColor
        
        self.searchBarView.backgroundColor = UIColor.clear
        self.categoryView.backgroundColor = UIColor.clear
        self.sliderView.backgroundColor = UIColor.clear
        self.booklistView.backgroundColor = UIColor.clear
        
        self.btnDaily.tsButtonType = .text(text: "Daily", textColor: UIColor.white)
        self.btnGenre.tsButtonType = .text(text: "Genre", textColor: UIColor.Theme.lightGrayColor)
        
        
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
}
