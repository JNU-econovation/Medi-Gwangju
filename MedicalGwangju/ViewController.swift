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
    @IBOutlet weak var foreignWorkerButton: UIButton!
    
    
    @IBOutlet weak var homeImageUIView: UIView!
    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var button1leading: NSLayoutConstraint!
    @IBOutlet weak var button2trailing: NSLayoutConstraint!
    @IBOutlet weak var button3leading: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
        
        button1leading.constant = 400
        button2trailing.constant = 400
        button3leading.constant = 400
        
    }
    
    private func setupNavigationBarItems() {
        navigationItem.title = "Medical Gwangju"
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        button1leading.constant = 20
        button2trailing.constant = 20
        button3leading.constant = 20
        
        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLayoutSubviews()
    {
        setUIShadowAndRadius()
    }
    
    @IBAction func ForeignStuButtonClick(_ sender: Any) {
        let popupVC: ForeignStudentViewCotroller = UIStoryboard(name: "ForignStudentPopupview", bundle: nil).instantiateViewController(withIdentifier: "ForignStudentPopupview") as! ForeignStudentViewCotroller
        
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
    }
    
    @IBAction func InterExhangeCenterAlert(_ sender: Any)
    {
        let alertController = UIAlertController(title: NSLocalizedString("외국인생활상담", comment: ""),message: NSLocalizedString("062-226-2732\n상담시간 : 월~금 10:00 ~18:00", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: NSLocalizedString("전화연결", comment: ""), style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            // 전화 연결
            let phoneNumber = "062-226-2732"
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                
                let application:UIApplication = UIApplication.shared
                
                if (application.canOpenURL(phoneCallURL)) {
                    
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
                
            }
        }
        
        let cancelButton = UIAlertAction(title: NSLocalizedString("취소", comment: ""), style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        self.present(alertController,animated: true,completion: nil)
    }    
}

