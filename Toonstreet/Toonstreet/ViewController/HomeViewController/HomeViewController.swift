//
//  HomeViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class HomeViewController: BaseViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tblHomeTableView:HomeTableView!
    @IBOutlet weak var mainView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: Setup UI
     override func setupUI(){
        
        mainView.backgroundColor = UIColor.Theme.themeBlackColor
         self.view.backgroundColor = UIColor.Theme.themeBlackColor
        tblHomeTableView.setTableViewData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
