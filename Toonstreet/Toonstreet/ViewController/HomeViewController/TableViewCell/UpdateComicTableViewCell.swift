//
//  UpdateComicTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class UpdateComicTableViewCell: TSTableViewCell {
    
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var viewCollection:UIView!
    @IBOutlet weak var updateComicsCollectionView:UpdateComicsCollectionView!
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
        self.lblTitle.text = "Update Comics"
        self.lblTitle.numberOfLines = 0
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.appFont_Bold(Size: 20)
        
        self.mainView.backgroundColor = UIColor.Theme.themeLightBlackColor
        
        self.viewCollection.backgroundColor = UIColor.clear
        
        self.updateComicsCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook()])
        self.updateComicsCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
            if let value = self?.didSelectCellItem{
                value(HomeType.UpdateComics,aryBook[index])
            }
        }
        
    }
    func didSelectCellItem(withHandler handler:HomeScreenBookTableViewCellSelectionHandler?){
        if let value = handler{
            self.didSelectCellItem = value
        }
    }
}
