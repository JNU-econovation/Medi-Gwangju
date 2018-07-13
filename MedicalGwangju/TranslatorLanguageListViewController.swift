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
}

class TranslatorLanguageListViewController: UIViewController {
    var delegate : sendBackDelegate?
    
    @IBOutlet weak var koreanButtonText: UIButton!
    @IBOutlet weak var englishButtonText: UIButton!
    @IBOutlet weak var chineseCNButtonText: UIButton!
    @IBOutlet weak var chineseTWButtonText: UIButton!
    @IBOutlet weak var japaneseButtonText: UIButton!
    @IBOutlet weak var vietnamButtonText: UIButton!
    @IBOutlet weak var thailandButtonText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func KoreanButton(_ sender: Any) {
        let param = koreanButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func EnglishButton(_ sender: Any) {
        let param = englishButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ChineseCNButton(_ sender: Any) {
        let param = chineseCNButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ChineseTWButton(_ sender: Any) {
        let param = chineseTWButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func JapaneseButton(_ sender: Any) {
        let param = japaneseButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func VietButton(_ sender: Any) {
        let param = vietnamButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ThailButton(_ sender: Any) {
        let param = thailandButtonText.currentTitle!
        delegate?.setTranslationLanguage(paramTranslateLang: param)
        papagoTranslatorViewController.isLeft = false
        papagoTranslatorViewController.isRight = false
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
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
