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
    @ObservedObject var state: ObservableState<AppState>
    
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


        // Return created map
        return map
    }

    func updateUIView(_ view: MKMapView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // -----

    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    // -----

    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewRaw()
//    }
//}
