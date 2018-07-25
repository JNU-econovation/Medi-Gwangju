//
//  MedicalTourismMainViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 19/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

class MedicalTourismMainViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var youtubeWebView: UIWebView!
    @IBOutlet weak var mediTourUIView: UIView!
    @IBOutlet weak var mediTourButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messengerButton: UIButton!
    @IBOutlet weak var lookCloser: UILabel!
    @IBOutlet weak var Mudeung: UILabel!
    @IBOutlet weak var TakeALook: UILabel!
    @IBOutlet weak var callToCenter: UILabel!
    @IBOutlet weak var FBPage: UILabel!
    @IBOutlet weak var learnMore: UILabel!
    
    @IBOutlet weak var youtubeIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Mudeung.text = NSLocalizedString("무등산 주상절리", comment: "")
//        TakeALook.text = NSLocalizedString("아름다운 광주의 명소들을 
//둘러보세요", comment: "")
//        callToCenter.text = NSLocalizedString("의료관광지원센터 전화연결", comment: "")
//        FBPage.text = NSLocalizedString("페이스북 페이지(메신저)", comment: "")
        
        navigationItem.title = "Medical Tourism"
        youtubeWebView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getVideo(videoCode: "h1_CzWaaV3I")
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        youtubeIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        youtubeIndicator.stopAnimating()
    }
    
    override func viewDidLayoutSubviews() {
        //        setUIShadowAndRadius()
        setAttractionsButton()
        setBottomButtons()
        lookCloser.layer.masksToBounds = true
        lookCloser.layer.cornerRadius = 10
    }
    
    @IBAction func makeCall(_ sender: Any) {
        let alertController = UIAlertController(title: NSLocalizedString("광주의료관광지원센터", comment: ""),message: "062-714-3430", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: NSLocalizedString("전화연결", comment: ""), style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            // 전화 연결
            let phoneNumber = "062-714-3430"
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: NSLocalizedString("취소", comment: ""), style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        self.present(alertController,animated: true,completion: nil)
    }
    
    
    @IBAction func FacebookButton(_ sender: Any) {
        let attractionsVC:MedicalTourism_Attractions = UIStoryboard(name: "Attractions", bundle: nil).instantiateViewController(withIdentifier: "Attractions") as! MedicalTourism_Attractions
        
        attractionsVC.delegate = self
        attractionsVC.url = "https://www.facebook.com/mediwellgwangju/"
        self.present(attractionsVC, animated: true)
    }
    
    
    @IBAction func AttractionsButton(_ sender: Any) {
        let attractionsVC:MedicalTourism_Attractions = UIStoryboard(name: "Attractions", bundle: nil).instantiateViewController(withIdentifier: "Attractions") as! MedicalTourism_Attractions
        
        attractionsVC.delegate = self
        
        self.present(attractionsVC, animated: true)
    }
    
    func getVideo(videoCode: String)
    {
        let css = ".video-container {position:relative;padding-bottom:56.25%;height:0;overflow:hidden;} .video-container iframe, .video-container object, .video-container embed { position:absolute; top:0; left:0; width:100%; height:100%; }"
        let url = "https://www.youtube.com/embed/\(videoCode)?playsinline=1&modestbranding=1&showinfo=0&rel=0&showsearch=0&loop=1&iv_load_policy=3"
        let htmlString = "<html><head><style type=\"text/css\">\(css)</style></head><body><div class=\"video-container\"><iframe src=\"\(url)\" frameborder=\"0\"></iframe></div></body></html>"
        
        youtubeWebView.scalesPageToFit = false
        youtubeWebView.allowsInlineMediaPlayback = true;
        youtubeWebView.loadHTMLString(htmlString, baseURL: nil)
        
        //        youtubeWebView.scalesPageToFit = true
        //        youtubeWebView.loadRequest(URLRequest(url: url))
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
