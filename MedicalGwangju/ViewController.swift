import UIKit

class ViewController: UIViewController, XMLParserDelegate{

    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    @IBOutlet var waittingBar: UIActivityIndicatorView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var foreignStudentButton: UIButton!
    @IBOutlet weak var interExchangeCenterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dongjun's UI code Start

        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        
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
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

