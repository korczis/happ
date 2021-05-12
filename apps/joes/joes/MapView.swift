//
//  MapView.swift
//  joes
//
//  Created by Tomas Korcak on 12.05.2021.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

struct MapView: UIViewRepresentable
{
    let map: MKMapView = MKMapView()    
    
    func makeUIView(context: Context) -> MKMapView {
            // Map
            map.delegate = context.coordinator
            map.showsCompass = false
            map.showsScale = true
            map.isRotateEnabled = true
        
            // Compass
            let compassBtn = MKCompassButton(mapView: map)
            map.addSubview(compassBtn)
        
            compassBtn.compassVisibility = .visible
            compassBtn.translatesAutoresizingMaskIntoConstraints = false
            compassBtn.topAnchor.constraint(equalTo: map.topAnchor, constant: 12).isActive = true
            compassBtn.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -12).isActive = true
            
        
            // Zoom controll
            let zoomControll = MKScaleView(mapView: map)
            map.addSubview(zoomControll)
        
            zoomControll.scaleVisibility = .visible
            zoomControll.translatesAutoresizingMaskIntoConstraints = false
            zoomControll.topAnchor.constraint(equalTo: map.topAnchor, constant: 12).isActive = true
            // zoomControll.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -12).isActive = true
            zoomControll.leftAnchor.constraint(equalTo: map.leftAnchor, constant: 12).isActive = true
        
            // Location
            // locationManager.delegate = self;
        
            // Return created map
            return map
        }

        func updateUIView(_ view: MKMapView, context: Context) {

        }

        func makeCoordinator() -> Coordinator {
            let coordinator = Coordinator(self)
            
            return coordinator
        }
    
        // -----
    
        private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print(locations)
        }
    
        // -----

        class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
            private var parent: MapView
            @State var location: CLLocationManager =  CLLocationManager()
            

            init(_ parent: MapView) {
                self.parent = parent
                // self.location = CLLocationManager()
                
                super.init()
                location.delegate = self;
                
                // location.desiredAccuracy = kCLLocationAccuracyBest
                location.requestAlwaysAuthorization()
                location.requestWhenInUseAuthorization()
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                 print("error:: \(error.localizedDescription)")
            }

            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                
                if status == .authorizedWhenInUse {
                    location.startUpdatingLocation()
                    location.requestLocation()
                } else if status == .authorizedAlways {
                    location.startUpdatingLocation()
                    location.requestLocation()
                }
            }
        
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if locations.first != nil {
                    let location = locations.first;
                    print("location: \(location)")
                }

            }
        }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
