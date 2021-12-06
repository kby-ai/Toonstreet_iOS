//
//  PDFViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit
import PDFKit
import WebKit

class PDFViewController: BaseViewController {

    
    var episodeList:[String]?
    
    @IBOutlet weak var webKit: WKWebView!
    
    @IBOutlet weak var btnPrevious:UIButton!
    @IBOutlet weak var btnNext:UIButton!
    
    @IBOutlet weak var viewPDF: UIView!
//    var pdfView:PDFView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leftBarButtonItems = [.BackArrow]


//        self.setupPDFView()
        self.setupGesture()
       
       
        
    }
    
    
//    private func setupPDFView(){
//        // Add PDFView to view controller.
//        pdfView = PDFView(frame: CGRect.init(x: 0, y: 0, width: self.viewPDF.frame.width, height: self.viewPDF.frame.height))
//        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.viewPDF.addSubview(pdfView)
//
//
//
//        let fileURL = Bundle.main.url(forResource: "testcomic", withExtension: "pdf")
//        pdfView.displayMode = .singlePageContinuous
//        pdfView.autoScales = true
//        pdfView.displayDirection = .horizontal
//        pdfView.document = PDFDocument(url: fileURL!)
//        pdfView.goToFirstPage(nil)
//        pdfView.isUserInteractionEnabled = false
//
//        self.updateButtonViewUI()
//
//    }
    private func setupGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.viewPDF.addGestureRecognizer(swipeRight)
        self.webKit.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.viewPDF.addGestureRecognizer(swipeLeft)
        self.webKit.addGestureRecognizer(swipeLeft)

    }
    private func updateButtonViewUI(){
//        if pdfView.canGoToPreviousPage{
//            self.btnPrevious.isEnabled = true
//        }
//        else {
//            self.btnPrevious.isEnabled = false
//        }
//        if pdfView.canGoToNextPage{
//            self.btnNext.isEnabled = true
//
//        }else {
//            self.btnPrevious.isEnabled = false
//        }
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.left:
                    print("Swiped back")
//                    if pdfView.canGoToNextPage {
//                        pdfView.goToNextPage(nil)
//                    }
                case UISwipeGestureRecognizer.Direction.right:
                    print("Swiped back")
//                    if pdfView.canGoToPreviousPage {
//                        pdfView.goToPreviousPage(nil)
//                    }
                default:
                    break
                }
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver (self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
        
        if episodeList?.count ?? 0 > 0{
//            self.webKit.set
            self.webKit.loadHTMLString(episodeList![0], baseURL: nil)

        }
        
    }
    
    
    @IBAction func btnPreviousClick(_ sender: Any) {
        
//        if pdfView.canGoToPreviousPage{
//            pdfView.goToPreviousPage(sender)
//        }
        
       
//        self.updateButtonViewUI()
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
//        pdfView.next =
        
//        if pdfView.canGoToNextPage{
//            pdfView.goToNextPage(sender)
//        }
       
//        self.updateButtonViewUI()
        //pdfView.usePageViewController(true, withViewOptions: nil)

    }
    
    
    
}
