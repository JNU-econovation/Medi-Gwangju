//
//  Hospital.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 5..
//  Copyright © 2018년 sol. All rights reserved.
//



class Hospital{
    
    let h_pid: String
    let h_name: String
    let h_div: String
    let h_div_name: String
    let h_pnumber: String
    let h_latitude: Double
    let h_longitude: Double
    let h_addr: String
    let is_emergency: Int
    let mon_dutytime_s: String
    let tues_dutytime_s: String
    let wed_dutytime_s: String
    let thur_dutytime_s: String
    let fri_dutytime_s: String
    let sat_dutytime_s: String
    let sun_dutytime_s: String
    let holi_dutytime_s: String
    let mon_dutytime_c: String
    let tues_dutytime_c: String
    let wed_dutytime_c: String
    let thur_dutytime_c: String
    let fri_dutytime_c: String
    let sat_dutytime_c: String
    let sun_dutytime_c: String
    let holi_dutytime_c: String
    var h_distance: Int = -1
    var h_marker: Bool = true
    var availableTime: Bool = true
    var h_dong = ""
    var forignHospital: MedicalHospital? = nil
    var forignHospitalCheck = false
    init(h_pid: String, h_name: String, h_div: String, h_div_name: String, h_pnumber: String,
         h_latitude: Double, h_longitude: Double, is_emergency: Int, mon_dutytime_s: String,
         tues_dutytime_s: String, wed_dutytime_s: String, thur_dutytime_s: String, fri_dutytime_s: String,
         sat_dutytime_s: String, sun_dutytime_s: String, holi_dutytime_s: String, mon_dutytime_c: String, tues_dutytime_c: String
        ,wed_dutytime_c: String, thur_dutytime_c: String, fri_dutytime_c: String, sat_dutytime_c: String, sun_dutytime_c: String, holi_dutytime_c: String, h_addr: String) {
        
        self.h_pid = h_pid
        self.h_name = h_name
        self.h_div = h_div
        self.h_div_name = h_div_name
        self.h_pnumber = h_pnumber
        self.h_latitude = h_latitude
        self.h_longitude   = h_longitude
        self.is_emergency = is_emergency
        self.mon_dutytime_s = mon_dutytime_s
        self.tues_dutytime_s = tues_dutytime_s
        self.wed_dutytime_s = wed_dutytime_s
        self.thur_dutytime_s = thur_dutytime_s
        self.fri_dutytime_s = fri_dutytime_s
        self.sat_dutytime_s = sat_dutytime_s
        self.sun_dutytime_s = sun_dutytime_s
        self.holi_dutytime_s = holi_dutytime_s
        self.mon_dutytime_c = mon_dutytime_c
        self.tues_dutytime_c = tues_dutytime_c
        self.wed_dutytime_c = wed_dutytime_c
        self.thur_dutytime_c = thur_dutytime_c
        self.fri_dutytime_c = fri_dutytime_c
        self.sat_dutytime_c = sat_dutytime_c
        self.sun_dutytime_c = sun_dutytime_c
        self.holi_dutytime_c = holi_dutytime_c
        self.h_addr = h_addr
    }
}
