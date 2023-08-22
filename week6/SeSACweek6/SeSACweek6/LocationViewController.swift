//
//  LocationViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import CoreLocation //1  import
class LocationViewController: UIViewController {
    
    //2 manager class
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //3 delegate & info.plist
        locationManager.delegate = self
        checkDeviceLocationAuthorization()
    }
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus){
        print(#function)
        switch status {
        case .notDetermined:
            print("not determined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorize always")
        case .authorizedWhenInUse: //한번만 허용 눌렀는데 여기로 옴
            print("authorize when in use")
            //6 위치 알려줘 이제
            locationManager.startUpdatingLocation()
        case .authorized: //이건 뭐지
            print("authorized")
        @unknown default:
            print("fatal error")
        }
    }
    func checkDeviceLocationAuthorization(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                let auth: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    auth = self.locationManager.authorizationStatus
                } else{
                    auth = CLLocationManager.authorizationStatus()
                }
                self.checkCurrentLocationAuthorization(status: auth)
            }else{
                print("no")
            }
        }
       
    }
    
}
//4 protocol
extension LocationViewController: CLLocationManagerDelegate{
    //5 success
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
    }
    //5 fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    
    
    //5 authorization changed:
    //거부했다가 설정에서 변경 | notDetermined상태에서 허용 | 허용했지만 도중에 설정에서 거부하고 앱으로 돌아옴
    //ios 14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print(#function, manager.authorizationStatus.rawValue)
        
        checkDeviceLocationAuthorization()
    }
//     ios 14-
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
