//
//  BuyCoinViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit

class BuyCoinViewController: BaseViewController ,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tblBuyCoins: UITableView!
    @IBOutlet weak var lblcoins: TSLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //CoinTableCell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TSFirebaseAPI.shared.getCoins { [unowned self] available in
            
            DispatchQueue.main.async {
                self.lblcoins.text = "\(TSUser.shared.coins) Coins"
            }
        }

    }
    
    override func setupUI() {
        
        self.tblBuyCoins.register(UINib.init(nibName: "CoinTableCell", bundle: nil), forCellReuseIdentifier: "CoinTableCell")
        
        self.tblBuyCoins.delegate = self
        self.tblBuyCoins.dataSource = self
        self.tblBuyCoins.separatorStyle = .none
        
        self.leftBarButtonItems = [.BackArrow]

    }

 
    //MARK: Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CoinTableCell = tableView.dequeueReusableCell(withIdentifier: "CoinTableCell") as! CoinTableCell

        cell.selectionStyle = .none
        cell.setupCell(index: indexPath.row)
        cell.btnBuyCoin.tag = indexPath.row
        cell.btnBuyCoin.addTarget(self, action: #selector(self.btnBuyCoins(button:)), for: .touchUpInside)
      
        return cell
    }
   
    
    @objc func btnBuyCoins(button:UIButton){
        let index = button.tag + 1
        
        TSFirebaseAPI.shared.addCoins(newPoint: index*5) { [unowned self] coin in
            DispatchQueue.main.async {
                self.lblcoins.text = "\(TSUser.shared.coins) Coins"
            }
        }
    }
}
