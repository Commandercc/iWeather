//
//  WTPermissionManager.swift
//  iweather
//
//  Created by zhengxu on 2023/1/13.
//

import Foundation

final class WTPermissionManager {
    
    func checkLocationStatus() {
        let locationManager = CLLocationManager()
        if #available(iOS 14.0, *) {
            let status = locationManager.authorizationStatus
            self.requestLocationAuthor(status: status)
        } else {
            let status = CLLocationManager.authorizationStatus()
            self.requestLocationAuthor(status: status)
        }
    }
    
    private func requestLocationAuthor(status: CLAuthorizationStatus) {
        let locationManager = CLLocationManager()
        switch status {
        case .notDetermined:
            print("用户选择了notDetermined ")
            locationManager.requestWhenInUseAuthorization()

        case .restricted:
            print("用户选择了restricted")
        case .denied:
            print("用户选择了denied")
        case .authorizedAlways:
            print("用户选择了authorizedAlways")
        case .authorizedWhenInUse:
            print("用户选择了authorizedWhenInUse")
        case .authorized:
            print("用户选择了authorized")
        }
    }
}
