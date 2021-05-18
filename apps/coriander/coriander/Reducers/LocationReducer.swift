//
//  LocationReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift
import MapKit

func locationReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    var stateLocation: LocationState {
        return state.location
    }
    
    var lastLocation: CLLocation {
        stateLocation.lastKnownLocation
    }

    let addLocation = { (action: AddLocationAction) -> AppState in
        
        let oldLocation = state.location.lastKnownLocation
        let newLocation = action.location
        
        let shouldUpdateLocation = AddLocationAction.shouldUpdateLocation(
            oldLocation: oldLocation,
            newLocation: newLocation
        )
        guard shouldUpdateLocation else {
            return state
        }
        
        state.location.lastKnownLocation = action.location
        state.location.locationHistory.append(action.location)
        
        return state
    }
    
    switch action {
    case let action as AddLocationAction:
        return addLocation(action)
        
    default:
        return state
    }
}
