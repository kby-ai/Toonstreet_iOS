//
//  GenreCollectionView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class GenreCollectionView: UICollectionView {
    
    
    private var aryItems:[String] = []
    private var didSelectBookSelectionHandler:((_ aryBook:[String],_ index:Int, _ selectedItem:String, _ selectedItemIndex:Int )->Void)?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.commonInit()
    }
    var selectedItemIndex = 0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
        
    }

    func commonInit(){
       
        isScrollEnabled = false
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alwaysBounceVertical = false
        
        self.delegate = self
        self.dataSource = self
        
        //self.collectionViewLayout = MosaicLayout()
    
        self.register(UINib.init(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: GenreCollectionCell.identifer)
                
        self.backgroundColor = UIColor.clear
    }
    public func loadItems(items:[String],withSelectionIndex index:Int = 0){
        self.aryItems = items
        self.selectedItemIndex = index
        self.reloadData()
    }

    public func setDidSelectPhotoHandler(handler:((_ aryBook:[String],_ index:Int, _ selectedItem:String, _ selectedItemIndex:Int )->Void)?){
        if handler != nil {
            self.didSelectBookSelectionHandler = handler
        }
    }
}
extension GenreCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Always show 50K cells so scrolling performance can be tested.
        
        return self.aryItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MosaicCell.identifer, for: indexPath) as? MosaicCell
//            else { preconditionFailure("Failed to load collection view cell") }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.identifer, for: indexPath) as? GenreCollectionCell
            else { preconditionFailure("Failed to load collection view cell") }

        cell.strCategory = self.aryItems[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItemIndex = indexPath.row
        collectionView.reloadData()
        if let handler = self.didSelectBookSelectionHandler{
            
            handler(self.aryItems,indexPath.item,self.aryItems[selectedItemIndex],selectedItemIndex)
        }
    }
    
}
extension GenreCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let item = self.aryItems[indexPath.item]
//                let itemSize = item.size(withAttributes: [
//                    NSAttributedString.Key.font : UIFont.font_semibold(15)
//                ])
//        print("Cell:: Index :: \(indexPath.item) Cell Size :: \(itemSize.width+20) * \(itemSize.height+20)")
//        return CGSize(width: itemSize.width + 20 , height: itemSize.height+20)
//
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
}
