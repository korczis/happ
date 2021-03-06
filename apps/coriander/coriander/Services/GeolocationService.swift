//
//  GeolocationService.swift
//  coriander
//
//  Created by Tomas Korcak on 20.05.2021.
//

import BackgroundTasks
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
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("GeolocationServiceEventHandler.didUpdateLocations() - locations: \(locations)")
        
        guard state.current.location.isRecording else {
                return
        }
        
        for location in locations {
            state.dispatch(LocationAddAction(location: location))
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
        
//        BGTaskScheduler.shared.register(
//          forTaskWithIdentifier: "com.korczis.coriander.requestLocationUpdateTask", using: nil) { (task) in
//            self.handleRequestLocationUpdateTask(task: task as! BGAppRefreshTask)
//        }
//
//        let requestLocationUpdateTask = BGAppRefreshTaskRequest(identifier: "com.korczis.coriander.requestLocationUpdateTask")
//        requestLocationUpdateTask.earliestBeginDate = Date(timeIntervalSinceNow: 10)
//
//        do {
//          try BGTaskScheduler.shared.submit(requestLocationUpdateTask)
//        } catch {
//          print("Unable to submit task: \(error.localizedDescription)")
//        }
    }
    
//    private func handleRequestLocationUpdateTask(task: BGAppRefreshTask) {
//        task.expirationHandler = {
//            self.locationManager.requestLocation()
//        }
//    }
}
