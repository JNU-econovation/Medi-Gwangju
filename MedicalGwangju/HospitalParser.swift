//
//  HospitalParser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 6..
//  Copyright © 2018년 sol. All rights reserved.
//


import UIKit
import CoreLocation

class HospitalParser: NSObject, XMLParserDelegate{
    
    var hospital_list = [Hospital]()
    
    var GENERAL_hospital_list = [Hospital]()  //코드 A,B,C 일반병원
    var INTERNAL_hospital_list = [Hospital]()  //코드 F 내과
    var SURGERY_hospital_list = [Hospital]()  //코드 J 외과
    var ORTHOPEDICS_hospital_list = [Hospital]()  //코드 K 정형외과
    var OTORHINOLARYNGOLOGY_hospital_list = [Hospital]()  //코드 L 이비인후과
    var UROLOGY_hospital_list = [Hospital]()  //코드 O 비뇨기과
    var PLASTIC_hospital_list = [Hospital]()  //코드 P 성형외과
    var DERMATILOGY_hospital_list = [Hospital]()  //코드 Q 피부과
    var OPHTHALMOLOGY_hospital_list = [Hospital]()  //코드 S 안과
    var OBSTETRICS_hospital_list = [Hospital]()  //코드 T 산부인과
    var DENTIST_hospital_list = [Hospital]()  //코드 M,N 치과
    var NURSING_hospital_list = [Hospital]() //코드 D 요양병원
    var OrientalMedicalClinic_hospital_list = [Hospital]()  //코드 E G 한방병원,한의원
    var PUBLIC_HEALTH_hospital_list = [Hospital]() //코드 R 보건소
    var ETC_hospital_list = [Hospital]() //코드 I 기타
    
    var hospital_data = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    var i: Int = 1
    var current_location: String
    var DIVcode: String = "N"
    var forignHospital = Array<MedicalHospital>()
    
    init(current_location: String) {
        
        self.current_location = current_location
        
    }
    
