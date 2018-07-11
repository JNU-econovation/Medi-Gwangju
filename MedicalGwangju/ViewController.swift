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
    
    override func viewDidLayoutSubviews()
    {
        getUIImageViewRound(uiViewName: homeImageView)
        getUIViewShadow(uiViewName: homeImageUIView)
        
        getButtonRound(buttonName: searchButton)
        
        getButtonRoundAndShadow(buttonName: foreignStudentButton)
        getButtonRoundAndShadow(buttonName: foreignWorkerButton)
        getButtonRoundAndShadow(buttonName: interExchangeCenterButton)
    }
    
    @IBAction func InterExhangeCenterAlert(_ sender: Any)
    {
        let alertController = UIAlertController(title: "외국인생활상담",message: "062-226-2732\n상담시간 : 월~금 10:00 ~18:00", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "전화연결", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            // 전화 연결
            if let phoneCallURL = URL(string: "tel://\(0622262732)") {
                
                let application:UIApplication = UIApplication.shared
                
                if (application.canOpenURL(phoneCallURL)) {
                    
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
                
            }
        }
        
        let cancelButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        self.present(alertController,animated: true,completion: nil)
    }
    
    func getButtonRound(buttonName: UIButton) {
        buttonName.layer.cornerRadius = 5
        buttonName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        buttonName.clipsToBounds = true
    }
    
    func getButtonRoundAndShadow(buttonName: UIButton) {
        buttonName.layer.cornerRadius = 10
        buttonName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        buttonName.clipsToBounds = true
        
//        buttonName.layer.shadowPath = UIBezierPath(roundedRect: buttonName.bounds, cornerRadius: buttonName.layer.cornerRadius).cgPath
        buttonName.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        buttonName.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        buttonName.layer.shadowOpacity = 0.3
        buttonName.layer.shadowRadius = 3.0
        buttonName.layer.masksToBounds = false
    }
    
    func getUIImageViewRound(uiViewName: UIImageView)
    {
        uiViewName.layer.cornerRadius = 10
        uiViewName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        uiViewName.clipsToBounds = true
        }
    
    func getUIViewShadow(uiViewName: UIView)
    {
        uiViewName.layer.cornerRadius = 10
        uiViewName.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        uiViewName.clipsToBounds = true
        
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

