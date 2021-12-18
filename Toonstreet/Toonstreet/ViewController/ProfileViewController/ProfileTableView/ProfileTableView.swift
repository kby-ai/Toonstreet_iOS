//
//  ProfileTableView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 23/11/21.
//

import UIKit



enum ProfileType{
    case MyList
    case ComicHistory
   
}


class ProfileTableView: TSTableView {
    
    var aryBooks:[TSBook] = []
    var aryProfileTypes:[ProfileType] = [.MyList,.ComicHistory]//,.ComicHistory]

    private var didSelectTableCellSelectionHandler:ProfileScreenMyListTableViewCellSelectionHandler?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }
    override func awakeFromNib() {
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setAndReloadTableView(arr:[TSBook]){
        self.aryBooks = arr
        self.reloadData()
    }
    
    
    
    override func commonInit() {
       
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableView.automaticDimension;
        
        self.register(UINib.init(nibName: "MyListTableViewCell", bundle: nil), forCellReuseIdentifier: "MyListTableViewCell")
        
        self.register(UINib.init(nibName: "ProfileComicTableCell", bundle: nil), forCellReuseIdentifier: "ProfileComicTableCell")

        
        
        self.backgroundColor = UIColor.clear
        self.separatorStyle = .none
        self.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        
    }
    func setTableViewData(){
        
        self.aryProfileTypes = [.MyList,.ComicHistory]
        
        self.delegate  = self
        self.dataSource = self
        self.reloadData()
    }
    func didSelectCellItem(withHandler handler:ProfileScreenMyListTableViewCellSelectionHandler?){
        if let value = handler{
            self.didSelectTableCellSelectionHandler = value
        }
    }
    private func handleCellItem(type:ProfileType,book:TSBook){
        if let handler = self.didSelectTableCellSelectionHandler{
            handler(type,book)
        }
    }
}



extension ProfileTableView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aryProfileTypes.count>0{
            self.backgroundView = nil
            return aryProfileTypes.count
        }
        else{
            let emptyBackgroundView = TSEmptyBackgroundView.init(image: UIImage(), top: "Profile", bottom: "Profile Tab!")
            emptyBackgroundView.updateConstraints()
            self.backgroundView = emptyBackgroundView
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.aryProfileTypes[indexPath.row]
        if type == .MyList{
            
            guard let cell:MyListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyListTableViewCell") as? MyListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setAndReloadTableView(arr: TSFirebaseAPI.shared.arrPurchasedComic)
            
            cell.didSelectCellItem { [weak self] (type, book) in
                self?.handleCellItem(type: type, book: book)
            }
            return cell
        }
        else if type == .ComicHistory{

            guard let cell:ProfileComicTableCell = tableView.dequeueReusableCell(withIdentifier: "ProfileComicTableCell") as? ProfileComicTableCell else {
                return UITableViewCell()
            }
            
//            guard let cell:ResumeReadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResumeReadingTableViewCell") as? ResumeReadingTableViewCell else {
//                return UITableViewCell()
//            }
            cell.didSelectCellItem { [weak self] (type, book) in
                self?.handleCellItem(type: type, book: book)
            }
            
            cell.setAndReloadTableView(arr: TSFirebaseAPI.shared.arrContinueReading)

            return cell
        }
        else {
            return UITableViewCell()
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let type = self.aryProfileTypes[indexPath.row]
//        if type == .NewRelease{
//            self.handleCellItem(type: type, book: TSBook())
//
//        }
            
    }
    
}
