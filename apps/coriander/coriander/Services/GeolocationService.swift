//
//  GeolocationService.swift
//  coriander
//
//  Created by Tomas Korcak on 20.05.2021.
//

import CoreLocation
import Foundation
import SwiftUI

class GeolocationServiceEventHandler: NSObject, CLLocationManagerDelegate {
    @ObservedObject private var state: ObservableState<AppState>
    var locationManager: CLLocationManager
    
    init(state: ObservableState<AppState>, locationManager: CLLocationManager) {
        self.state = state
        self.locationManager = locationManager
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("GeolocationServiceEventHandler.didUpdateLocations() - locations: \(locations)")
        
        guard state.current.location.isRecording else {
                return
        }
        
        for location in locations {
            if (AddLocationAction.shouldUpdateLocation(
                oldLocation: state.current.location.lastLocation,
                newLocation: location,
                updateInterval: state.current.location.updateInterval
            )) {
                state.dispatch(AddLocationAction(location: location))
            }
        }
    }
    
}

class GeolocationService {
    @ObservedObject var state: ObservableState<AppState>
    
    private var locationManager: CLLocationManager
    private var eventHandler: GeolocationServiceEventHandler
    
    init(state: ObservableState<AppState>) {
        print("Initializing GeoLocation Service")
        
        self.state = state
        
        let locationManager = CLLocationManager();
        self.locationManager = locationManager
        
        let eventHandler = GeolocationServiceEventHandler(state: state, locationManager: locationManager)
        self.eventHandler = eventHandler
        
        locationManager.delegate = eventHandler
    }
}
