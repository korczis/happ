//
//  LocationCoordinator.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//
//
//import Foundation
//import MapKit
//
//class LocationCoordinator: NSObject, CLLocationManagerDelegate {
//    var state: ObservableState<AppState>
//    
//    init(_ state: ObservableState<AppState>) {
//        self.state = state
//        
//        super.init()
//        
//        setupManager()
//    }
//    
//    func setupManager() {
//        let locationManager = state.current.map.locationManager;
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.delegate = self;
//    }
//        
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//         print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        
//        let locationManager = state.current.map.locationManager;
//        if status == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            locationManager.requestLocation()
//        } else if status == .authorizedAlways {
//            locationManager.startUpdatingLocation()
//            locationManager.requestLocation()
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if locations.first != nil {
//            let location = locations.first;
//            print("location: \(String(describing: location))")
//        }
//    }
//}
