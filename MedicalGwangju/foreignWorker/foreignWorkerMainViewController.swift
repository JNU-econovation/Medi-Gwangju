//
//  foreignWorkerMainViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 20/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

class foreignWorkerMainViewController: UIViewController {

    @IBOutlet weak var GoHomePageButtonUI: UIButton!
    @IBOutlet weak var goHomePageUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        GoHomePageButtonUI.layer.cornerRadius = 10
        GoHomePageButtonUI.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        GoHomePageButtonUI.clipsToBounds = true
        
        GoHomePageButtonUI.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        GoHomePageButtonUI.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        GoHomePageButtonUI.layer.shadowOpacity = 0.4
        GoHomePageButtonUI.layer.shadowRadius = 3.0
        GoHomePageButtonUI.layer.masksToBounds = false
        
        goHomePageUIView.layer.cornerRadius = 10
        goHomePageUIView.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        goHomePageUIView.clipsToBounds = true
        
        goHomePageUIView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        goHomePageUIView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        goHomePageUIView.layer.shadowOpacity = 0.4
        goHomePageUIView.layer.shadowRadius = 3.0
        goHomePageUIView.layer.masksToBounds = false
    }

    @IBAction func GoHomepageButton(_ sender: Any) {
        let foreignWorkerWebVC:foreignWorkerWebViewController = UIStoryboard(name: "foreignWeb", bundle: nil).instantiateViewController(withIdentifier: "foreignWorkerWeb") as! foreignWorkerWebViewController
        
        foreignWorkerWebVC.delegate = self
        
        self.present(foreignWorkerWebVC, animated: true)
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
