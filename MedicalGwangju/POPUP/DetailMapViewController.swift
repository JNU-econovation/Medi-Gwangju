import UIKit
import GoogleMaps


class DetailMapViewController: UIViewController, GMSMapViewDelegate {
    
    var superView: DetailHospitalController?
    var mapView: GMSMapView!
    var displayHospital: Hospital? = nil
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        mapView = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 35.178119340403, longitude: 126.907986669375, zoom: 13.8)
        mapView.camera = camera
        mapView.settings.rotateGestures = false
        self.mapView.delegate = self
        self.view = mapView
    }
    
    func changeCamera() -> Void{
        
        guard let item = self.superView?.detailHospital else {return}
        
        let camera = GMSCameraPosition.camera(withLatitude: item.h_latitude, longitude: item.h_longitude, zoom: 15.2)
        self.mapView.camera = camera
        
        let hospital_marker_item = GMSMarker()
        let hospitalLocation = CLLocationCoordinate2D(latitude: item.h_latitude, longitude: item.h_longitude)
        hospital_marker_item.position = hospitalLocation
        
        var hospitalName: String?
        hospitalName = NSLocalizedString(item.h_name, comment: "")
        hospital_marker_item.title =  hospitalName
        
        if(item.h_pid == "FOR") {
            hospital_marker_item.icon = UIImage(named: "Marker_free_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
        } else if(item.forignHospitalCheck){
            hospital_marker_item.icon = UIImage(named: "Marker_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
        }else{
            hospital_marker_item.icon  = UIImage(named: "Marker_other_2.png")?.scaleImage(toSize: CGSize(width: 20, height: 20))
        }
       
        
        hospital_marker_item.map = self.mapView
        
        
        
    }
    
}
