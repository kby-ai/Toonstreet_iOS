//
//  TSTableViewCell.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class TSTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
