//
//  LocationViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

enum SelectedTheater: Int{
    case cgv
    case megabox
    case lotte
    case all
}
class LocationViewController: UIViewController {
    var selectedTheater = SelectedTheater.all //지금은 안쓰고 있음
    lazy var locationManager = CLLocationManager()
    let mapView = MKMapView()
    let base = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) //청취사
    var currentLocation: CLLocationCoordinate2D?
    let allTheaters = TheaterList().mapAnnotations
    let locationButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        return button
    }()
    let movieButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "popcorn"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.delegate = self
        mapView.delegate = self
        view.addSubview(mapView)
        view.addSubview(locationButton)
        view.addSubview(movieButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.size.equalTo(40)
        }
        
        movieButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.trailing.equalTo(locationButton.snp.leading).offset(-20)
            make.size.equalTo(40)
        }
        
        
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonPressed), for: .touchUpInside)

        setRegionandAnnotation(at: base, as: "청년취업사관학교")
        addMovieAnnotations(from: allTheaters)
    }
    
    func addMovieAnnotations(from theaters: [Theater]){
        for theater in theaters {
            let anno = MKPointAnnotation()
            anno.title = theater.location
            anno.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            mapView.addAnnotation(anno)
        }
    }
    
    
    
    @objc func locationButtonPressed(){
        if let currentLocation{
            focusTo(currentLocation, as: "현재 위치")
        }else{
            showRequestLocationServiceAlert()
        }
    }
    
    @objc func movieButtonPressed(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cgvAction = UIAlertAction(title: "CGV", style: .default) { _ in
            self.filterTheater(selected: SelectedTheater.cgv)
        }
        let megaAction = UIAlertAction(title: "메가박스", style: .default){ _ in
            self.filterTheater(selected: SelectedTheater.megabox)
        }
        let lotteAction = UIAlertAction(title: "롯데시네마", style: .default){ _ in
            self.filterTheater(selected: SelectedTheater.lotte)
        }
        let allAction = UIAlertAction(title: "전체보기", style: .default){ _ in
            self.filterTheater(selected: SelectedTheater.all)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cgvAction)
        alert.addAction(megaAction)
        alert.addAction(lotteAction)
        alert.addAction(allAction)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
    
    func filterTheater(selected: SelectedTheater){
        //줌 인아웃 기능이 있으면 좋겠다
        switch selected {
        case .cgv:
            mapView.removeAnnotations(mapView.annotations)
            let filteredTheaters = allTheaters.filter { (theater) -> Bool in
                return theater.type == "CGV"
            }
            addMovieAnnotations(from: filteredTheaters)
        
        case .megabox:
            mapView.removeAnnotations(mapView.annotations)
            let filteredTheaters = allTheaters.filter { (theater) -> Bool in
                return theater.type == "메가박스"
            }
            addMovieAnnotations(from: filteredTheaters)
        
        case .lotte:
            mapView.removeAnnotations(mapView.annotations)
            let filteredTheaters = allTheaters.filter { (theater) -> Bool in
                return theater.type == "롯데시네마"
            }
            addMovieAnnotations(from: filteredTheaters)
        
        case .all:
            mapView.removeAnnotations(mapView.annotations)
            addMovieAnnotations(from: allTheaters)
            addCurrentLocationAnnotation()
            
        }
    }
    
    func checkDeviceLocationAuth(){
        print(#function)
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                let authStatus: CLAuthorizationStatus = self.locationManager.authorizationStatus
                DispatchQueue.main.async { [self] in
                    switch authStatus {
                    case .notDetermined:
                        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        locationManager.requestWhenInUseAuthorization()
                    case .restricted: print("restricted")
                    case .denied: showRequestLocationServiceAlert()
                    case .authorizedAlways: print("authorizedAlways")
                    case .authorizedWhenInUse: locationManager.startUpdatingLocation()
                    case .authorized: print("authorized")
                    @unknown default: fatalError("Unknown Default")
                    }
                }
            }
        }
    }
    
    func setRegionandAnnotation(at center: CLLocationCoordinate2D, as title: String){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
        let baseAnnotation = MKPointAnnotation()
        baseAnnotation.title = title
        baseAnnotation.coordinate = center
        mapView.addAnnotation(baseAnnotation)
    }
    
    func focusTo(_ center: CLLocationCoordinate2D, as title: String){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        let baseAnnotation = MKPointAnnotation()
        baseAnnotation.title = title
        baseAnnotation.coordinate = center
        mapView.addAnnotation(baseAnnotation)
    }
    
    func addCurrentLocationAnnotation(){
        if let currentLocation{
            let anno = MKPointAnnotation()
            anno.title = "현재 위치"
            anno.coordinate = currentLocation
            mapView.addAnnotation(anno)
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString){
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }


}

extension LocationViewController: CLLocationManagerDelegate{
    //locationManager insance 생성시 실행
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuth()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)

        if let coordinate = locations.last?.coordinate{
            self.currentLocation = coordinate
            setRegionandAnnotation(at: coordinate, as: "현재 위치")
            locationManager.stopUpdatingLocation()
        } else{
            print("Fail", #function)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
}

extension LocationViewController: MKMapViewDelegate{
    
}
