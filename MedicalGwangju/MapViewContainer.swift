import UIKit
import GoogleMaps

struct MyLoc {
    var latitude = 35.178119340403 //gps시 default
    var longitude = 126.907986669375
}

class MapViewContainer: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var myLocation = MyLoc()
    let locationManager = gpsAuthorization()
    let geocoder = GMSGeocoder()
    var checkInit: Bool = true
    var markerClickMove: Bool = false //중심을 이동하는건지 마커클릭으로 이동하는건지 정함.
    var allHospitalData: hospitalData? = nil
    var forignHospitalData = MedicalParser()
    var myhospitalData: Array<Hospital>? = nil
    var myhospitalMarkerData: Array<GMSMarker>? = Array<GMSMarker>()
    var clickMarker: GMSMarker? = nil
    var mylocality: String = "" //현재 내가 속한 구
    var mybeforeLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var clicklocality: String = "" //클릭한 지역
    var beforelocality: String = "" //이전 지역
    var displaylocality: String = "" //보여줄 지역
    var mydutyDIV: String = "N" //내가 선택한 병원의 코드 (defalut = 치과?)
    var checkRealTime: Bool = false
    var alert: UIAlertController? = nil
    
    var reloadMeter = 500.0 //정보를 새롭게 받아올 Meter (줌에 따라 다르게)
    var closeMeter = 100.0  //가까운 병원의 거리 기반으로.. (줌에 따라 다르게)
    
    var superView: MapViewController? //컨테이너 뷰의 상위 뷰 컨트롤러
    var checkGPS = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //위치의 정확도를 표시하는 옵션 Best가 가장 배터리 소모량이 많다.
        locationManager.locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        // 사용할때만 위치정보를 사용한다는 팝업이 발생
        locationManager.locManager.requestWhenInUseAuthorization()
        
        // 항상 위치정보를 사용한다는 판업이 발생
        //locationManager.requestAlwaysAuthorization()
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.forignHospitalData.get_hospitalData()
        self.allHospitalData = hospitalData(forignHospitalData: forignHospitalData)
        self.checkGPS = locationManager.checkAuthorization()
        
        if(checkGPS){
            
            if let myloc = locationManager.getMyLoaction() {
                // 처음 내위치 설정
                myLocation.latitude = myloc.coordinate.latitude
                myLocation.longitude = myloc.coordinate.longitude
            }else{
                checkGPS = false
            }
        }else{
            
            
        }
        
        mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 13.8)
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.rotateGestures = false
        
        self.mapView.delegate = self
        
        self.view = mapView
        }
    
    //실시간 진료 체크
    func changeRealTime(realTime: Bool) -> Void {
        
        checkRealTime = realTime
        
        guard let allhospitaldata = allHospitalData else {
            return
        }
        
        self.myhospitalData = nil
        self.myhospitalData = allhospitaldata.get_close_hospitalData(latitude: mybeforeLocation.coordinate.latitude, longitude: mybeforeLocation.coordinate.longitude, DIV: mydutyDIV, realTime: checkRealTime,loc: displaylocality)
        self.superView?.change_h_tableView()
        self.displayMarker()
    }
    
    //병원코드를 바꾸는 팝업창에서 원하는 병원을 선택했을 시
    func changeDIV(DIVcode: String) -> Void {
        superView?.close_h_popup()
        superView?.close_h_Tag_popup()
        
        mydutyDIV = DIVcode
        
        guard let allhospitaldata = allHospitalData else {
            return
        }
        
        self.myhospitalData = nil
        self.myhospitalData = allhospitaldata.get_close_hospitalData(latitude: mybeforeLocation.coordinate.latitude, longitude: mybeforeLocation.coordinate.longitude, DIV: mydutyDIV, realTime: checkRealTime,loc: displaylocality)
        self.superView?.change_h_tableView()
        self.displayMarker()
    }
    
    //병원 클릭시 알림창 뜬다.
    func hospitalAlert(hospitalItem: Array<Hospital>) -> Void{
        // 콘텐츠 뷰 영역에 들어갈 뷰 컨트롤러 생성
        alert = nil
        let contentVC = CloseHospitalListController(item: hospitalItem)
        
        contentVC.delegate = self
        
        //경고창 객체를 생성하고 OK 및 Cancel버튼 생성
        alert = UIAlertController(title: "병원 선택", message:nil, preferredStyle: .alert)
        
        //컨트롤 뷰 컨트롤러를 알림창에 등록한다.
        alert!.setValue(contentVC, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "취소", style: .default)
        alert!.addAction(okAction)
        
        self.present(alert!, animated: false)
        
        let subview = (alert!.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        //subview.layer.cornerRadius = 1. 각지게 할까?
        subview.backgroundColor = UIColor(red: (255.0/255.0), green: (255.0/255.0), blue: (255.0/255.0), alpha: 1.0)
    }
    
    //병원 알림창 항목에서 병원클릭시 나타나는 이벤트
    func clickHospitalList(item: Hospital) -> Void{
        
        alert?.dismiss(animated: true, completion: nil)
        
        if item.h_pid == "FOR" {
            // 유학생 무료 진료 병원
            superView?.close_h_popup()
            superView?.close_h_Tag_popup()
            superView?.show_h_Tag_popup(item: item, latitude: myLocation.latitude , longitude: myLocation.longitude, gpsCheck: checkGPS)
        } else{
            superView?.close_h_popup()
            superView?.close_h_Tag_popup()
            superView?.show_h_popup(item: item, latitude: myLocation.latitude , longitude: myLocation.longitude, gpsCheck: checkGPS)
        }
//        print("근접한 병원이 없네요")
        changeMarker(changeData: item )
    }
    
    
    //맵 터치시 팝업 표시하지 않는다.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if(clickMarker != nil){
            BackMarker()
        }
        
        superView?.close_h_popup()
        superView?.close_h_Tag_popup()
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        
        checkGPS = locationManager.checkAuthorization()
        if(checkGPS == false) {
            let message = "위치정보를 이용할 수 없습니다."
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            
            // duration in seconds
            let duration: Double = 0.5
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
        
//        print("내위치 버튼을 두드릴 때")
        markerClickMove = false
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let baseLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        var closehospital_group = [Hospital]() //내가 누른 지점에서 근접한 병원들의 정보를 찾는다. (5m이내라고 가정)
        let userData = marker.userData as! Hospital
        
        markerClickMove = true
        
        guard let marker_data = myhospitalData else {
//            print("비교 할 마커가 없습니다.")
            
            return false
        }
        
        //이전에 클릭했던 마커 초기화
        if(clickMarker != nil){
            BackMarker()
        }
        
        
        for closeHospital in marker_data{
            
            let closeLocation = CLLocation(latitude: closeHospital.h_latitude,longitude: closeHospital.h_longitude)
            let distance_temp: CLLocationDistance = closeLocation.distance(from: baseLocation)
            
            if(distance_temp <= closeMeter ){
//                print("가까운병원: \(closeHospital.h_name), 거리: \(distance_temp)")
                closehospital_group.append(closeHospital)
            }
        }
        
        
        
        if(closehospital_group.count <= 1){
            // 함수 호출
            
            if userData.h_pid == "FOR" {
                superView?.close_h_popup()
                superView?.close_h_Tag_popup()
                superView?.show_h_Tag_popup(item: userData, latitude: myLocation.latitude , longitude: myLocation.longitude, gpsCheck: checkGPS)
            } else
            {
                superView?.close_h_popup()
                superView?.close_h_Tag_popup()
                superView?.show_h_popup(item: userData, latitude: myLocation.latitude , longitude: myLocation.longitude, gpsCheck: checkGPS)
            }
//            print("근접한 병원이 없네요")
            changeMarker(changeData: marker.userData as! Hospital)
            
        }else{
            //알림창 띄우기
            hospitalAlert(hospitalItem: closehospital_group)
        }
        
        return false
    }
    
    //마커모양 변경
    func changeMarker(changeData: Hospital) {
        
        let image2: UIImage?
        
        if(changeData.h_pid == "FOR"){
         
             image2 = UIImage(named: "Marker_free_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
        }
        else{
            if (changeData.forignHospitalCheck){
            // 외국인 유치 의료기관
                image2 = UIImage(named: "Marker_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
            }else{
            // 일반 병원
                image2 = UIImage(named: "Marker_other_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
            }
        }
        
        let markerView = UIImageView(image: image2)
        var cnt = 0
        
        guard let displayHospitalsMarker = self.myhospitalMarkerData else {
            return
        }
        
        for marker in displayHospitalsMarker {
            
            let userData = marker.userData as! Hospital
            
            if(userData.h_addr == changeData.h_addr && userData.h_name == changeData.h_name){
                self.myhospitalMarkerData?[cnt].map = nil
                self.myhospitalMarkerData?.remove(at: cnt)
            }
            
            cnt = cnt + 1
        }
        
        let hospital_marker_item = GMSMarker()
        let hospitalLocation = CLLocationCoordinate2D(latitude: changeData.h_latitude, longitude: changeData.h_longitude)
        hospital_marker_item.position = hospitalLocation
        hospital_marker_item.userData = changeData
        hospital_marker_item.iconView = markerView
        
        //맵뷰 중심점변경
        let camera = GMSCameraPosition.camera(withLatitude: changeData.h_latitude, longitude: changeData.h_longitude, zoom: mapView.camera.zoom)
        mapView.camera = camera
        
        self.myhospitalMarkerData?.append(hospital_marker_item)
        hospital_marker_item.map = self.mapView
        clickMarker = hospital_marker_item
        
    }
    
    
    //마커 모양 원래대로 되돌리기
    func BackMarker() -> Void {
        
        var cnt = 0
        
        guard let clickmarker = self.clickMarker else {
            return
        }
        
        let changeData = clickmarker.userData as! Hospital
        
        guard let displayHospitalsMarker = self.myhospitalMarkerData else {
            return
        }
        
        for marker in displayHospitalsMarker {
            
            let userData = marker.userData as! Hospital
            
            if(userData.h_addr == changeData.h_addr && userData.h_name == changeData.h_name){
                self.myhospitalMarkerData?[cnt].map = nil
                self.myhospitalMarkerData?.remove(at: cnt)
            }
            
            cnt = cnt + 1
        }
        
        let hospital_marker_item = GMSMarker()
        let hospitalLocation = CLLocationCoordinate2D(latitude: changeData.h_latitude, longitude: changeData.h_longitude)
        hospital_marker_item.position = hospitalLocation
        hospital_marker_item.userData = changeData
        
        if(changeData.h_pid == "FOR"){
            hospital_marker_item.icon = UIImage(named: "Marker_free_Idle.png")?.scaleImage(toSize: CGSize(width: 10, height: 10))
        }
        else{
            if(changeData.forignHospitalCheck){
                hospital_marker_item.icon = UIImage(named: "Marker_Idle.png")?.scaleImage(toSize: CGSize(width: 10, height: 10))}
            else{
                hospital_marker_item.icon = UIImage(named: "Marker_other_Idle.png")?.scaleImage(toSize: CGSize(width: 10, height: 10))
            }
        }
        
        self.myhospitalMarkerData?.append(hospital_marker_item)
        hospital_marker_item.map = self.mapView
        
        self.clickMarker = nil
    }
    
    
    //맵이 이동을 끝낸 후 호출 나는 이걸 사용할것이다.
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //중심점 위도 경도 구하기. position.target.latitude position.target.longitude
        
//        print("이동 \(position.target.latitude)")
        let zoom = mapView.camera.zoom
//        print("줌레벨 변경: \(zoom)")
        
        if(zoom >= 16.6){
            self.closeMeter = -1
        }
        else  if(zoom < 16.6 && zoom > 13.8){
            self.closeMeter = Double(1400/zoom)
        }else {
            self.closeMeter = 100.0
        }
        
        let currentLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
        
        if(!checkInit){
            if(currentLocation.distance(from: mybeforeLocation) < reloadMeter){
                
                markerClickMove = true
            }
        }
        
        let beforeLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
        mybeforeLocation = beforeLocation
        
        if(!markerClickMove){
            //지오코딩으로 주소 구하기
            
            
            geocoder.reverseGeocodeCoordinate(position.target) { (response, error) in
                guard error == nil else {
                    self.markerClickMove = false
                    return
                }
                
                if let result = response?.firstResult() {
                    
                    self.myhospitalData = nil
//                    print(result.locality!)
                    
                    //각각의 구(북구,남구,서구,광산구,동구) 로컬화
                    self.clicklocality =  NSLocalizedString(result.locality!, comment: "")
                    
                    //처음 병원정보 얻어오기
                    if(self.checkInit){
                        self.mylocality = NSLocalizedString(result.locality!, comment: "")
                        self.beforelocality = self.mylocality
                        self.displaylocality = self.mylocality
                        self.checkInit = false
                    }
                        
                        //지도에서 구 변경시
                    else if(self.clicklocality != self.beforelocality){
                        
//                        print("구가 변경되었습니다. 현위치: \(self.mylocality) 전 위치: \(self.beforelocality) 클릭위치: \(self.clicklocality)")
                        //인스턴스 초기화
                        self.myhospitalData = nil
                        self.myhospitalMarkerData = nil
                        self.displaylocality = self.clicklocality
                        mapView.clear()
                        
                        //각각의 구 데이터 재 생성
                        self.myhospitalMarkerData = Array<GMSMarker>()
                        
                    }
                    
                    guard let allhospitaldata = self.allHospitalData else {return}
                    
                    self.myhospitalData = allhospitaldata.get_close_hospitalData(latitude: position.target.latitude, longitude: position.target.longitude,DIV: self.mydutyDIV,realTime: self.checkRealTime, loc: self.displaylocality)
                    self.superView?.change_h_tableView()
                    self.beforelocality  = NSLocalizedString(result.locality!, comment: "")
                    
                    self.displayMarker()
                    
                    
                }else{
//                    print("정보를 불러올 수 없습니다.")
                }
            }
        }
        
        markerClickMove = false
    }
    
    //병원을 마커에 표시
    func displayMarker() -> Void {
        
        var temp_hospital_markerData = Array<GMSMarker>()
        
        guard let displayHospitals = self.myhospitalData else {
//            print("나타낼 병원이 없습니다.")
            self.markerClickMove = false
            return
        }
        
        guard let hospital_marker_data = self.myhospitalMarkerData else {return}
        
        for hospital_item in displayHospitals{
            
            var check: Bool = true
            for marker_item in hospital_marker_data {
                
                let userData = marker_item.userData as! Hospital
                
                if(hospital_item.h_name == userData.h_name){
                    check = false
                    break
                }
            }
            
            //새롭게 추가되는 병원을 찾는다.
            if(check){
                let hospital_marker_item = GMSMarker()
                let hospitalLocation = CLLocationCoordinate2D(latitude: hospital_item.h_latitude, longitude: hospital_item.h_longitude)
                hospital_marker_item.position = hospitalLocation
                hospital_marker_item.userData = hospital_item
                
                if(hospital_item.h_pid == "FOR"){
                      hospital_marker_item.icon = UIImage(named: "Marker_free_Idle.png")?.scaleImage(toSize: CGSize(width: 10, height: 10))
                }
                else{
                    if(hospital_item.forignHospitalCheck){
                        hospital_marker_item.icon = UIImage(named: "Marker_Idle.png")?.scaleImage(toSize: CGSize(width: 10, height: 10))}
                    else{
                        hospital_marker_item.icon = UIImage(named: "Marker_other_Idle.png")?.scaleImage(toSize: CGSize(width:       10, height: 10))
                    }
                }
                temp_hospital_markerData.append(hospital_marker_item)
            }
        }
        
        self.myhospitalMarkerData = self.myhospitalMarkerData! + temp_hospital_markerData
        
        var cnt = 0
        
        for hospitalmarkeritem in self.myhospitalMarkerData!{
            
            var deleteCheck: Bool = true
            let hospital = hospitalmarkeritem.userData as! Hospital
            
            for hospital_item in displayHospitals{
                
                if(hospital_item.h_name == hospital.h_name){
                    
                    deleteCheck = false
                }
            }
            
            if(deleteCheck){
                
                self.myhospitalMarkerData?[cnt].map = nil
                self.myhospitalMarkerData?.remove(at: cnt)
                cnt = cnt - 1
            }
            
            cnt = cnt + 1
        }
        
//        print(self.myhospitalMarkerData?.count)
        guard let displayMarker = self.myhospitalMarkerData else{
            self.myhospitalMarkerData = Array<GMSMarker>()
            return
        }
        
        for hospitalmarkeritem in displayMarker{
            let hospital = hospitalmarkeritem.userData as! Hospital
            hospitalmarkeritem.map = mapView
        }
    }
    
}

extension UIImage {
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(self.cgImage!, in: newRect)
            let newImage = UIImage(cgImage: context.makeImage()!)
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}
