//
//  HomeTableView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
enum HomeType{
    case ResumeReading
//    case UpdateComics
    case ReleaseSoon
    case MostPopular
//    case ContinueReading
    case NewRelease
}
class HomeTableView: TSTableView {
   
    var arrComics:[TSBook] = []
    var arrNewRelease:[TSBook] = []
    var arrUpdate:[TSBook] = []
    var arrContinueReading:[TSBook] = []


    var aryHomeTypes:[HomeType] = [.ResumeReading,.ReleaseSoon,.MostPopular,.NewRelease]//.UpdateComics,,.ContinueReading

    private var didSelectTableCellSelectionHandler:HomeScreenBookTableViewCellSelectionHandler?
    
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
    override func commonInit() {
       
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableView.automaticDimension;
        
        self.register(UINib.init(nibName: "ResumeReadingTableViewCell", bundle: nil), forCellReuseIdentifier: "ResumeReadingTableViewCell")
        self.register(UINib.init(nibName: "UpdateComicTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateComicTableViewCell")
        self.register(UINib.init(nibName: "ReleaseSoonTableViewCell", bundle: nil), forCellReuseIdentifier: "ReleaseSoonTableViewCell")
        self.register(UINib.init(nibName: "MostPopularComicTableViewCell", bundle: nil), forCellReuseIdentifier: "MostPopularComicTableViewCell")
        self.register(UINib.init(nibName: "ContinueReadingTableViewCell", bundle: nil), forCellReuseIdentifier: "ContinueReadingTableViewCell")
        self.register(UINib.init(nibName: "NewReleaseTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReleaseTableViewCell")
        self.backgroundColor = UIColor.clear
        self.separatorStyle = .none
        self.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        
    }
    
    func setAndReloadTableViewComics(arr:[TSBook], arrContinueReading:[TSBook]){
        self.arrComics = arr
        self.arrContinueReading = arrContinueReading
        self.reloadData()
    }
    
    func setAndReloadTableViewNewRelease(arr:[TSBook] , arrContinueReading:[TSBook]){
        self.arrNewRelease = arr
        self.arrContinueReading = arrContinueReading
        self.reloadData()
    }
    
    func setAndReloadTableViewUpdadte(arr:[TSBook], arrContinueReading:[TSBook]){
        self.arrUpdate = arr
        self.arrContinueReading = arrContinueReading
        self.reloadData()
    }
    
    func setTableViewData(isContinueReading:Bool){
        
        if (isContinueReading == false){
            self.aryHomeTypes = [.ReleaseSoon,.MostPopular,.NewRelease]//.UpdateComics,.ContinueReading,
        }else{
            self.aryHomeTypes = [.ResumeReading,.ReleaseSoon,.MostPopular,.NewRelease]//.UpdateComics,.ContinueReading,
        }
        
        self.delegate  = self
        self.dataSource = self
        self.reloadData()
    }
    func didSelectCellItem(withHandler handler:HomeScreenBookTableViewCellSelectionHandler?){
        if let value = handler{
            self.didSelectTableCellSelectionHandler = value
        }
    }
    private func handleCellItem(type:HomeType,book:TSBook){
        if let handler = self.didSelectTableCellSelectionHandler{
            handler(type,book)
        }
    }
}
extension HomeTableView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aryHomeTypes.count>0{
            self.backgroundView = nil
            return aryHomeTypes.count
        }
        else{
            let emptyBackgroundView = TSEmptyBackgroundView.init(image: UIImage(), top: "Home", bottom: "Home Tab!")
            emptyBackgroundView.updateConstraints()
            self.backgroundView = emptyBackgroundView
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let type = self.aryHomeTypes[indexPath.row]
//        if type == .UpdateComics{
//            guard let cell:UpdateComicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpdateComicTableViewCell")
//                    as? UpdateComicTableViewCell else {
//                return UITableViewCell()
//            }
////            cell.arrComics = self.arrComics
//            cell.addAndReloadCell(arr: self.arrUpdate)
//            cell.didSelectCellItem { [weak self] (type, book) in
//                self?.handleCellItem(type: type, book: book)
//            }
//            return cell
//        }else
        if type == .ResumeReading{
            guard let cell:ResumeReadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResumeReadingTableViewCell") as? ResumeReadingTableViewCell else {
                return UITableViewCell()
            }
//            cell.arrComics = self.arrContinueReading
            cell.addAndReloadCell(arr: self.arrContinueReading)
            cell.didSelectCellItem { [weak self] (type, book) in
                self?.handleCellItem(type: type, book: book)
            }
            return cell
        }else if type == .ReleaseSoon{
            guard let cell:ReleaseSoonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReleaseSoonTableViewCell") as? ReleaseSoonTableViewCell else {
                return UITableViewCell()
            }
//            cell.arrComics = self.arrComics
            cell.addAndReloadCell(arr: self.arrNewRelease)

            cell.didSelectCellItem { [weak self] (type, book) in
                self?.handleCellItem(type: type, book: book)
            }
            return cell
        }else if type == .MostPopular{
            guard let cell:MostPopularComicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MostPopularComicTableViewCell") as? MostPopularComicTableViewCell else {
                return UITableViewCell()
            }
//            cell.arrComics = self.arrComics
            cell.addAndReloadCell(arr: self.arrComics)

            cell.didSelectCellItem { [weak self] (type, book) in
                self?.handleCellItem(type: type, book: book)
            }
            return cell
        }
//        else if type == .ContinueReading{
//            guard let cell:ContinueReadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContinueReadingTableViewCell") as? ContinueReadingTableViewCell else {
//                return UITableViewCell()
//            }
////            cell.arrComics = self.arrComics
//            cell.addAndReloadCell(arr: self.arrComics)
//
//            cell.didSelectCellItem { [weak self] (type, book) in
//                self?.handleCellItem(type: type, book: book)
//            }
//            return cell
//        }
        else if type == .NewRelease{
            guard let cell:NewReleaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewReleaseTableViewCell") as? NewReleaseTableViewCell else {
                return UITableViewCell()
            }
//            cell.arrComics = self.arrComics
//            cell.addAndReloadCell(arr: self.arrComics)

            return cell
        }
        else {
            return UITableViewCell()
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = self.aryHomeTypes[indexPath.row]
        if type == .NewRelease{
            self.handleCellItem(type: type, book: TSBook())

        }
            
    }
    
}
