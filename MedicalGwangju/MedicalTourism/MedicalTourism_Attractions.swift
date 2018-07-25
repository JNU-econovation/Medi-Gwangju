//
//  MedicalTourism_Attractions.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 19/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

class MedicalTourism_Attractions: UIViewController, UIWebViewDelegate {
    
    var delegate: MedicalTourismMainViewController?
    var url: String = "http://mediwellgj.kr/subpage/?site=english&mn=1065"
    @IBOutlet weak var attractionsWebView: UIWebView!
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var InternetCheckLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attractionsWebView.delegate = self
        
        backButton.setTitle(NSLocalizedString("뒤로가기", comment: ""), for: .normal)
        
        //Korean
        /* http://mediwellgj.kr/subpage/?site=basic&mn=1022 */
        
        // English
        getWebsite(siteURL: url)
        
        if(!connectedToNetwork().getConnect()){
            InternetCheckLabel.isHidden = false
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        Indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Indicator.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        Indicator.stopAnimating()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func getWebsite(siteURL: String)
    {
        let url = URL(string: siteURL)
        attractionsWebView.loadRequest(URLRequest(url: url!))
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
