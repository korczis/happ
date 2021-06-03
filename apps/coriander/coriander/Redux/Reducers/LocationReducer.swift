//
//  LocationReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import CoreData
import MapKit
import ReSwift

func locationReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    // -----
    
    var stateLocation: LocationState {
        return state.location
    }
    
    var lastLocation: CLLocation {
        stateLocation.lastLocation
    }
    
    var context: NSManagedObjectContext {
        return ((UIApplication.shared.delegate as? AppDelegate)?.dataStack.context)!
    }
    
    let locationAdd = { (action: LocationAddAction) -> AppState in
        let updateDelta = action.location.timestamp.timeIntervalSince(state.location.lastLocation.timestamp)
        if updateDelta < state.location.updateInterval {
            return state
        }
        
        state.location.lastLocation = action.location
        state.location.history.append(action.location)
        state.location.processedCount += 1
        
        // TODO: Use bulk mode
        DispatchQueue.main.async {
            let item = Location(context: context)
            item.timestamp = action.location.timestamp;
            item.longitude = action.location.coordinate.longitude.magnitude;
            item.latitude  = action.location.coordinate.latitude.magnitude;
            item.altitude  = action.location.altitude
            if let floor = action.location.floor {
                item.floor = Int64(floor.level)
            }
            item.course = action.location.course
            item.speed = action.location.speed
            item.horizontalAccuracy = action.location.horizontalAccuracy
            item.verticalAccuracy = action.location.verticalAccuracy
            item.speedAccuracy = action.location.speedAccuracy
            item.courseAccuracy = action.location.courseAccuracy
            
            state.journey.active?.addToLocations(item)
            
            do {
                try context.save()
                print("locationReducer() - Location was saved.")
                
            } catch let error {
                print("locationReducer() - Unable to save location - \(error).")
            }
        }
        
        return state
    }
    
    // -----
    
    let locationRecordingStart = { (action: LocationRecordingStartAction) -> AppState in
        state.location.isRecording = true
        return state
    }
    
    // -----
    
    let locationRecordingStop = { (action: LocationRecordingStopAction) -> AppState in
        state.location.isRecording = false
        return state
    }
    
    // -----
    
    let locationRecordingSet = { (action: LocationRecordingSetAction) -> AppState in
        state.location.isRecording = action.isRecording
        return state
    }
    
    // -----
    
    let locationRecordingToggle = { (action: LocationRecordingToggleAction) -> AppState in
        state.location.isRecording = !state.location.isRecording
        return state
    }
    
    // -----
    
    switch action {
    case let action as LocationAddAction:
        return locationAdd(action)
    
    case let action as LocationRecordingStartAction:
        return locationRecordingStart(action)
        
    case let action as LocationRecordingStopAction:
        return locationRecordingStop(action)
        
    case let action as LocationRecordingSetAction:
        return locationRecordingSet(action)
        
    case let action as LocationRecordingToggleAction:
        return locationRecordingToggle(action)
        
    default:
        return state
    }
}
