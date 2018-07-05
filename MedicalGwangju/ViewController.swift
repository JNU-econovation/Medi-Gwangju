import UIKit

class ViewController: UIViewController, XMLParserDelegate{

    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    @IBOutlet var waittingBar: UIActivityIndicatorView!
    
    @IBOutlet weak var foreignStudentButton: UIButton!
    @IBOutlet weak var interExchangeCenterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dongjun's UI code Start
        foreignStudentButton.layer.cornerRadius = 10
        foreignStudentButton.layer.borderWidth = 1/UIScreen.main.nativeScale
        // Dongjun's UI code End
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

