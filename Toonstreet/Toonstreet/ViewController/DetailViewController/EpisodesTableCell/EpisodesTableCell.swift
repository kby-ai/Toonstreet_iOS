//
//  EpisodesTableCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class EpisodesTableCell: UITableViewCell {

    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblRates: TSLabel!
    @IBOutlet weak var lblTitle: TSLabel!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.imgBook.layer.cornerRadius = 10
            self.imgBook.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
