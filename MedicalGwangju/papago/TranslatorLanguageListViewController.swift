//
//  TranslatorLanguageListViewController.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 14/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

protocol sendBackDelegate {
    func setTranslationLanguage(paramTranslateLang: String)
    func getSource() -> String
    func getTarget() -> String
}

class TranslatorLanguageListViewController: UIViewController {
    var delegate : sendBackDelegate?
    let themeColor = UIColor(red: 93/255, green: 199/255, blue: 145/255, alpha: 1)
    let textColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1)
    
    @IBOutlet weak var TranslatedBarText: UILabel!
    
    @IBOutlet weak var koreanButtonText: UIButton!
    @IBOutlet weak var englishButtonText: UIButton!
    @IBOutlet weak var chineseCNButtonText: UIButton!
    @IBOutlet weak var chineseTWButtonText: UIButton!
    @IBOutlet weak var japaneseButtonText: UIButton!
    @IBOutlet weak var vietnamButtonText: UIButton!
    @IBOutlet weak var thailandButtonText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        koreanButtonText.setTitle(NSLocalizedString("한국어", comment: ""), for: .normal)
        englishButtonText.setTitle(NSLocalizedString("영어", comment: ""), for: .normal)
        chineseCNButtonText.setTitle(NSLocalizedString("중국어-간체", comment: ""), for: .normal)
        chineseTWButtonText.setTitle(NSLocalizedString("중국어-번체", comment: ""), for: .normal)
        japaneseButtonText.setTitle(NSLocalizedString("일본어", comment: ""), for: .normal)
        vietnamButtonText.setTitle(NSLocalizedString("베트남어", comment: ""), for: .normal)
        thailandButtonText.setTitle(NSLocalizedString("태국어", comment: ""), for: .normal)
        
        setNaviTitle()
    }
    
    override func viewDidLayoutSubviews() {
        resetButtonUI()
        showCurrentLang()
    }
    
    @IBAction func KoreanButton(_ sender: Any) {
        BackToTranslator(ButtonText: koreanButtonText)
    }
    @IBAction func EnglishButton(_ sender: Any) {
        BackToTranslator(ButtonText: englishButtonText)
    }
    @IBAction func ChineseCNButton(_ sender: Any) {
        BackToTranslator(ButtonText: chineseCNButtonText)
    }
    @IBAction func ChineseTWButton(_ sender: Any) {
        BackToTranslator(ButtonText: chineseTWButtonText)
    }
    @IBAction func JapaneseButton(_ sender: Any) {
        BackToTranslator(ButtonText: japaneseButtonText)
    }
    @IBAction func VietButton(_ sender: Any) {
        BackToTranslator(ButtonText: vietnamButtonText)
    }
    @IBAction func ThailButton(_ sender: Any) {
        BackToTranslator(ButtonText: thailandButtonText)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    
    func BackToTranslator(ButtonText: UIButton) {
        let param = ButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
