//
//  ForignStudentViewCotroller.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 23..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit

class ForeignStudentViewCotroller: UIViewController {
    
    @IBOutlet weak var popUpUiView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var CNUtreatment: UIButton!
    @IBOutlet weak var Gwangjutreatment: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text! = NSLocalizedString("외국인유학생지원사업", comment: "")
        CNUtreatment.setTitle(NSLocalizedString("전남대학교 외국인학생 진료", comment: ""), for: .normal)
        Gwangjutreatment.setTitle(NSLocalizedString("광주 외국인 진료", comment: ""), for: .normal)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        titleLabel.layer.cornerRadius = 10
        titleLabel.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        titleLabel.layer.masksToBounds = true
        
        popUpUiView.layer.cornerRadius = 10
        popUpUiView.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        popUpUiView.clipsToBounds = true
        
        popUpUiView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        popUpUiView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        popUpUiView.layer.shadowOpacity = 0.4
        popUpUiView.layer.shadowRadius = 4.0
        popUpUiView.layer.masksToBounds = false
    }
    
    @IBAction func CNUFree(_ sender: Any) {
        
        let diagnoseVC:MedicalTourism_Attractions = UIStoryboard(name: "Attractions", bundle: nil).instantiateViewController(withIdentifier: "Attractions") as! MedicalTourism_Attractions
        
        
        diagnoseVC.url = "https://www.jnu.ac.kr/MainUniLife/Welfare/HealthResources/foreigner"
        self.present(diagnoseVC, animated: true)
        
    }
    
    @IBAction func GwangjuFree(_ sender: Any) {
        
        let diagnoseVC:MedicalTourism_Attractions = UIStoryboard(name: "Attractions", bundle: nil).instantiateViewController(withIdentifier: "Attractions") as! MedicalTourism_Attractions
        
        diagnoseVC.url = "http://health.bukgu.gwangju.kr/menu.es?mid=b10410010000"
        self.present(diagnoseVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closepopup(_ sender: Any) {
        
        self.removeAnimate()
    }
    
    
    func showAnimate() {
        
        self.view.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func removeAnimate() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        })
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
