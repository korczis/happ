//
//  Coordinator.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit

class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    private var parent: MapView
                    
    init(_ parent: MapView) {
        self.parent = parent
        
        super.init()
        
        setupManager()
    }
    
    func setupManager() {
        let locationManager = parent.state.current.map.locationManager;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self;
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        let locationManager = parent.state.current.map.locationManager;
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        } else if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            let location = locations.first;
            print("location: \(String(describing: location))")
        }

    }
}
