//
//  Hospital.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 5..
//  Copyright © 2018년 sol. All rights reserved.
//



class MedicalHospital{
    
    let h_name: String
    let h_language1: Int //영어
    let h_language2: Int //중국어
    let h_language3: Int //러시아어
    let h_language4: Int //일본어
    let h_language5: Int //몽골어
    let h_language6: Int //우주베키스탄
    let h_language7: Int //카자흐스탄
    
    
    
    var meicalHospital: MedicalHospital? = nil
    init(h_name: String, h_language_1: Int, h_language_2: Int,h_language_3: Int,h_language_4: Int,h_language_5: Int,h_language_6: Int,h_language_7: Int){
        
        self.h_name = h_name
        self.h_language1 = h_language_1
        self.h_language2 = h_language_2
        self.h_language3 = h_language_3
        self.h_language4 = h_language_4
        self.h_language5 = h_language_5
        self.h_language6 = h_language_6
        self.h_language7 = h_language_7
    }
}
