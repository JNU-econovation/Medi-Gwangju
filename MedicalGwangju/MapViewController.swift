import UIKit
import GoogleMaps

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var subView: MapViewContainer?
    var selHosptial: Hospital? //상세히 표시할 병원
    var checkRealtime: Bool = false // 실시간으로 진료중인 병원만 볼 것인지 (default 는 전체보기)
    var myHospitalItem: Array<Hospital>? = nil
    let locationManager = gpsAuthorization() //위치 매니저
    var checkGPS: Bool = false //위치버튼 활성화 확인
    @IBOutlet weak var sel_h_name: UILabel!  // 선택한 병원 팝업창에서 병원이름
    @IBOutlet weak var sel_h_distance: UILabel! // 선택한 병원 팝업창에서 나와의 거리
    @IBOutlet weak var sel_h_addr: UILabel! //선택한 병원 팝업창에서 병원주소
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var h_popUp_bottom: NSLayoutConstraint!
    @IBOutlet weak var call_h_button: UIButton!
    
    // 팝업뷰
    @IBOutlet weak var popupViewwithTag: UIView!
    @IBOutlet weak var h_popUp_Tag_bottom: NSLayoutConstraint!
    @IBOutlet weak var call_h_Tag_button: UIButton!
    @IBOutlet weak var sel_h_Tag_name: UILabel!
    @IBOutlet weak var sel_h_Tag_distance: UILabel!
    @IBOutlet weak var sel_h_Tag_addr: UILabel!
    @IBOutlet weak var tagImageView: UIImageView!
    
    // 병원 전체 목록 IBOutlet
    @IBOutlet weak var h_table_down: NSLayoutConstraint!
    @IBOutlet weak var h_table_up: NSLayoutConstraint!
    @IBOutlet weak var h_tableView: UITableView!
    @IBOutlet weak var h_table_button: UIButton!

    // 실시간 병원
    @IBOutlet weak var all_now_button: UIButton!
    @IBOutlet weak var all_now_buttonWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("루트 뷰 로딩")
        
        h_tableView.dataSource = self
        h_tableView.delegate = self
        
        //화면터치 이벤트 등록
        popupView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        popupViewwithTag.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        // 팝업 창 초기 세팅
        h_popUp_bottom.constant = 200
        h_popUp_Tag_bottom.constant = -150
        // 병원 목록 보기 세팅
        h_table_down.priority = UILayoutPriority(rawValue: 1000)
        h_table_up.priority = UILayoutPriority(rawValue: 750)
        
        // 실시간 세팅
