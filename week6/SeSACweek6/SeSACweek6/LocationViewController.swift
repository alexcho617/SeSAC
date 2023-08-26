//
//  LocationViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import CoreLocation //1  import
import MapKit
import SnapKit

class LocationViewController: UIViewController {
    
    //2 manager class
    lazy var locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    let gelatoButton = UIButton()
    let pharmaButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //3 delegate & info.plist
        locationManager.delegate = self
        
        mapView.delegate = self
        view.addSubview(mapView)
        view.addSubview(gelatoButton)
        view.addSubview(pharmaButton)
        gelatoButton.backgroundColor = .red
        pharmaButton.backgroundColor = .blue
        gelatoButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        pharmaButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(50)
        }
        
        gelatoButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.size.equalTo(40)
        }
        pharmaButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.size.equalTo(40)
        }
        
        //udine
        let center = CLLocationCoordinate2D(latitude: 45.437590, longitude: 12.329850)
        setRegionAndAnnotation(center: center)

    }
    @objc func cafeButtonClicked(){
        setAnnotation(type: 1)//버튼 누르면 타입1 : 1개의 핀만 보여줌
        print(#function)
    }
    
    //0: 전부, 1:필터
    func setAnnotation(type: Int){
//        45.437262, 12.330487//gelato
//        45.437084, 12.330136 //pharmacy
        let gelatoAnno = MKPointAnnotation()
        let pharmaAnno = MKPointAnnotation()
        
        gelatoAnno.coordinate = CLLocationCoordinate2D(latitude: 45.437262, longitude: 12.330487)
        pharmaAnno.coordinate = CLLocationCoordinate2D(latitude: 45.437084, longitude: 12.330136)
        
        if type == 0{
            mapView.addAnnotations([gelatoAnno,pharmaAnno])
        }else if type == 1{
///            mapView.removeAnnotation(gelatoAnno) 이게 안되는 이유: gelatoAnno는 function local variable임 Array 안에있는 annotation은 다른 객체임
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(pharmaAnno)
        }
        
    }
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        //핀
//        let customAnnotation = MKAnnotationView()//custom 영역
        let annotation = MKPointAnnotation()
        annotation.title = "여기가 우디여"
        annotation.coordinate = center
        
        //annotation filter: 없애고 다시 세팅 해줘야함
        setAnnotation(type: 0)//처음엔 전부 다 있음
        mapView.addAnnotation(annotation)
    }
    
    //위치 실패시 설정으로 이동
    
    func showLocationSettingAlert(){
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치가 안됨. 설정에서 허용해줘", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert,animated: true)
    }

    
    func checkDeviceLocationAuthorization(){
        print(#function)
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                let auth: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    auth = self.locationManager.authorizationStatus
                } else{
                    auth = CLLocationManager.authorizationStatus()
                }
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: auth)
                }
            }else{
                print("no")
            }
        }
       
    }
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus){
        print(#function, terminator: "")
        switch status {
        case .notDetermined:
            print("not determined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
//            DispatchQueue.main.async {
//                self.showLocationSettingAlert()
//            }
            
        case .authorizedAlways:
            print("authorize always")
        case .authorizedWhenInUse: //한번만 허용 눌렀는데 여기로 옴
            print("authorize when in use")
            //6 위치 알려줘 이제
            locationManager.startUpdatingLocation()
            
        case .authorized: //이건 어떤 상황이지??
            print("authorized")
        
        @unknown default: //이건 뭐지 ㅋㅋㅋ 만일의 상황에 대비하는건가
            print("fatal error")
        }
    }
}
//4 protocol
extension LocationViewController: CLLocationManagerDelegate{
    //5 success
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(#function, locations)
        if let coordinates = locations.last?.coordinate {
            print(coordinates)
            //날씨 호출할수도 있음
            setRegionAndAnnotation(center: coordinates)
        }
        locationManager.stopUpdatingLocation()

    }
    //5 fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    
    
    //5 authorization changed:
    //거부했다가 설정에서 변경 | notDetermined상태에서 허용 | 허용했지만 도중에 설정에서 거부하고 앱으로 돌아옴
    //ios 14+
    
    //viewDidLoad에서 하지 않아도 이 함수가 자동으로 처음에 실행되는것처럼 보이지만 안됨. VC를 독립적으로 띄우면 실행되지만 NavigationController나 TabBar에 있으면 안됨 -> 사실 manager instsance가 생성되는 시점에 따라 달랐었다.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print(#function, manager.authorizationStatus.rawValue)
        
        checkDeviceLocationAuthorization()
    }
//     ios 14-
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(#function)
//    }
}

extension LocationViewController: MKMapViewDelegate{
    //주요 기능들
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//    }
    
    
}
