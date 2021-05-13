//
//  Coordinator.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit

class Coordinator:
    NSObject,
    MKMapViewDelegate,
    CLLocationManagerDelegate
{
    var state: ObservableState<AppState>
    
    init(_ state: ObservableState<AppState>) {
        self.state = state
        
        super.init()
        
        setupManager()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func setupManager() {
        let locationManager = state.current.map.locationManager;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self;
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error, name: "locationManager - didFailWithError");
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        dump(status, name: "mapView - didChangeAuthorization");
        
        let locationManager = state.current.map.locationManager;
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        } else if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        dump(locations, name: "mapView - didUpdateLocations");
        
//        if locations.first != nil {
//            let location = locations.first!;
//
//            let _ = state.dispatch(SetLastLocation(location: location))
//
//            // TODO: Only when in tracking mode
//             let _ = state.dispatch(SetMapCenter(location: location.coordinate))
//        }
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        dump(mapView, name: "mapView - regionDidChage");
        
//        let mapCenter = mapView.center;
//
//        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(
//            latitude: CLLocationDegrees(mapCenter.x),
//            longitude: CLLocationDegrees(mapCenter.y)
//        )
//
//        let _ = state.dispatch(SetMapCenter(location: location))
    }
}
