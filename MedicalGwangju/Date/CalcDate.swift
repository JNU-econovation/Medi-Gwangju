//
//  CalcDate.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 13..
//  Copyright © 2018년 sol. All rights reserved.
//

import Foundation

class CalcDate{
    
    let year: Int
    let month: Int
    let day: Int
    let hour: Int
    let minute: Int
    let weekDay: String
    let weekDayCode_s: String
    let weekDayCode_c: String
    static var holiday: Bool = false
    static var check: Bool = false
    
    init() {
        
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
        self.hour = calendar.component(.hour, from: date)
        self.minute = calendar.component(.minute, from: date)
        
        if(!CalcDate.check){
            
            let holiday_parser = holidayParser(year: year, month: month, day: day)
            CalcDate.holiday = holiday_parser.get_holidayData()
            CalcDate.check = true
        }
        
        if(CalcDate.holiday){
            self.weekDay = "공휴일"
            self.weekDayCode_s = "holi_dutytime_s"
            self.weekDayCode_c = "holi_dutytime_c"
        }
        else{
            if(weekday == 1) {
                self.weekDay = "일"
                self.weekDayCode_s = "sun_dutytime_s"
                self.weekDayCode_c = "sun_dutytime_c"
            }
            else if(weekday == 2) {
                self.weekDay = "월"
                self.weekDayCode_s = "mon_dutytime_s"
                self.weekDayCode_c = "mon_dutytime_c"
            }
            else if(weekday == 3) {
                self.weekDay = "화"
                self.weekDayCode_s = "tues_dutytime_s"
                self.weekDayCode_c = "tues_dutytime_c"
            }
            else if(weekday == 4) {
                self.weekDay = "수"
                self.weekDayCode_s = "wed_dutytime_s"
                self.weekDayCode_c = "wed_dutytime_c"
            }
            else if(weekday == 5) {
                self.weekDay = "목"
                self.weekDayCode_s = "thur_dutytime_s"
                self.weekDayCode_c = "thur_dutytime_c"
            }
            else if(weekday == 6) {
                self.weekDay = "금"
                self.weekDayCode_s = "fri_dutytime_s"
                self.weekDayCode_c = "fri_dutytime_c"
            }
            else {
                self.weekDay = "토"
                self.weekDayCode_s = "sat_dutytime_s"
                self.weekDayCode_c = "sat_dutytime_c"
            }
        }
    }
}
