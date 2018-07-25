//
//  HospitalParser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 6..
//  Copyright © 2018년 sol. All rights reserved.
//


import UIKit
import CoreLocation

class HospitalAddrParser: NSObject, XMLParserDelegate{
    
    var hospital_dong_list = [String]()
    
    var parseTemp:String = ""
    var blank:Bool=true
    var current_location: String
    var hospitaladdr_data = [String:String]()
    
    init(current_location: String) {
        
        self.current_location = current_location+"_addr"
        
        
    }
    
    func get_hospitalData() -> Void {
        
        guard let url = Bundle.main.url(forResource: current_location, withExtension: "xml")else{
//            print(" \(current_location) URL error")
            return
        }
        
        
        guard let parser = XMLParser(contentsOf: url) else{
//            print("Can't read data")
            return
        }
        
        parser.delegate = self //자신을 델리게이트에 연결
        
        let success:Bool = parser.parse()
        
        if success {
//            print("파싱했어요~")
            
        }else{
//            print("파싱 실패")
        }
        
        
    }
    
    func changeData(changeItem: inout Array<Hospital>) -> Void {
        
        var i = 0
        
        if(hospital_dong_list.count != changeItem.count){
//            print("동 파싱오류")
            return
        }
        
        for item in changeItem {
            
            item.h_dong = hospital_dong_list[i]
            
            i=i+1
        }
    }
    
    
    //element시작 잡는다 (element는 xml데이터)
    //<country>    한국        </country>
    // 시작.    중간(string)       끝(EndElement)에서 잡힌다.
    //시작태그를 만나면 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        parseTemp = elementName
        blank = true //블랭크를 쓰는 이유는 xml에서 <ㅁ><ㅁ/>뒤에 \n까지 캐릭터로 잡아버려서 detaildata의 키 값을 \n으로 바꾸게 된다. 이를 잡아주기 위해
        
    }
    
    //중간의 아이템 값을 만나면 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //딕셔너리에 스트링값 깔끔히 trim해서 넣어주기
        if blank == true {
            hospitaladdr_data [parseTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    
    //끝 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    
        //각각의 병원객체를 생성해줌
        if elementName == "item"{
            
            guard let h_dong = (hospitaladdr_data["dong"]) else{
//                print("Tag 오류")
                return }

            
            hospital_dong_list.append(h_dong)
            
        }
        
        
        
        blank = false
        
    }
    
    
    
    
}
