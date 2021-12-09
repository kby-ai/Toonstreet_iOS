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
    
    //MARK: - IBOutlet
    @IBOutlet weak var tblHomeTableView:HomeTableView!
    @IBOutlet weak var mainView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchComicData()
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
  
            self.tblHomeTableView.setAndReloadTableView(arr: self.arrComics)
//            self.tblHomeTableView.arrComics = self.arrComics
//            self.tblHomeTableView.reloadData()
        })
            
        // Create a reference to the file you want to download
//        let urlStr = "gs://toonstreetbackend.appspot.com/cover_images/10thMuse02Volume1/1.jpg"//storageRef.child("images/island.jpg")
//
//
//        let storage = Storage.storage()
//         let storageReference = storage.reference()
//        let starsRef = storage.reference(forURL: urlStr)

//        let starsRef = storageRef.child("images/stars.jpg")

        // Fetch the download URL
//        starsRef.downloadURL { url, error in
//          if let error = error {
//            // Handle any errors
//              print(error)
//          } else {
//            // Get the download URL for 'images/stars.jpg'
//              print(url)
//          }
//        }

        
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
