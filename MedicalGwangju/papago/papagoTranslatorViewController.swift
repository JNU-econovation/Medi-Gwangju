import UIKit

extension papagoTranslatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == text {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}

class papagoTranslatorViewController: UIViewController, sendBackDelegate {
    static var isLeft = false
    static var isRight = false

    @IBOutlet weak var translateFromButton: UIButton!
    @IBOutlet weak var translateToButton: UIButton!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var exchange_arrow: UIButton!
    
    var source: String = ""
    var target: String = ""
    var textBeforeTranslate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateFromButton.setTitle(NSLocalizedString("한국어", comment: ""), for: .normal)
        translateToButton.setTitle(NSLocalizedString("영어", comment: ""), for: .normal)
        
        // text
        self.text.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        // 교환 버튼 크기 조절
//        exchange_arrow.imageEdgeInsets = UIEdgeInsetsMake(17, 17, 17, 17)
    }
    
    @IBAction func exchange_Lang(_ sender: Any) {
        let temp = translateFromButton.currentTitle
        translateFromButton.setTitle(translateToButton.currentTitle, for: .normal)
        translateToButton.setTitle(temp, for: .normal)
        setTranslateFromText()
        setTranslateToText()
        DoTranslate()
    }
    
    @IBAction func returnText(_ sender: Any) {
        DoTranslate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // param setting
        setTranslateFromText()
        setTranslateToText()
        
        text.text = ""
        translatedText.text = ""
    }

    @IBAction func TranslationFromButton(_ sender: Any)
    {
        papagoTranslatorViewController.isLeft = true
        performSegue(withIdentifier: "showTransLang", sender: self)
    }
    @IBAction func TranslationToButton(_ sender: Any)
    {
        papagoTranslatorViewController.isRight = true
        performSegue(withIdentifier: "showTransLang", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTransLang" {
            let translangVC = segue.destination as! TranslatorLanguageListViewController
            translangVC.delegate = self
        }
    }
    
    func setTranslationLanguage(paramTranslateLang: String) {
        if papagoTranslatorViewController.isLeft {
            translateFromButton.setTitle(NSLocalizedString(paramTranslateLang, comment: ""), for: .normal)
        } else if papagoTranslatorViewController.isRight {
            translateToButton.setTitle(NSLocalizedString(paramTranslateLang, comment: ""), for: .normal)
        }
    }
    
    func getSource() -> String {
        return source
    }
    func getTarget() -> String {
        return target
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
