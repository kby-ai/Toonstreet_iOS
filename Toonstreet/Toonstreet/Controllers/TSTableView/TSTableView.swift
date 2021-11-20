//
//  TSTableView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
typealias TableViewDidSelectCellHandler = ((_ cell:UITableViewCell,_ indexPath:IndexPath)->Void)

class TSTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    func commonInit(){
        
    }
    
}
