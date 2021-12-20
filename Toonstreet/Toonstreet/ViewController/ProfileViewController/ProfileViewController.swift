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

//    var arrMyList:[TSBook] = []
//    var arrHistory:[TSBook] = []

    @IBOutlet weak var tblProfile: ProfileTableView!
    
    @IBOutlet weak var btnBuyCoin: TSButton!
    @IBOutlet weak var viewCoins: UIView!
    @IBOutlet weak var lblCoins: TSLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButtonItems = [.logOut]
        //        self.fetchComicData()
   
//        TSFirebaseAPI.shared.addCoins(newPoint: 5);
    }
    
    override func navigationRightButton_Clicked(){
        UIAlertController.showAlert(andMessage: "Are you sure you want to logout.", andButtonTitles: ["YES","NO"]) { index in
            if index == 0{
                print("YES")
                self.navigateToLoginController()
            }else{
                
            }
        }
    }
    func navigateToLoginController(){
        
        TSUser.shared.clearUserDetails()
        UserDefaults.standard.set(false, forKey: "isLogin") //Bool
        UserDefaults.standard.synchronize()
        
        
        let destinationLogin:LoginViewController = UIStoryboard(storyboard: .Main).instantiateViewController()
        let navco = UINavigationController(rootViewController: destinationLogin)
        appDelegate.window?.rootViewController = navco
        appDelegate.window?.makeKeyAndVisible()
    }
    override func viewDidAppear(_ animated: Bool) {
        TSFirebaseAPI.shared.getCoins { [unowned self] available in
            DispatchQueue.main.async {
                self.lblCoins.text = "\(TSUser.shared.coins) Coins"
            }
        }
        
        TSFirebaseAPI.shared.arrContinueReading = []
        TSFirebaseAPI.shared.arrPurchasedComic = []

        TSFirebaseAPI.shared.fetchPurchaseData { [unowned self] status in
            TSFirebaseAPI.shared.fetchContinueReadingData { [unowned self] dict in
//                self.objReadingDict = dict
                fetchComicData()
            }
        }
        
//        TSFirebaseAPI.shared.fetchPurchaseData { [unowned self] status in
//            if status == true{
//            }
//        }
    }
    func fetchComicData(){

       
//        self.arrComics = []

        TSFirebaseAPI.shared.fetchPopularData { [unowned self] arrBook in
            
//            self.arrComics = arrBook

//            self.tblHomeTableView.setAndReloadTableViewComics(arr: self.arrComics, arrContinueReading: TSFirebaseAPI.shared.arrContinueReading)
            self.tblProfile.reloadData()

        }
       
        
//        self.arrNewRelease = []
        
        TSFirebaseAPI.shared.fetchNewReleaseData { [unowned self] arrBook in
//            self.arrNewRelease = arrBook
//            self.tblHomeTableView.setAndReloadTableViewNewRelease(arr: self.arrNewRelease, arrContinueReading: TSFirebaseAPI.shared.arrContinueReading)
            
            self.tblProfile.reloadData()

        }
    }

    @IBAction func btnCoinsClicked(_ sender: Any) {
        
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
    
    
//    func fetchComicData(){
//
//
//        let ref = Database.database().reference(fromURL: FirebaseBaseURL)
//
//        _ = ref.child("comics").observeSingleEvent(of: .value, with: { (snapshot) in
//            print(snapshot)
//            self.arrComics = []
//            guard let value = snapshot.value else { return }
//
//
//            if let arrValue = value as? [NSDictionary]{
//                for objDict in arrValue{
//                    print(objDict)
//                    self.arrComics.append(TSBook.init(dictObj:objDict))
//                }
//            }
//
//            self.tblProfile.setAndReloadTableView(arr: self.arrComics)
//        })
//    }
}

