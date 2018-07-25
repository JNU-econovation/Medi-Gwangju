//
//  hospiparser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 16..
//  Copyright © 2018년 sol. All rights reserved.
//

import Foundation

//
//  HospitalParser.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 6..
//  Copyright © 2018년 sol. All rights reserved.
//


import UIKit
import CoreLocation

class hospitalData
{
    var DIVCode: String = "N"
    var curCode: String = ""
    
    let BukguhospitalData = HospitalParser(current_location: "Buk-gu")
    let NamguhospitalData = HospitalParser(current_location: "Nam-gu")
    let SeoguhospitalData = HospitalParser(current_location: "Seo-gu")
    let DongguhospitalData = HospitalParser(current_location: "Dong-gu")
    let GwangsanguhospitalData = HospitalParser(current_location: "Gwangsan-gu")    
    let forignHospitalData: MedicalParser?
    
    init(forignHospitalData: MedicalParser) {
       
        self.forignHospitalData = forignHospitalData
        
        BukguhospitalData.get_hospitalData(forignHospitalData: forignHospitalData.hospital_list)
        NamguhospitalData.get_hospitalData(forignHospitalData: forignHospitalData.hospital_list)
        SeoguhospitalData.get_hospitalData(forignHospitalData: forignHospitalData.hospital_list)
        DongguhospitalData.get_hospitalData(forignHospitalData: forignHospitalData.hospital_list)
        GwangsanguhospitalData.get_hospitalData(forignHospitalData: forignHospitalData.hospital_list)
       
        
        
            
    }
    
    //현위치로부터 가까운 병원 30개의 데이터를 구한다.
    func get_close_hospitalData(latitude: Double, longitude: Double, DIV: String, realTime: Bool, loc: String) -> [Hospital]?{
        
     
        var rank_hospital_data = [Hospital]()
        let startLocation = CLLocation(latitude: latitude,longitude: longitude)
        var cnt: Int = 0
        var MedicalHospitalList = Array<Hospital>()
        var temp_hospital_list = [Hospital]()
        
        let date = CalcDate() //날짜 계산
        
        DIVCode = DIV
        curCode = loc
        
        
        
        if( DIVCode == "A" || DIVCode == "B" || DIVCode == "C"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.GENERAL_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.GENERAL_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.GENERAL_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.GENERAL_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.GENERAL_hospital_list)
        }
        else if(DIVCode == "F"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.INTERNAL_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.INTERNAL_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.INTERNAL_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.INTERNAL_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.INTERNAL_hospital_list)
            
        }
        else if( DIVCode == "J"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.SURGERY_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.SURGERY_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.SURGERY_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.SURGERY_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.SURGERY_hospital_list)
            
        }
        else if( DIVCode == "K"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.ORTHOPEDICS_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.ORTHOPEDICS_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.ORTHOPEDICS_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.ORTHOPEDICS_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.ORTHOPEDICS_hospital_list)
            
        }
        else if( DIVCode == "L"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.OTORHINOLARYNGOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.OTORHINOLARYNGOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.OTORHINOLARYNGOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.OTORHINOLARYNGOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.OTORHINOLARYNGOLOGY_hospital_list)
            
        }
        else if( DIVCode == "O"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.UROLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.UROLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.UROLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.UROLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.UROLOGY_hospital_list)
            
        }
            
        else if( DIVCode == "P"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.PLASTIC_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.PLASTIC_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.PLASTIC_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.PLASTIC_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.PLASTIC_hospital_list)
            
        }
            
        else if( DIVCode == "Q"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.DERMATILOGY_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.DERMATILOGY_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.DERMATILOGY_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.DERMATILOGY_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.DERMATILOGY_hospital_list)
            
        }
            
        else if( DIVCode == "S"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.OPHTHALMOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.OPHTHALMOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.OPHTHALMOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.OPHTHALMOLOGY_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.OPHTHALMOLOGY_hospital_list)
            
        }
            
        else if( DIVCode == "T"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.OBSTETRICS_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.OBSTETRICS_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.OBSTETRICS_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.OBSTETRICS_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.OBSTETRICS_hospital_list)
            
        }
            
        else if( DIVCode == "N" || DIVCode == "M"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.DENTIST_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.DENTIST_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.DENTIST_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.DENTIST_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.DENTIST_hospital_list)
            
        }
        else if( DIVCode == "D"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.NURSING_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.NURSING_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.NURSING_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.NURSING_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.NURSING_hospital_list)
            
        }
        else if( DIVCode == "E" || DIVCode == "G" ){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.OrientalMedicalClinic_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.OrientalMedicalClinic_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.OrientalMedicalClinic_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.OrientalMedicalClinic_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.OrientalMedicalClinic_hospital_list)
            
        }
        else if( DIVCode == "R"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.PUBLIC_HEALTH_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.PUBLIC_HEALTH_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.PUBLIC_HEALTH_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.PUBLIC_HEALTH_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.PUBLIC_HEALTH_hospital_list)
            
        }
            
        else if(DIVCode == "I"){
            
            temp_hospital_list.append(contentsOf: BukguhospitalData.ETC_hospital_list)
            temp_hospital_list.append(contentsOf: NamguhospitalData.ETC_hospital_list)
            temp_hospital_list.append(contentsOf: GwangsanguhospitalData.ETC_hospital_list)
            temp_hospital_list.append(contentsOf: SeoguhospitalData.ETC_hospital_list)
            temp_hospital_list.append(contentsOf: DongguhospitalData.ETC_hospital_list)
            
        }
        
        
        for hospitalData in temp_hospital_list{
            
            if hospitalData.h_pid == "FOR"{
                 hospitalData.h_distance = 0
            }
            else{
                if(hospitalData.forignHospitalCheck){
                    hospitalData.h_distance = 0
                }else{
                    let destinationLocation = CLLocation(latitude: hospitalData.h_latitude,longitude: hospitalData.h_longitude)
                    let distance_temp: CLLocationDistance = destinationLocation.distance(from: startLocation)
                    hospitalData.h_distance = Int(distance_temp)
                }
            }
        }
        
        //거리 순(현재위치에 가까운 순서)에 따라 병원데이터 정렬
        temp_hospital_list = temp_hospital_list.sorted(by: {$0.h_distance < $1.h_distance})
        
        for close_hospital in temp_hospital_list{
            
            if(close_hospital.h_distance != -1){
                
                //실시간 체크
                if(realTime){
                    if(checkRealTime(hospital: close_hospital, date: date)){
                        rank_hospital_data.append(close_hospital)
                        cnt = cnt + 1
                    }
                }else{
                    rank_hospital_data.append(close_hospital)
                    cnt = cnt + 1
                }
            }
            
            if(cnt >= 30){
                break
                
            }
        }
        
