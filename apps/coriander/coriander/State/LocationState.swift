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
    var lastLocation: CLLocation = CLLocation()
    var history: [CLLocation] = []
    var isRecording = false
    var updateInterval: Double = 5
}
