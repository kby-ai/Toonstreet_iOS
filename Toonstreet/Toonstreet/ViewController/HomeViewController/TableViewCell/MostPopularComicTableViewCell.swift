//
//  MostPopularComicTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class MostPopularComicTableViewCell: UITableViewCell {
    
    var arrComics:[TSBook] = []

    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var lblSubTitle:TSLabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var viewCollection:UIView!
    @IBOutlet weak var mostPopularCollectionView:MostPopularCollectionView!
    @IBOutlet weak var viewCollectionWithoutType:UIView!
    @IBOutlet weak var mostPopularWithoutTypeCollectionView:MostPopularCollectionView!
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
    
    func addAndReloadCell(arr:[TSBook]){
        
        var arrRow1:[TSBook] = []
        var arrRow2:[TSBook] = []
        
        
        for index in 0..<arr.count{
            if index % 2 == 0{
                arrRow1.append(arr[index])
            }else{
                arrRow2.append(arr[index])
            }
        }
      

        self.mostPopularCollectionView.loadBooks(withBooks: arrRow1)
        self.mostPopularWithoutTypeCollectionView.loadBooks(withBooks: arrRow2)

//        self.mostPopularWithoutTypeCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook(),TSBook()],isTypeHide: true  )
    }
    
    func commonInit(){
        self.lblTitle.text = "Most Popular Comics"
        self.lblTitle.numberOfLines = 1
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.appFont_Bold(Size: 20)
        
        
        self.lblSubTitle.text = "Lots of interesting comics here"
        self.lblSubTitle.numberOfLines = 0
        self.lblSubTitle.textColor = UIColor.white
        self.lblSubTitle.font = UIFont.appFont_FontRegular(Size: 10.0)
        
        
        self.mainView.backgroundColor = UIColor.Theme.themeBlackColor
        
        self.viewCollection.backgroundColor = UIColor.clear
        self.viewCollectionWithoutType.backgroundColor = UIColor.clear
        
//        self.mostPopularCollectionView.loadBooks(withBooks: arrComics)
        self.mostPopularCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
            if let value = self?.didSelectCellItem{
                value(HomeType.ReleaseSoon,aryBook[index])
            }
        }
        
//        self.mostPopularWithoutTypeCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook(),TSBook()],isTypeHide: true  )
        self.mostPopularWithoutTypeCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
            if let value = self?.didSelectCellItem{
                value(HomeType.ReleaseSoon,aryBook[index])
            }
        }
        
        
    }
    func didSelectCellItem(withHandler handler:HomeScreenBookTableViewCellSelectionHandler?){
        if let value = handler{
            self.didSelectCellItem = value
        }
    }
}
