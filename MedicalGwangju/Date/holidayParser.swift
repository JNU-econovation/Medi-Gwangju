//
//  holidayParser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 13..
//  Copyright © 2018년 sol. All rights reserved.
//

import Foundation
struct holiday {
    let year: String
    let mon: String
    let day: String
    
    init(y: String, m: String, d: String) {
        self.year = y
        self.mon = m
        self.day = d
    }
}

class holidayParser:   NSObject, XMLParserDelegate{
    
    
    
    var holiday_data = [String:String]()
    var holiDays = Array<holiday>()
    var parseTemp:String = ""
    var blank:Bool=true
    var i: Int = 1
    
    let today_year: String
    let today_month: String
    let today_day: String
    
    init(year: Int, month: Int, day: Int) {
        
        today_year = String(year)
        today_month = String(month)
        today_day = String(day)
    }
    
    func get_holidayData() -> Bool {
        
        guard let url = Bundle.main.url(forResource: "holiday", withExtension: "xml")else{
            print("URL error")
            return false
        }
        
        
        
        guard let parser = XMLParser(contentsOf: url) else{
            print("Can't read data")
            return false
        }
        
        parser.delegate = self //자신을 델리게이트에 연결
        
        let success:Bool = parser.parse()
        
        if success {
            
            for item in holiDays {
                
                if(item.year == today_year && item.mon == today_month && item.day == today_day){
                    
                    return true
                }
            }
            
            
        }else{
            print("파싱 실패")
            return false
        }
        
        
        return false
        
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
            holiday_data[parseTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            guard let holi_year = holiday_data["year"] else {return}
            guard let holi_mon =  holiday_data["mon"] else {return}
            guard let holi_day = holiday_data["day"] else {return}
            
            let holi_temp = holiday(y: holi_year,m: holi_mon, d:holi_day)
            
            holiDays.append(holi_temp)
        }
    }
    
    //끝 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //각각의 병원객체를 생성해줌
        if elementName == "item"{
            
            
        }
        
        blank = false
        
    }
    
    
    
}

