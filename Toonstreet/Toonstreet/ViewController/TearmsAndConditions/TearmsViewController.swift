//
//  TearmsViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/12/21.
//

import UIKit
import WebKit

class TearmsViewController: BaseViewController {

    @IBOutlet weak var wekView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leftBarButtonItems = [.BackArrow]

        let path = Bundle.main.path(forResource: "ToonstreetTermsConditions", ofType: "html")
        do {
            let fileHtml = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            wekView.loadHTMLString(fileHtml as String, baseURL: nil)
        }
        catch {

        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
