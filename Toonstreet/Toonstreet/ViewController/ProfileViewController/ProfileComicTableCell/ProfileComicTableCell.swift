//
//  ProfileComicTableCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class ProfileComicTableCell: UITableViewCell {
    
    var arrComics:[TSBook] = []

    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var viewCollection:UIView!
    @IBOutlet weak var mostPopularCollectionView:MostPopularCollectionView!
    @IBOutlet weak var viewCollectionWithoutType:UIView!
    @IBOutlet weak var mostPopularWithoutTypeCollectionView:MostPopularCollectionView!
    private var didSelectCellItem:ProfileScreenMyListTableViewCellSelectionHandler?
    
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
    
    
    func setAndReloadTableView(arr:[TSBook]){
        self.arrComics = arr
        self.mostPopularCollectionView.loadBooks(withBooks: self.arrComics)
//        self.mostPopularCollectionView.reloadData()
    }
    
    
    
    
    func commonInit(){
        self.lblTitle.text = "All of your Comics"//"Comic History"
        self.lblTitle.numberOfLines = 0
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.appFont_Bold(Size: 20)
        
        
       
        
        
        self.mainView.backgroundColor = UIColor.Theme.themeBlackColor
        
        self.viewCollection.backgroundColor = UIColor.clear
        self.viewCollectionWithoutType.backgroundColor = UIColor.clear
        
//        self.mostPopularCollectionView.loadBooks(withBooks: arrComics)
        self.mostPopularCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
            if let value = self?.didSelectCellItem{
                value(ProfileType.ComicHistory,aryBook[index])
            }
        }
//        self.mostPopularWithoutTypeCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook(),TSBook()],isTypeHide: true  )
        self.mostPopularWithoutTypeCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
            if let value = self?.didSelectCellItem{
                value(ProfileType.ComicHistory,aryBook[index])
            }
        }
        
        
    }
    func didSelectCellItem(withHandler handler:ProfileScreenMyListTableViewCellSelectionHandler?){
        if let value = handler{
            self.didSelectCellItem = value
        }
    }
}
