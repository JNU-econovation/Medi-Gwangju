//
//  foreignWorkerWebViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 12/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

class foreignWorkerWebViewController: UIViewController, UIWebViewDelegate {

    var delegate: foreignWorkerMainViewController?
    
    @IBOutlet weak var workerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var workerWebView: UIWebView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setTitle(NSLocalizedString("뒤로가기", comment: ""), for: .normal)
        
        workerWebView.delegate = self
        getWebsite(siteURL: "http://www.gjfc119.or.kr/index.php")
        
        // http://www.gjfc119.or.kr/sub.html?m=5010
        //http://health.bukgu.gwangju.kr/menu.es?mid=b10410010000
    }
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        workerIndicator.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        workerIndicator.stopAnimating()
    }
    
    func getWebsite(siteURL: String)
    {
        let url = URL(string: siteURL)
        workerWebView.loadRequest(URLRequest(url: url!))
    }
}
