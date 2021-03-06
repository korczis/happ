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
    var history: RingArray<CLLocation> = RingArray(maxCount: 25)
    var isRecording = false
    var updateInterval: Double = 5
    var processedCount: Int = 0
}
