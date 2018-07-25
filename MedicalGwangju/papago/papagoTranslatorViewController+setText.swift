//
//  papagoTranslatorViewController+setText.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 17/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

extension papagoTranslatorViewController {
    
    
    func setTranslateFromText() {
        if translateFromButton.currentTitle! == NSLocalizedString("한국어", comment: "") {
            source = "ko"
        } else if translateFromButton.currentTitle! == NSLocalizedString("영어", comment: "") {
            source = "en"
        } else if translateFromButton.currentTitle! == NSLocalizedString("중국어-간체", comment: ""){
            source = "zh-CN"
        } else if translateFromButton.currentTitle! == NSLocalizedString("중국어-번체", comment: "") {
            source = "zh-TW"
        } else if translateFromButton.currentTitle! == NSLocalizedString("일본어", comment: "") {
            source = "ja"
        } else if translateFromButton.currentTitle! == NSLocalizedString("베트남어", comment: ""){
            source = "vi"
        } else if translateFromButton.currentTitle! == NSLocalizedString("태국어", comment: "") {
            source = "th"
        }
    }
    
    func setTranslateToText() {
        if translateToButton.currentTitle! == NSLocalizedString("한국어", comment: "") {
            target = "ko"
        } else if translateToButton.currentTitle! == NSLocalizedString("영어", comment: "") {
            target = "en"
        } else if translateToButton.currentTitle! == NSLocalizedString("중국어-간체", comment: ""){
            target = "zh-CN"
        } else if translateToButton.currentTitle! == NSLocalizedString("중국어-번체", comment: ""){
            target = "zh-TW"
        } else if translateToButton.currentTitle! == NSLocalizedString("일본어", comment: "") {
            target = "ja"
        } else if translateToButton.currentTitle! == NSLocalizedString("베트남어", comment: ""){
            target = "vi"
        } else if translateToButton.currentTitle! == NSLocalizedString("태국어", comment: ""){
            target = "th"
        }
    }
}
