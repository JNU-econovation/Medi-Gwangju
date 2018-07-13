//
//  papagoTranslatorViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 12/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class papagoTranslatorViewController: UIViewController, sendBackDelegate {
    static var isLeft = false
    static var isRight = false

    @IBOutlet weak var translateFromButton: UIButton!
    @IBOutlet weak var translateToButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기본 셋팅
        
        // Papago
        var url = "https://openapi.naver.com/v1/papago/n2mt"
        var params = ["source":"en",
                      "target":"zh-CN",
                      "text":"Nice to meet you"]
        var header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
                      "X-Naver-Client-Id":"toqi9ZVQwlEswe1OAJ2v",
                      "X-Naver-Client-Secret":"6ytathPtnO"]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseObject { (response:DataResponse<PapagoDTO>) in
            var PapagoDTO = response.result.value
            print(PapagoDTO?.message?.result?.translatedText)
            
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        // 언어 설정 후 번역 작업 전
    }

    @IBAction func TranslationFromButton(_ sender: Any)
    {
        papagoTranslatorViewController.isLeft = true
        performSegue(withIdentifier: "showTransLang", sender: self)
    }
    @IBAction func TranslationToButton(_ sender: Any)
    {
        papagoTranslatorViewController.isRight = true
        performSegue(withIdentifier: "showTransLang", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTransLang" {
            let translangVC = segue.destination as! TranslatorLanguageListViewController
            translangVC.delegate = self
        }
    }
    
    func setTranslationLanguage(paramTranslateLang: String) {
        if papagoTranslatorViewController.isLeft {
            translateFromButton.setTitle(paramTranslateLang, for: .normal)
        } else if papagoTranslatorViewController.isRight {
            translateToButton.setTitle(paramTranslateLang, for: .normal)
        }
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