//        print("가까운 병원 수: \(rank_hospital_data.count)")
        
     /*  for hospitalData in rank_hospital_data{
        print("병원이름: \(hospitalData.h_name) , 동: \(hospitalData.h_dong)   ")
            if(hospitalData.meicalHospital != nil){
                print("광주 데이터에요")
            }
        }
    */
        
        return rank_hospital_data
    }
    
    //시간범위 계산
    func checkRealTimeRange(startTime: String, finishTime: String, date:CalcDate) -> Bool {
        
        var s_index = startTime.index(startTime.startIndex, offsetBy:2)
        var f_index = startTime.index(s_index, offsetBy:2)
        var range = s_index..<f_index
        
        let h_hour_s = Int(startTime.substring(to: s_index))!
        let h_min_s = Int(startTime.substring(with: range))!
        
        s_index = finishTime.index(finishTime.startIndex, offsetBy:2)
        f_index = finishTime.index(s_index, offsetBy:2)
        range = s_index..<f_index
        
        let h_hour_c = Int(finishTime.substring(to: s_index))!
        let h_min_c = Int(finishTime.substring(with: range))!
        
        if(date.hour > h_hour_s && date.hour < h_hour_c){
            return true
        }
        
        if(date.hour == h_hour_s ){
            
            if( date.minute >= h_min_s ){
                return true
            }
        }
        
        if( date.hour == h_hour_c){
            
            if(date.minute <= h_min_c){
                return true
            }
        }
        
        
        return false
    }
    
    func checkRealTime(hospital: Hospital, date: CalcDate) -> Bool {
        
        if (date.weekDay == "월"){
            
            if(hospital.mon_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.mon_dutytime_s, finishTime: hospital.mon_dutytime_c, date: date)
            }
            
            
        } else if (date.weekDay == "화"){
            
            if(hospital.tues_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.tues_dutytime_s, finishTime: hospital.tues_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "수"){
            
            if(hospital.wed_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.wed_dutytime_s, finishTime: hospital.wed_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "목"){
            
            if(hospital.thur_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.thur_dutytime_s, finishTime: hospital.thur_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "금"){
            
            if(hospital.fri_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.fri_dutytime_s, finishTime: hospital.fri_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "토"){
            
            if(hospital.sat_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.sat_dutytime_s, finishTime: hospital.sat_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "일"){
            
            if(hospital.sun_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.sun_dutytime_s, finishTime: hospital.sun_dutytime_c, date: date)
            }
            
        } else if (date.weekDay == "공휴일"){
            
            if(hospital.holi_dutytime_s != "-1"){
                
                return checkRealTimeRange(startTime: hospital.holi_dutytime_s, finishTime: hospital.holi_dutytime_c, date: date)
            }
            
        }
        
        return false
    }
    
}
