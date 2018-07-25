//
//  papagoTranslatorViewController+papago.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 17/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

extension papagoTranslatorViewController {
    func DoTranslate() {
        // Papago
        textBeforeTranslate = text.text!
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let params = ["source":source,
                      "target":target,
                      "text":textBeforeTranslate]
        let header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
                      "X-Naver-Client-Id":"toqi9ZVQwlEswe1OAJ2v",
                      "X-Naver-Client-Secret":"6ytathPtnO"]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseObject { (response:DataResponse<PapagoDTO>) in
            let PapagoDTO = response.result.value
            //            print(PapagoDTO?.message?.result?.translatedText)
            
            if self.textBeforeTranslate != "" {
                if PapagoDTO?.message?.result?.translatedText != nil {
                    self.translatedText.text = PapagoDTO?.message?.result?.translatedText
                } else {
                    self.translatedText.text = NSLocalizedString("지원하지 않는 번역입니다", comment: "")
                }
            } else {
                self.translatedText.text = ""
            }
        }
    }
}
