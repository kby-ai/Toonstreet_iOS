//
//  MyListTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 23/11/21.
//

import UIKit

typealias ProfileScreenMyListTableViewCellSelectionHandler = ((_ type:ProfileType, _ book:TSBook)->Void)

class MyListTableViewCell:TSTableViewCell {
    
    static let identifer = "MyListTableViewCell"

    
    @IBOutlet weak var lblTitle:TSLabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var viewCollection:UIView!
    
    @IBOutlet weak var myListCollectionView:MyListCollectionView!
//    private var didSelectCellItem:HomeScreenBookTableViewCellSelectionHandler?
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
        self.lblTitle.text = "My List"
        self.lblTitle.numberOfLines = 0
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.font = UIFont.appFont_Bold(Size: 20)
        
        self.mainView.backgroundColor = UIColor.Theme.themeBlackColor
        
        self.viewCollection.backgroundColor = UIColor.clear
        
        self.myListCollectionView.loadBooks(withBooks: [TSBook(),TSBook(),TSBook()])
        
        self.myListCollectionView.setDidSelectPhotoHandler { [weak self] (aryBook, index) in
            
//            if let value = self?.didSelectCellItem{
//                value(ProfileType.ResumeReading,aryBook[index])
//            }
        }
    }
    func didSelectCellItem(withHandler handler:HomeScreenBookTableViewCellSelectionHandler?){
//        if let value = handler{
//            self.didSelectCellItem = value
//        }
    }
    
}
