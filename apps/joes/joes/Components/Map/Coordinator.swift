//
//  Coordinator.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit
import SwiftUI

class Coordinator:
    NSObject,
    MKMapViewDelegate,
    CLLocationManagerDelegate
{
    @State var state: ObservableState<AppState>
    
    init(_ state: ObservableState<AppState>) {
        self.state = state
        
        super.init()
        
        setupManager()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func setupManager() {
        // dump((self), name: "Coordinator - setupManager");
        
        let locationManager = state.current.location.locationManager;
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // dump((manager, error), name: "locationManager - didFailWithError");
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        dump((manager, status), name: "locationManager - didChangeAuthorization");
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startLocating();
        }
    }
    
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // dump((manager, locations), name: "locationManager - didUpdateLocations");
        
        if locations.first != nil {
            let location = locations.first!;
            print("\(location)")
            let _ = state.dispatch(SetLastKnownLocation(location: location))
        }
    }
    
    // MARK: MKMapViewDelegate
    
//    @available(iOS 4.0, *)
//    optional func mapViewWillStartLocatingUser(_ mapView: MKMapView)
//
//    @available(iOS 4.0, *)
//    optional func mapViewDidStopLocatingUser(_ mapView: MKMapView)
//
//    @available(iOS 4.0, *)
//    optional func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
//
//    @available(iOS 4.0, *)
//    optional func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error)
//
//    @available(iOS 5.0, *)
//    optional func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool)

//    @available(iOS 3.0, *)
//    optional func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool)
//
//    @available(iOS 3.0, *)
//    optional func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        setupMapView(mapView);
    }
    
    // MARK: Private implementation
    
    private func setupMapView(_ mapView: MKMapView) {
        // MARK: Map Global Settings
        // mapView.showsCompass = true
        // mapView.showsScale = true
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        
        // mapView.setUserTrackingMode(MKUserTrackingMode.none, animated: false) // WithHeading
        
        let scale = MKScaleView(mapView: mapView)
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.scaleVisibility = .visible // always visible
        mapView.addSubview(scale)

        // MARK: Compass
        let compassBtn = MKCompassButton(mapView: mapView)
        compassBtn.compassVisibility = .visible
        compassBtn.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(compassBtn)

        // MARK: Tracking Button
        let trackingBtn = MKUserTrackingButton(mapView: mapView)
        trackingBtn.translatesAutoresizingMaskIntoConstraints = false
        trackingBtn.layer.backgroundColor = UIColor.white.cgColor
        trackingBtn.layer.borderColor = UIColor.white.cgColor
        trackingBtn.layer.borderWidth = 1
        trackingBtn.layer.cornerRadius = 5
        trackingBtn.layer.zPosition = 10;
        mapView.addSubview(trackingBtn)
//
//        // MARK: Scale Button
//        // let scale = MKScaleView(mapView: mapView)
//        // scale.legendAlignment = .trailing
//        // scale.translatesAutoresizingMaskIntoConstraints = false
//        // mapView.addSubview(scale)
//
//        // Mark: Button Constrains
        NSLayoutConstraint.activate(
            [
                scale.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12),
                scale.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 12),
                scale.trailingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 120),
                
                compassBtn.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12),
                compassBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),

                trackingBtn.topAnchor.constraint(equalTo: compassBtn.bottomAnchor, constant: 12),
                trackingBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12),

                // scale.bottomAnchor.constraint(equalTo: trackingBtn.topAnchor, constant: -12),
                // scale.centerYAnchor.constraint(equalTo: trackingBtn.centerYAnchor)
            ]
        )

        startLocating()
    }
    
    private func startLocating() {
        let locationManager = state.current.location.locationManager;
        
        locationManager.stopUpdatingLocation();
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
}
