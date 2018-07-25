//
//  gpsAuthorization.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 21..
//  Copyright © 2018년 sol. All rights reserved.
//

import Foundation
import CoreLocation

class gpsAuthorization {
    
    let locManager = CLLocationManager()
    
    func checkAuthorization() -> Bool {
        
        let status = CLLocationManager.authorizationStatus()
        print(status)
        
        if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
            
            return false
        }
        else if status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways {
            
            return true
            
        }
        
        return false
        
    }
    
    func  getMyLoaction() -> CLLocation? {
        
        guard let coor = locManager.location?.coordinate else{
            return nil
        }
        
        return CLLocation(latitude: coor.latitude , longitude: coor.longitude)
    }
}
