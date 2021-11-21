//
//  HomeTableView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit

class HomeTableView: TSTableView {
    enum HomeType{
        case ResumeReading
        case UpdateComics
        case ReleaseSoon
    }
    
    typealias onCompletionHandler = (Int) -> Void
    var closerForTableView:onCompletionHandler?
    
    var aryHomeTypes:[HomeType] = [.ResumeReading,.UpdateComics]

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
        self.backgroundColor = UIColor.clear
        self.separatorStyle = .none
        self.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        
    }
    func setTableViewData(){
        
        self.aryHomeTypes = [.ResumeReading,.UpdateComics,.ReleaseSoon]
        self.delegate  = self
        self.dataSource = self
        self.reloadData()
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
        if type == .UpdateComics{
            guard let cell:UpdateComicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpdateComicTableViewCell") as? UpdateComicTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }else if type == .ResumeReading{
            guard let cell:ResumeReadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResumeReadingTableViewCell") as? ResumeReadingTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }else if type == .ReleaseSoon{
            guard let cell:ReleaseSoonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReleaseSoonTableViewCell") as? ReleaseSoonTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        if closerForTableView != nil{
            closerForTableView!(indexPath.row)
        }
        }
    
}
