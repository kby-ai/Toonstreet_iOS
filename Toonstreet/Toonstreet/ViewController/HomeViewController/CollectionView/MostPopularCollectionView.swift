//
//  MostPopularCollectionView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class MostPopularCollectionView: UICollectionView {
    
    
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
    
    func commonInit(){
        self.backgroundColor = UIColor.white
        
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alwaysBounceVertical = false
        self.indicatorStyle = .white
        self.delegate = self
        self.dataSource = self
        
        //self.collectionViewLayout = MosaicLayout()
    
        self.register(UINib.init(nibName: "MostPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MostPopularCollectionViewCell.identifer)
                
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
extension MostPopularCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Always show 50K cells so scrolling performance can be tested.
        
        return self.aryBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MosaicCell.identifer, for: indexPath) as? MosaicCell
//            else { preconditionFailure("Failed to load collection view cell") }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularCollectionViewCell.identifer, for: indexPath) as? MostPopularCollectionViewCell
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
extension MostPopularCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = screenWidth * 0.30;
        return CGSize(width: cellWidth, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 14
        }
}
