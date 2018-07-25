//
//  TranslatorLanguageListViewController+FontSetting.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 16/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

extension TranslatorLanguageListViewController {
    func setNaviTitle() {
        if papagoTranslatorViewController.isLeft {
            TranslatedBarText.text = "Translate From"
        } else if papagoTranslatorViewController.isRight {
            TranslatedBarText.text = "Translate To"
        }
    }
    
    func showCurrentLang() {
        if papagoTranslatorViewController.isLeft {
            if delegate?.getSource() == "ko" {
                setSelectedFont(ButtonText: koreanButtonText)
            } else if delegate?.getSource() == "en" {
                setSelectedFont(ButtonText: englishButtonText)
            } else if delegate?.getSource() == "zh-CN" {
                setSelectedFont(ButtonText: chineseCNButtonText)
            } else if delegate?.getSource() == "zh-TW" {
                setSelectedFont(ButtonText: chineseTWButtonText)
            } else if delegate?.getSource() == "ja" {
                setSelectedFont(ButtonText: japaneseButtonText)
            } else if delegate?.getSource() == "vi" {
                setSelectedFont(ButtonText: vietnamButtonText)
            } else if delegate?.getSource() == "th" {
                setSelectedFont(ButtonText: thailandButtonText)
            }
        }
        
        if papagoTranslatorViewController.isRight {
            if delegate?.getTarget() == "ko" {
                setSelectedFont(ButtonText: koreanButtonText)
            } else if delegate?.getTarget() == "en" {
                setSelectedFont(ButtonText: englishButtonText)
            } else if delegate?.getTarget() == "zh-CN" {
                setSelectedFont(ButtonText: chineseCNButtonText)
            } else if delegate?.getTarget() == "zh-TW" {
                setSelectedFont(ButtonText: chineseTWButtonText)
            } else if delegate?.getTarget() == "ja" {
                setSelectedFont(ButtonText: japaneseButtonText)
            } else if delegate?.getTarget() == "vi" {
                setSelectedFont(ButtonText: vietnamButtonText)
            } else if delegate?.getTarget() == "th" {
                setSelectedFont(ButtonText: thailandButtonText)
            }
        }
    }
    
    func resetButtonUI() {
        setNormalFont(ButtonText: koreanButtonText)
        setNormalFont(ButtonText: englishButtonText)
        setNormalFont(ButtonText: chineseCNButtonText)
        setNormalFont(ButtonText: chineseTWButtonText)
        setNormalFont(ButtonText: japaneseButtonText)
        setNormalFont(ButtonText: vietnamButtonText)
        setNormalFont(ButtonText: thailandButtonText)
    }
    
    private func setSelectedFont(ButtonText: UIButton) {
        ButtonText.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        ButtonText.setTitleColor(themeColor, for: .normal)
    }
    
    private func setNormalFont(ButtonText: UIButton) {
        ButtonText.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        ButtonText.setTitleColor(textColor, for: .normal)
    }
}
