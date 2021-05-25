//
//  LocationReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import ReSwift
import MapKit

func locationReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    // -----
    
    var stateLocation: LocationState {
        return state.location
    }
    
    var lastLocation: CLLocation {
        stateLocation.lastLocation
    }
    
    let addLocation = { (action: AddLocationAction) -> AppState in
        let oldLocation = state.location.lastLocation
        let newLocation = action.location
        
        let shouldUpdateLocation = AddLocationAction.shouldUpdateLocation(
            oldLocation: oldLocation,
            newLocation: newLocation,
            updateInterval: state.location.updateInterval
        )
        guard shouldUpdateLocation else {
            return state
        }
        
        state.location.lastLocation = action.location
        state.location.history.append(action.location)
        state.location.processedCount += 1
        
        // TODO: Use bulk mode
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            let item = Location(context: context!)
            item.id = UUID()
            item.altitude  = action.location.altitude
            item.latitude  = action.location.coordinate.latitude.magnitude;
            item.longitude = action.location.coordinate.longitude.magnitude;
            item.timestamp = action.location.timestamp;
            
            do {
                try context?.save()
                print("locationReducer() - Location was saved.")
                
            } catch let error {
                print("locationReducer() - Unable to save location - \(error).")
            }
        }
        
        return state
    }
    
    // -----
    
    let toggleRecording = { (action: ToggleRecordingLocationAction) -> AppState in
        state.location.isRecording = !state.location.isRecording
        return state
    }
    
    // -----
    
    let setRecording = { (action: SetRecordingLocationAction) -> AppState in
        state.location.isRecording = action.isRecording
        return state
    }
        
    // -----
    
    switch action {
    case let action as AddLocationAction:
        return addLocation(action)
        
    case let action as SetRecordingLocationAction:
        return setRecording(action)
     
    case let action as ToggleRecordingLocationAction:
        return toggleRecording(action)
        
    default:
        return state
    }
}
