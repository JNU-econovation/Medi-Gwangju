import UIKit
import GoogleMaps

struct MyLoc {
    var latitude = 0.0
    var longitude = 0.0
}
class MapViewContainer: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    var marker = GMSMarker()
    var myLocation = MyLoc()
    let locationManager = CLLocationManager()
    let geocoder = GMSGeocoder()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //위치의 정확도를 표시하는 옵션 Best가 가장 배터리 소모량이 많다.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        // 사용할때만 위치정보를 사용한다는 팝업이 발생
        locationManager.requestWhenInUseAuthorization()
        
        // 항상 위치정보를 사용한다는 판업이 발생
        //locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //현재위치 가져오기
        
        let coor = locationManager.location?.coordinate
        
        if(coor != nil){
            myLocation.latitude = coor!.latitude
            myLocation.longitude = coor!.longitude
        }else{
            print("위치정보를 가져올 수 없습니다.")
        }
        
         print("내 위치 \(myLocation.latitude), \(myLocation.longitude)")
        
        mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 13.8)
        mapView.camera = camera
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        self.mapView.delegate = self
        self.view = mapView
        
        
    }
    
    //맵을 계속 움직일 때 호출
    /*func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
     print("이동2")
     }*/
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
    }
    
    //맵이 이동을 끝낸 후 호출 나는 이걸 사용할것이다.
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //중심점 위도 경도 구하기. position.target.latitude position.target.longitude
        
        print("이동 \(position.target.latitude)")
        
        //지오코딩으로 주소 구하기
        geocoder.reverseGeocodeCoordinate(position.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                marker.position = position.target
                marker.title = result.lines?[0]
               // marker.snippet = result.lines?[1]
                marker.map = mapView
            }
 
        }
    }
    
}


