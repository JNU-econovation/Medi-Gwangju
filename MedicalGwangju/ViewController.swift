import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, XMLParserDelegate{

    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    @IBOutlet var waittingBar: UIActivityIndicatorView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var foreignStudentButton: UIButton!
    @IBOutlet weak var interExchangeCenterButton: UIButton!
    @IBOutlet weak var foreignWorkerButton: UIButton!
    
    @IBOutlet weak var homeImageUIView: UIView!
    @IBOutlet weak var homeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Papago
        var url = "https://openapi.naver.com/v1/papago/n2mt"
        var params = ["source":"ko",
                      "target":"en",
                      "text":"만나서 반갑습니다"]
        var header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
                      "X-Naver-Client-Id":"toqi9ZVQwlEswe1OAJ2v",
                      "X-Naver-Client-Secret":"6ytathPtnO"]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseObject { (response:DataResponse<PapagoDTO>) in
            var PapagoDTO = response.result.value
            print(PapagoDTO?.message?.result?.translatedText)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        getUIImageViewRound(uiViewName: homeImageView)
        getUIViewShadow(uiViewName: homeImageUIView)
        
        getButtonRound(buttonName: searchButton)
        
        getButtonRound(buttonName: foreignStudentButton)
        getButtonShadow(buttonName: foreignStudentButton)
        
        getButtonRound(buttonName: foreignWorkerButton)
        getButtonShadow(buttonName: foreignWorkerButton)
        
        getButtonRound(buttonName: interExchangeCenterButton)
        getButtonShadow(buttonName: interExchangeCenterButton)
    }
    
    func getButtonRound(buttonName: UIButton) {
        buttonName.layer.cornerRadius = 10
        buttonName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
    }
    
    func getButtonShadow(buttonName: UIButton) {
        buttonName.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        buttonName.layer.shadowOffset = CGSize(width: 5, height: 5)
        buttonName.layer.shadowOpacity = 1
        buttonName.layer.shadowRadius = 3.0
        buttonName.layer.masksToBounds = false
    }
    
    func getUIImageViewRound(uiViewName: UIImageView) {
        uiViewName.clipsToBounds = true
        uiViewName.layer.cornerRadius = 10
        uiViewName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
        homeImageUIView.clipsToBounds = true
        homeImageUIView.layer.cornerRadius = 10
    }
    
    func getUIViewShadow(uiViewName: UIView) {
        
        uiViewName.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        uiViewName.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        uiViewName.layer.shadowOpacity = 0.2
        uiViewName.layer.shadowRadius = 3.0
        uiViewName.layer.masksToBounds = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

