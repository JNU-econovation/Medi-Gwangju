//
//  HospitalParser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 6..
//  Copyright © 2018년 sol. All rights reserved.
//


import UIKit
import CoreLocation

class MedicalParser: NSObject, XMLParserDelegate{
    
    var hospital_list = [MedicalHospital]()

    var hospital_data = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    var i: Int = 1
   
    
    func get_hospitalData() -> Void {
        
        guard let url = Bundle.main.url(forResource: "MedicalList", withExtension: "xml")else{
//            print("URL error")
            return
        }
        
        
        guard let parser = XMLParser(contentsOf: url) else{
//            print("Can't read data")
            return
        }
        
        parser.delegate = self //자신을 델리게이트에 연결
        
        let success:Bool = parser.parse()
        
        if success {
            
        }else{
//            print("파싱 실패")
        }
        
        
    }
    
    
    
    
    //element시작 잡는다 (element는 xml데이터)
    //<country>    한국        </country>
    // 시작.    중간(string)       끝(EndElement)에서 잡힌다.
    //시작태그를 만나면 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        parseTemp = elementName
        blank = true //블랭크를 쓰는 이유는 xml에서 <ㅁ><ㅁ/>뒤에 \n까지 캐릭터로 잡아버려서 detaildata의 키 값을 \n으로 바꾸게 된다. 이를 잡아주기 위해
        
    }
    
    //중간의 아이템 값을 만나면 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //딕셔너리에 스트링값 깔끔히 trim해서 넣어주기
        if blank == true {
            hospital_data[parseTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    
    //끝 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //각각의 병원객체를 생성해줌
        if elementName == "item"{
            
            guard let h_name = (hospital_data["name"]), let h_language1  = (hospital_data["language1"]), let h_language2 = (hospital_data["language2"]), let h_language3 = (hospital_data["language3"]),
                let h_language4 = (hospital_data["language4"]), let h_language5 = (hospital_data["language5"]),
                let h_language6 = (hospital_data["language6"]), let h_language7 = (hospital_data["language7"])
                else{
//                    print("Tag 오류")
                    return }
            
            
            let h_item = MedicalHospital(h_name: h_name, h_language_1: Int(h_language1)!, h_language_2: Int(h_language2)!, h_language_3: Int(h_language3)!, h_language_4: Int(h_language4)!, h_language_5: Int(h_language5)!, h_language_6: Int(h_language6)!, h_language_7: Int(h_language7)!)
            
            hospital_list.append(h_item)
      
        }
        
        blank = false
        
    }
    
   
    
    
}
