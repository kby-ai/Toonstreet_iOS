//
//  PDFViewController.swift
//  Toonstreet
//
//  Created by Kavin Soni on 24/11/21.
//

import UIKit
import PDFKit

class PDFViewController: BaseViewController {

    
    @IBOutlet weak var viewPDF: UIView!
    var pdfView:PDFView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leftBarButtonItems = [.BackArrow]

        self.navigationController?.title = "Episod 1"
//        var documentURL = NSBundle.main.GetUrlForResource("testcomic", "pdf");
//        var pdfdoc = new PdfDocument(documentURL);
        
        
        // Add PDFView to view controller.
        pdfView = PDFView(frame: CGRect.init(x: 0, y: 0, width: self.viewPDF.frame.width, height: self.viewPDF.frame.height - 50))
              self.view.addSubview(pdfView)

              // Fit content in PDFView.
              pdfView.autoScales = true

              // Load Sample.pdf file.
              let fileURL = Bundle.main.url(forResource: "testcomic", withExtension: "pdf")
        
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = false
        pdfView.displayDirection = .horizontal
        
        pdfView.document = PDFDocument(url: fileURL!)
        
//        if let path = Bundle.main.path(forResource: "testcomic", ofType: "pdf") {
//                   if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
//                       pdfView.displayMode = .singlePageContinuous
//                       pdfView.autoScales = true
//                       pdfView.displayDirection = .vertical
//                       pdfView.document = pdfDocument
//                   }
//               }
        
        // Do any additional setup after loading the view.
    }
 
    
    override func viewDidAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver (self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
        
    }
    
    
    @IBAction func btnPreviousClick(_ sender: Any) {
        
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
//        pdfView.next =
        
        pdfView.usePageViewController(true, withViewOptions: nil)

    }
    
    
    
}
