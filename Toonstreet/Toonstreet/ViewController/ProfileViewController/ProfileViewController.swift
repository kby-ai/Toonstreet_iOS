//
//  ProfileViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 23/11/21.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var tblProfile: ProfileTableView!
    
    @IBOutlet weak var btnBuyCoin: TSButton!
    @IBOutlet weak var viewCoins: UIView!
    @IBOutlet weak var lblCoins: TSLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCoinsClicked(_ sender: Any) {
//        BuyCoinViewController
        
        if let objSignupVC = self.storyboard?.instantiateViewController(withIdentifier: "BuyCoinViewController") as? BuyCoinViewController{
            self.navigationController?.pushViewController(objSignupVC, animated: true )
        }
        
    }
    
    override func setupUI() {
        lblCoins.font = UIFont.appFont_Bold(Size: 18)
        
         self.view.backgroundColor = UIColor.Theme.themeBlackColor
        tblProfile.setTableViewData()
        
        
    }
}

