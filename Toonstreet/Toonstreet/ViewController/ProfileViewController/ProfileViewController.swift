//
//  ProfileViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 23/11/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
//import FirebaseStorageUI
import FirebaseFirestoreSwift

class ProfileViewController: BaseViewController {

    var arrComics:[TSBook] = []

    @IBOutlet weak var tblProfile: ProfileTableView!
    
    @IBOutlet weak var btnBuyCoin: TSButton!
    @IBOutlet weak var viewCoins: UIView!
    @IBOutlet weak var lblCoins: TSLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchComicData()
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
        
        
        self.tblProfile.didSelectCellItem { [weak self] (type, book) in
            self?.openDetailScreen(book: book)
        }
    }
    private func openDetailScreen(book:TSBook){
        print("Data")
        
        if let objDetailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            objDetailView.objBook = book
            self.navigationController?.pushViewController(objDetailView, animated: true )
        }

    }
    
    
    func fetchComicData(){
        
        
        let ref = Database.database().reference(fromURL: "https://toonstreetbackend-default-rtdb.firebaseio.com/")

        _ = ref.child("comics").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.arrComics = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrComics.append(TSBook.init(dictObj:objDict))
                }
            }
  
            self.tblProfile.setAndReloadTableView(arr: self.arrComics)
        })
    }
}