    func get_hospitalData(forignHospitalData: Array<MedicalHospital>) -> Void {
        
        guard let url = Bundle.main.url(forResource: current_location, withExtension: "xml")else{
//            print("URL error")
            return
        }
        
        
        guard let parser = XMLParser(contentsOf: url) else{
//            print("Can't read data")
            return
        }
        
        parser.delegate = self //자신을 델리게이트에 연결
        self.forignHospital = forignHospitalData
        let success:Bool = parser.parse()
        
        if success {
         
            var hospitaladdr_parser = HospitalAddrParser(current_location: current_location)
            hospitaladdr_parser.get_hospitalData()
            hospitaladdr_parser.changeData(changeItem: &hospital_list)
            
            
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
            
            guard let hpid = (hospital_data["hpid"]), let h_name = (hospital_data["dutyName"]), let h_div = (hospital_data["dutyDiv"]), let h_addr = (hospital_data["dutyAddr"]),
                let h_div_name = (hospital_data["dutyDivNam"]), let h_pnumber = (hospital_data["dutyTel1"]), let h_latitude = Double((hospital_data["wgs84Lat"])!),
                let h_longitude = Double((hospital_data["wgs84Lon"])!), let is_emergentcy = Int((hospital_data["dutyEryn"])!)
                else{
//                    print("Tag 오류")
                    return }
            
            
            var dutytime_s = ["-1","-1","-1","-1","-1","-1","-1","-1"]
            var dutytime_c = ["-1","-1","-1","-1","-1","-1","-1","-1"]
            
            if let mon_dutytime_s = hospital_data["dutyTime1s"]{
                dutytime_s[0] = mon_dutytime_s
                dutytime_c[0] = hospital_data["dutyTime1c"]!
            }
            if let tues_dutytime_s = hospital_data["dutyTime2s"]{
                dutytime_s[1] = tues_dutytime_s
                dutytime_c[1] = hospital_data["dutyTime2c"]!
            }
            if let wed_dutytime_s = hospital_data["dutyTime3s"]{
                dutytime_s[2] = wed_dutytime_s
                dutytime_c[2] = hospital_data["dutyTime3c"]!
            }
            if let thur_dutytime_s = hospital_data["dutyTime4s"]{
                dutytime_s[3] = thur_dutytime_s
                dutytime_c[3] = hospital_data["dutyTime4c"]!
            }
            if let fri_dutytime_s = hospital_data["dutyTime5s"]{
                dutytime_s[4] = fri_dutytime_s
                dutytime_c[4] = hospital_data["dutyTime5c"]!
            }
            if let sat_dutytime_s = hospital_data["dutyTime6s"]{
                dutytime_s[5] = sat_dutytime_s
                dutytime_c[5] = hospital_data["dutyTime6c"]!
            }
            if let sun_dutytime_s = hospital_data["dutyTime7s"]{
                dutytime_s[6] = sun_dutytime_s
                dutytime_c[6] = hospital_data["dutyTime7c"]!
            }
            if let holi_dutytime_s = hospital_data["dutyTime8s"]{
                dutytime_s[7] = holi_dutytime_s
                dutytime_c[7] = hospital_data["dutyTime8c"]!
            }
            
            
            let h_add = h_addr.characters.split(separator: " ").map(String.init)
            var res = h_add[0] + h_add[1] + h_add[2] + h_add[3]
            
            if(res.last == ","){
                res = res.replacingOccurrences(of: ",", with: "")
            }
            
            
            let h_item: Hospital = Hospital(h_pid: hpid, h_name: h_name, h_div: h_div, h_div_name: h_div_name, h_pnumber: h_pnumber,
                                            h_latitude: h_latitude, h_longitude: h_longitude, is_emergency: is_emergentcy, mon_dutytime_s: dutytime_s[0],
                                            tues_dutytime_s: dutytime_s[1], wed_dutytime_s: dutytime_s[2], thur_dutytime_s: dutytime_s[3],
                                            fri_dutytime_s: dutytime_s[4], sat_dutytime_s: dutytime_s[5], sun_dutytime_s: dutytime_s[6],
                                            holi_dutytime_s: dutytime_s[7], mon_dutytime_c: dutytime_c[0], tues_dutytime_c: dutytime_c[1],
                                            wed_dutytime_c: dutytime_c[2], thur_dutytime_c: dutytime_c[3], fri_dutytime_c: dutytime_c[4],
                                            sat_dutytime_c: dutytime_c[5], sun_dutytime_c: dutytime_c[6] , holi_dutytime_c: dutytime_c[7],h_addr: res)
            
            //print("병원정보 \(i), \(h_item.h_pid), \(h_item.h_name), \(h_item.holi_dutytime_c)")
            
            for forign_hospital in self.forignHospital{
                
                if(forign_hospital.h_name == h_name){
                    h_item.forignHospital = forign_hospital
                    h_item.forignHospitalCheck = true
                }
            
            }
            
            i=i+1
            
            
            if( h_item.h_div == "A" || h_item.h_div == "B" || h_item.h_div == "C"){
                GENERAL_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "F"){
                INTERNAL_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "J"){
                SURGERY_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "K"){
                ORTHOPEDICS_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "L"){
                OTORHINOLARYNGOLOGY_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "O"){
                UROLOGY_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "P"){
                PLASTIC_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "Q"){
                DERMATILOGY_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "S"){
                OPHTHALMOLOGY_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "T"){
                OBSTETRICS_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "N" || h_item.h_div == "M"){
                DENTIST_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "D"){
                NURSING_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "E" || h_item.h_div == "G" ){
                OrientalMedicalClinic_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "R"){
                PUBLIC_HEALTH_hospital_list.append(h_item)
            }
            else if( h_item.h_div == "I"){
                ETC_hospital_list.append(h_item)
            }
            
            hospital_list.append(h_item)
            init_Date()
        }
        
        
        
        blank = false
        
    }
    
    func init_Date() -> Void {
        
        var k: Int = 1
        for _ in 1..<9 {
            
            let duty_c_string = "dutyTime"+String(k)+"s"
            let duty_s_string = "dutyTime"+String(k)+"c"
            hospital_data[duty_c_string] = "-1"
            hospital_data[duty_s_string] = "-1"
            k = k+1
        }
    }
    
    
}
