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
    
    static func shouldUpdateLocation(oldLocation: CLLocation, newLocation: CLLocation) -> Bool{
        let oldCoordinate = oldLocation.coordinate
        let newCoordinate = newLocation.coordinate
        let sameCoordinates =
            oldCoordinate.latitude == newCoordinate.latitude &&
            oldCoordinate.longitude == newCoordinate.longitude
        
        let updateDelta = newLocation.timestamp.timeIntervalSince(oldLocation.timestamp)
        
        guard updateDelta >= 10 else {
            return false
        }
        print("addLocation() - updateDelta: \(updateDelta)")
        
        guard !sameCoordinates else {
            print("Coordinates are equal!")
            print("Last: \(oldLocation)")
            print("New: \(newLocation)")
            
            return false
        }
        
        return true;
    }

}
