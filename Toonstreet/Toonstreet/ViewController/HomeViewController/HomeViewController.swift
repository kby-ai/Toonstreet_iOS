//
//  HomeViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
//import FirebaseStorageUI
import FirebaseFirestoreSwift


class HomeViewController: BaseViewController {

    var arrComics:[TSBook] = []
    var arrUpdate:[TSBook] = []
    var arrNewRelease:[TSBook] = []

    //MARK: - IBOutlet
    @IBOutlet weak var tblHomeTableView:HomeTableView!
    @IBOutlet weak var mainView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchComicData()
        
        self.getUserData()
    }

    
    //MARK: Setup UI
     override func setupUI(){
        
        mainView.backgroundColor = UIColor.Theme.themeBlackColor
         self.view.backgroundColor = UIColor.Theme.themeBlackColor
        tblHomeTableView.setTableViewData()
        
        tblHomeTableView.didSelectCellItem { [weak self] (type, book) in
            self?.openDetailScreen(book: book)
        }
    }
    private func openDetailScreen(book:TSBook){
//        print("Data")
        
        if let objDetailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            objDetailView.objBook = book
            self.navigationController?.pushViewController(objDetailView, animated: true )
        }

    }
    
    
    
    func fetchComicData(){
        
//        newrelease
//        popular
//        soonrelease
//        update
//
        let ref = Database.database().reference(fromURL: "https://toonstreetbackend-default-rtdb.firebaseio.com/")

        _ = ref.child("popular").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.arrComics = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrComics.append(TSBook.init(dictObj:objDict))
                }
            }
  
            self.tblHomeTableView.setAndReloadTableViewComics(arr: self.arrComics)
        })
        
        
        

        _ = ref.child("newrelease").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.arrNewRelease = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrNewRelease.append(TSBook.init(dictObj:objDict))
                }
            }
  
            self.tblHomeTableView.setAndReloadTableViewNewRelease(arr: self.arrNewRelease)
        })
        
        
        

        _ = ref.child("update").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            self.arrUpdate = []
            guard let value = snapshot.value else { return }

            
            if let arrValue = value as? [NSDictionary]{
                for objDict in arrValue{
                    print(objDict)
                    self.arrUpdate.append(TSBook.init(dictObj:objDict))
                }
            }
  
            self.tblHomeTableView.setAndReloadTableViewUpdadte(arr: self.arrUpdate)
        })
        
//        = ref.child("soonrelease").observeSingleEvent(of: .value, with: { (snapshot) in
//           print(snapshot)
//           self.arrUpdate = []
//           guard let value = snapshot.value else { return }
//
//
//           if let arrValue = value as? [NSDictionary]{
//               for objDict in arrValue{
//                   print(objDict)
//                   self.arrUpdate.append(TSBook.init(dictObj:objDict))
//               }
//           }
//
//           self.tblHomeTableView.setAndReloadTableViewUpdadte(arr: self.arrUpdate)
//       })
        
    }
}


extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}
extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}
