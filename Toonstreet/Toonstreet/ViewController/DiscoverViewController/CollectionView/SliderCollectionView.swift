//
//  SliderCollectionView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit

class SliderCollectionView: UICollectionView {
    
    
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
        self.backgroundColor = UIColor.white
        
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alwaysBounceVertical = false
        
        self.delegate = self
        self.dataSource = self
        
        //self.collectionViewLayout = MosaicLayout()
    
        self.register(UINib.init(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SliderCollectionViewCell.identifer)
                
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
extension SliderCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Always show 50K cells so scrolling performance can be tested.
        
        return self.aryItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MosaicCell.identifer, for: indexPath) as? MosaicCell
//            else { preconditionFailure("Failed to load collection view cell") }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifer, for: indexPath) as? SliderCollectionViewCell
            else { preconditionFailure("Failed to load collection view cell") }

        cell.item = self.aryItems[indexPath.row]
        cell.isCellSelected = self.selectedItemIndex == indexPath.row ? true : false
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
extension SliderCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = screenWidth * 0.58;
        
        
        return CGSize(width: cellWidth, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
