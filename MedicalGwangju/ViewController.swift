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
    @IBOutlet weak var HomeImages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dongjun's UI code Start
        
        // 홈 이미지
        HomeImages.layer.cornerRadius = 20
        HomeImages.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
        HomeImages.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        HomeImages.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        HomeImages.layer.shadowOpacity = 0.2
        HomeImages.layer.shadowRadius = 3.0
        HomeImages.layer.masksToBounds = false
        
        // 검색 버튼
        searchButton.layer.cornerRadius = 9
        searchButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
        searchButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        searchButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        searchButton.layer.shadowOpacity = 0.2
        searchButton.layer.shadowRadius = 3.0
        searchButton.layer.masksToBounds = false
        
        // 유학생이세요?
        foreignStudentButton.layer.cornerRadius = 10
        foreignStudentButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
        foreignStudentButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        foreignStudentButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        foreignStudentButton.layer.shadowOpacity = 0.2
        foreignStudentButton.layer.shadowRadius = 3.0
        foreignStudentButton.layer.masksToBounds = false
        
        // 광주국제교류센터
        interExchangeCenterButton.layer.cornerRadius = 10
        interExchangeCenterButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
        interExchangeCenterButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        interExchangeCenterButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        interExchangeCenterButton.layer.shadowOpacity = 0.2
        interExchangeCenterButton.layer.shadowRadius = 3.0
        interExchangeCenterButton.layer.masksToBounds = false
        
        // Dongjun's UI code End
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

