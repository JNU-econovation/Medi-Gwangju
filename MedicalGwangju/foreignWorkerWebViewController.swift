//
//  foreignWorkerWebViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 12/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit
import WebKit

class foreignWorkerWebViewController: UIViewController {

    @IBOutlet weak var foreignWorkerWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 외국인 근로자 Web View
        let url = URL(string: "http://health.bukgu.gwangju.kr/menu.es?mid=b10410010000")
        
        //http://www.gjfc119.or.kr/sub.html?m=5010
        let request = URLRequest(url: url!)
        foreignWorkerWebView.load(request)

        // Do any additional setup after loading the view.
    }
}
