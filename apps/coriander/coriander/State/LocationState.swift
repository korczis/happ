//
//  LocationState.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit

// MARK: LocationState

struct LocationState {
    var lastKnownLocation: CLLocation = CLLocation()
    // var locationManager: CLLocationManager = CLLocationManager()
    var locationHistory: [CLLocation] = []
}
