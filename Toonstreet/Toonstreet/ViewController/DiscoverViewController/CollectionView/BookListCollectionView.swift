//
//  BookListCollectionView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit

class BookListCollectionView: UICollectionView {
    
    
    private var aryBooks:[TSBook] = []
    private var didSelectBookSelectionHandler:((_ aryBook:[TSBook],_ index:Int)->Void)?
    private var isHideType:Bool = false
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
     
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    

    func setAndReloadTableView(arr:[TSBook]){
        self.aryBooks = arr
        self.reloadData()
    }
    
    
    
    func commonInit(){
        self.backgroundColor = UIColor.white
        
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alwaysBounceVertical = true
        self.indicatorStyle = .white
        self.delegate = self
        self.dataSource = self
        
        //self.collectionViewLayout = MosaicLayout()
    
        self.register(UINib.init(nibName: "BookListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BookListCollectionViewCell.identifer)
                
        self.backgroundColor = UIColor.clear
    }
    public func loadBooks(withBooks photo:[TSBook],isTypeHide ishide:Bool = false ){
        self.aryBooks = photo
        self.isHideType = ishide
        self.reloadData()
    }

    public func setDidSelectPhotoHandler(handler:((_ aryBook:[TSBook],_ index:Int)->Void)?){
        if handler != nil {
            self.didSelectBookSelectionHandler = handler
        }
    }
}
extension BookListCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Always show 50K cells so scrolling performance can be tested.
        
        return self.aryBooks.count //* 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MosaicCell.identifer, for: indexPath) as? MosaicCell
//            else { preconditionFailure("Failed to load collection view cell") }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifer, for: indexPath) as? BookListCollectionViewCell
            else { preconditionFailure("Failed to load collection view cell") }

        cell.updateUI(withIsHideType: self.isHideType)
        cell.setupCellData(objBook: self.aryBooks[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let handler = self.didSelectBookSelectionHandler{
            handler(self.aryBooks,indexPath.item)
        }
    }
    
}
extension BookListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = screenWidth * 0.27;
        let cellHeight = screenWidth * 0.385

        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 14
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
}
