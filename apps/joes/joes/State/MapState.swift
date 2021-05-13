//
//  MapState.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit

// MARK: MapState

struct MapState {
    var locationManager: CLLocationManager = CLLocationManager()
    var center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 49.20713396, longitude: 16.60279239)
}