//        findRealTimeButton.setTitle("ALL", for: .normal)
        
        myHospitalItem = Array<Hospital>()
        
        self.checkGPS = locationManager.checkAuthorization()
    
        if(!connectedToNetwork().getConnect()){
            let message = "인터넷에 연결되지 않았습니다."
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            
            // duration in seconds
            let duration: Double = 1
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        // UI
        
        // POP UP
        popupView.layer.cornerRadius = 10
        popupView.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        popupView.clipsToBounds = true
        
        getUIViewShadow(uiViewName: popupView)
        call_h_button.layer.cornerRadius = 10
        
        popupViewwithTag.layer.cornerRadius = 10
        popupViewwithTag.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        popupViewwithTag.clipsToBounds = true
        
        getUIViewShadow(uiViewName: popupViewwithTag)
        call_h_Tag_button.layer.cornerRadius = 10
        
        // TABLE
        h_table_button.layer.borderColor = UIColor.gray.cgColor
        h_table_button.layer.borderWidth = 0.2
        
        all_now_button.layer.cornerRadius = 10
        let textWidth = all_now_button.intrinsicContentSize.width
        let width = textWidth + 24
        all_now_buttonWidth.constant = width
        getUIButtonShadow(uiButtonName: all_now_button)
    }
    
    @IBAction func all_now_action(_ sender: Any) {
        if(checkRealtime){
            //전체보기 버튼 변경하기
            checkRealtime = false
            all_now_button.fromNOWtoALL(widthConstraints: all_now_buttonWidth)
        }else{
            //실시간보기 코든
            checkRealtime = true
            all_now_button.fromALLtoNOW(widthConstraints: all_now_buttonWidth)
        }
        subView?.changeRealTime(realTime: checkRealtime)
    }
    
    //전화연결 구현
    @IBAction func callHospital(_ sender: Any) {
        var sel_number = selHosptial?.h_pnumber
        
        let alertController = UIAlertController(title: sel_h_name.text ,message: "\((sel_number)!)", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: NSLocalizedString("전화연결", comment: ""), style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            // 전화 연결
            if let phoneCallURL = URL(string: "tel://\((sel_number)!)") {
                
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
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            let selectView:DetailHospitalController = UIStoryboard(name: "DetailHospital", bundle: nil).instantiateViewController(withIdentifier: "DetailHospitalView") as! DetailHospitalController
            
            selectView.superView = self
            
            self.navigationController?.pushViewController(selectView, animated: true)
        }
        sender.cancelsTouchesInView = false
    }
    
    
    func change_h_tableView() -> Void {
    
        self.checkGPS  = locationManager.checkAuthorization()
        
        guard let displayItem = subView?.myhospitalData else {
            return
        }
        
        self.myHospitalItem = nil
        self.myHospitalItem = displayItem
        
        if(checkGPS){
            //거리구하기
            guard let mylocation = locationManager.getMyLoaction() else{
                
                self.h_tableView.reloadData()
                return
            }
            
            var cnt = 0
            
            for myitem in displayItem{
                let destinationLocation = CLLocation(latitude: myitem.h_latitude,longitude: myitem.h_longitude)
                let distance_temp: CLLocationDistance = destinationLocation.distance(from: mylocation)
                
                self.myHospitalItem![cnt].h_distance = Int(distance_temp)
                cnt += 1
            }
            
            self.myHospitalItem! = self.myHospitalItem!.sorted(by: {$0.h_distance < $1.h_distance})
        }
        
        
        self.h_tableView.reloadData()
    }
    
    //병원 목록리스트 보기 (테이블 뷰)
    @IBAction func show_h_tableView(_ sender: Any) {
        
        if Int(h_table_down.priority.rawValue) >= 999 {
            h_table_button.setTitle("병원 목록 닫기", for: .normal)
            h_table_button.setTitle(NSLocalizedString("병원 목록 닫기", comment: ""), for: .normal)
            h_table_down = h_table_down.changePriority(valueOfPriority: 700)
            h_table_up = h_table_up.changePriority(valueOfPriority: 999)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            h_table_button.setTitle("병원 목록 보기", for: .normal)
            h_table_button.setTitle(NSLocalizedString("병원 목록 보기", comment: ""), for: .normal)
            h_table_down.priority = UILayoutPriority(rawValue: 999)
            h_table_up.priority = UILayoutPriority(rawValue: 700)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    func close_h_popup() -> Void {
        h_popUp_bottom.constant = 200
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func close_h_Tag_popup() -> Void {
        h_popUp_Tag_bottom.constant = -150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func show_h_popup(item: Hospital, latitude: Double, longitude: Double, gpsCheck: Bool){
        
        selHosptial = nil
        
        h_popUp_bottom.constant = -45
        sel_h_name.text! = NSLocalizedString(item.h_name, comment: "")
        sel_h_addr.text! = NSLocalizedString(item.h_addr, comment: "")
        
        selHosptial = item
        
        if(gpsCheck){
            //거리구하기
            
            let destinationLocation = CLLocation(latitude: item.h_latitude,longitude: item.h_longitude)
            let myLocation = CLLocation(latitude: latitude,longitude: longitude)
            let distance_temp: CLLocationDistance = destinationLocation.distance(from: myLocation)
            
            var distance_temp2 = 0
            var distance_temp_String : String
            
            if distance_temp >= 1000
            {
                distance_temp2 = Int(distance_temp/100)
                distance_temp_String = String(Int(distance_temp2)/10) + "." + String(Int(distance_temp2)%10) + " km"
            } else {
                distance_temp2 = Int(distance_temp)
                distance_temp_String = String(Int(distance_temp2)) + " m"
            }
            
            sel_h_distance.text! = (distance_temp_String)
        }else{
            sel_h_distance.text! = "0m"
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func show_h_Tag_popup(item: Hospital, latitude: Double, longitude: Double, gpsCheck: Bool){
        
        selHosptial = nil
        
        h_popUp_Tag_bottom.constant = 45
        sel_h_Tag_name.text! = NSLocalizedString(item.h_name, comment: "")
        sel_h_Tag_addr.text! = NSLocalizedString(item.h_addr, comment: "")
        
        selHosptial = item
        
        if(gpsCheck){
            //거리구하기
            
            let destinationLocation = CLLocation(latitude: item.h_latitude,longitude: item.h_longitude)
            let myLocation = CLLocation(latitude: latitude,longitude: longitude)
            let distance_temp: CLLocationDistance = destinationLocation.distance(from: myLocation)
            
            var distance_temp2 = 0
            var distance_temp_String : String
            
            if distance_temp >= 1000
            {
                distance_temp2 = Int(distance_temp/100)
                distance_temp_String = String(Int(distance_temp2)/10) + "." + String(Int(distance_temp2)%10) + " km"
            } else {
                distance_temp2 = Int(distance_temp)
                distance_temp_String = String(Int(distance_temp2)) + " m"
            }
            
            sel_h_Tag_distance.text! = (distance_temp_String)
        }else{
            sel_h_Tag_distance.text! = "0m"
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "googlemap" {
            let mapviewVC = segue.destination as! MapViewContainer
            mapviewVC.superView = self
            self.subView = mapviewVC
        }
    }
    
    @IBAction func selectDIV(_ sender: Any) {
        let selectView:selectDIVController = UIStoryboard(name: "selectDIVController", bundle: nil).instantiateViewController(withIdentifier: "selectDIV") as! selectDIVController
        
        selectView.delegate = self
        
        self.present(selectView, animated: true)
    }
    
    // Shadow
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
    
    func getUIButtonShadow(uiButtonName: UIButton)
    {
        uiButtonName.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        uiButtonName.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        uiButtonName.layer.shadowOpacity = 0.2
        uiButtonName.layer.shadowRadius = 3.0
        uiButtonName.layer.masksToBounds = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myHospitalItem!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell //커스텀 셀로 쓰겠다.(형변환)
        
        let dicTemp = self.myHospitalItem?[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        cell.h_nameLabel.text = NSLocalizedString(dicTemp!.h_name, comment: "")
        cell.h_addrLabel.text = NSLocalizedString(dicTemp!.h_addr, comment: "")
        
        if(checkGPS){
            
            let distance_temp = dicTemp!.h_distance
            
            var distance_temp2 = 0
            var distance_temp_String : String
            
            if distance_temp >= 1000
            {
                distance_temp2 = Int(distance_temp/100)
                distance_temp_String = String(Int(distance_temp2)/10) + "." + String(Int(distance_temp2)%10) + " km"
            } else {
                distance_temp2 = Int(distance_temp)
                distance_temp_String = String(Int(distance_temp2)) + " m"
            }
            
            cell.h_distanceLabel.text! = (distance_temp_String)
        }else{
            cell.h_distanceLabel.text! = "0m"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    //테이블 뷰 클릭시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selHosptial = self.myHospitalItem?[indexPath.row]
        let selectView:DetailHospitalController = UIStoryboard(name: "DetailHospital", bundle: nil).instantiateViewController(withIdentifier: "DetailHospitalView") as! DetailHospitalController
        
        selectView.superView = self
        
        self.navigationController?.pushViewController(selectView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension NSLayoutConstraint
{
    func changePriority(valueOfPriority: Int) -> NSLayoutConstraint
    {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(item: self.firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: self.multiplier, constant: self.constant)
        
        newConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(valueOfPriority))
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}

extension UIButton
{
    func fromALLtoNOW(widthConstraints: NSLayoutConstraint)
    {
        var textWidth: CGFloat = 0
        var width: CGFloat = 0
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.layer.cornerRadius = 10
            self.backgroundColor = UIColor(red: 93/255, green: 199/255, blue: 145/255, alpha: 1)
            self.setTitle("현재 진료 가능 병원", for: .normal)
            self.setTitle("현재 진료 가능 병원", for: .highlighted)
            self.setTitle(NSLocalizedString("현재 진료 가능 병원", comment: ""), for: .normal)
            self.setTitle(NSLocalizedString("현재 진료 가능 병원", comment: ""), for: .highlighted)
            
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white, for: .highlighted)
            textWidth = self.intrinsicContentSize.width
            width = textWidth + 24
            widthConstraints.constant = width
        }) { (_) in
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.setTitle("NOW", for: .normal)
                self.setTitle("NOW", for: .highlighted)
                textWidth = self.intrinsicContentSize.width
                width = textWidth + 24
                widthConstraints.constant = width
                })
        }
    }
    
    func fromNOWtoALL(widthConstraints: NSLayoutConstraint)
    {
        var textWidth: CGFloat = 0
        var width: CGFloat = 0
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.layer.cornerRadius = 10
            self.backgroundColor = UIColor.white
            self.setTitle("전체 병원", for: .normal)
            self.setTitle("전체 병원", for: .highlighted)
            self.setTitle(NSLocalizedString("전체 병원", comment: ""), for: .normal)
            self.setTitle(NSLocalizedString("전체 병원", comment: ""), for: .highlighted)
            self.setTitleColor(UIColor.darkGray, for: .normal)
            self.setTitleColor(UIColor.darkGray, for: .highlighted)
            textWidth = self.intrinsicContentSize.width
            width = textWidth + 24
            widthConstraints.constant = width
        }) { (_) in
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.setTitle("ALL", for: .normal)
                self.setTitle("ALL", for: .highlighted)
                textWidth = self.intrinsicContentSize.width
                width = textWidth + 24
                widthConstraints.constant = width
            })
        }
    }
}

//func addTag(belowButtonName: UIButton)
//{
//    let tagImageView = UIImageView(image: #imageLiteral(resourceName: "Tag_Free").withRenderingMode(.alwaysOriginal))
//    let width = belowButtonName.intrinsicContentSize.width
//    let height = belowButtonName.intrinsicContentSize.height
//    tagImageView.frame = CGRect(x: 0, y: 0, width: height, height: height)
//    tagImageView.contentMode = .scaleAspectFit
//}
