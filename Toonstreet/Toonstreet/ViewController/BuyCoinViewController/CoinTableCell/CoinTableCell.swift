//
//  CoinTableCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class CoinTableCell: UITableViewCell {

    @IBOutlet weak var lblCoin: TSLabel!
    
    @IBOutlet weak var btnBuyCoin: TSButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblCoin.font = UIFont.font_bold(14)
        btnBuyCoin.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(index:Int){
        self.lblCoin.text = "\(index+1) Coins"
        self.btnBuyCoin.setTitle(" $ \(index).99 ", for: .normal)
    }
    
}
