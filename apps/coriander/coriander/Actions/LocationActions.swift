//
//  LocationActions.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit
import ReSwift

struct AddLocationAction: Action {
    var location: CLLocation
    
    static func shouldUpdateLocation(oldLocation: CLLocation, newLocation: CLLocation, updateInterval: Double) -> Bool {
        guard (oldLocation.coordinate.latitude != 0 && oldLocation.coordinate.longitude != 0) else {
            return true
        }
        
        let oldCoordinate = oldLocation.coordinate
        let newCoordinate = newLocation.coordinate
        let sameCoordinates =
            oldCoordinate.latitude == newCoordinate.latitude &&
            oldCoordinate.longitude == newCoordinate.longitude
        
        let updateDelta = newLocation.timestamp.timeIntervalSince(oldLocation.timestamp)
        
        guard updateDelta >= updateInterval else {
            return false
        }
        
        // print("AddLocationAction.shouldUpdateLocation() - updateDelta: \(updateDelta)")
        
        guard !sameCoordinates else {
            // print("Coordinates are equal!")
            // print("Last: \(oldLocation)")
            // print("New: \(newLocation)")
            
            return false
        }
        
        return true;
    }

}

struct ToggleRecordingLocationAction: Action {
}

struct SetRecordingLocationAction: Action {
    var isRecording: Bool
}
