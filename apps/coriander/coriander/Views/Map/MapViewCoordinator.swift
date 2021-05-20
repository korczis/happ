//
//  MapViewCoordinator.swift
//  coriander
//
//  Created by Tomas Korcak on 19.05.2021.
//

import Foundation
import SwiftUI
import Mapbox

extension MapComponentView {
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapComponentView
        
        // -----
        // MARK: Private members
        // -----
        
        private var locationRecordingButton: LocationRecordingButton?
        private var userLocationButton: UserLocationButton?
        
        // -----
        // MARK: Handlers
        // -----
                
        init(_ control: MapComponentView) {
            self.control = control
        }
        
        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            return nil
        }
         
        func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
            return true
        }
        
        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
    //            // Set the maximum ambient cache size in bytes.
    //            // Call this method before the map view is loaded.
    //            // The ambient cache is created through the end user loading and using a map view.
    //            let maximumCacheSizeInBytes = UInt(64 * 1024 * 1024)
    //            MGLOfflineStorage.shared.setMaximumAmbientCacheSize(maximumCacheSizeInBytes) { (error) in
    //                guard error == nil else {
    //                    print("Unable to set maximum ambient cache size: \(error?.localizedDescription ?? "error")")
    //                    return
    //                }
    //
    //                DispatchQueue.main.async { [self] in
    //                    // Setup map first
    //                    // self.setupMapView()
    //
    //                    // Create an offline pack.
    //                    self.addOfflinePack()
    //                }
    //
    //                // Add a bar button. Tapping this button will present a menu of options.
    //                // For this example, the cache is managed through the UI.
    //                // It can also be managed by developers through remote notifications.
    //                // For more information about managing remote notifications in your iOS app, see the Apple "UserNotifications" documentation: https://developer.apple.com/documentation/usernotification
    //                let alertButton = UIBarButtonItem(
    //                    title: "Cache",
    //                    style: .plain,
    //                    target: self,
    //                    action: #selector(self.presentActionSheet)
    //                )
    //
    //                self.parent?.navigationItem.setRightBarButton(
    //                    alertButton,
    //                    animated: false
    //                )
    //            }
            
            // ----
            // MARK: Working
            // ----
            
            mapView.compassView.compassVisibility = .visible;
            
            mapView.setCenter(
                MapComponentView.defaultCenterCoordinate,
                zoomLevel: MapComponentView.defaultZoom,
                animated: false
            )
            
            mapView.autoresizingMask = [
                .flexibleWidth,
                .flexibleHeight
            ]
            
            setupButtons()
            
            // Enable the always-on heading indicator for the user location annotation.
            mapView.showsUserLocation = true
            mapView.showsUserHeadingIndicator = true
        }
        
        func mapView(_ mapView: MGLMapView, didChange mode: MGLUserTrackingMode, animated: Bool) {
            if let userLocationButton = self.userLocationButton {
                userLocationButton.updateShape(mode: mode)
            }
            
            if let locationRecordingButton = self.locationRecordingButton {
                locationRecordingButton.updateShape(isRecording: control.state.current.location.isRecording)
            }
        }
                
        func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
            let camera = MGLMapCamera(
                lookingAtCenter: annotation.coordinate,
                altitude: 4500,
                pitch: 15,
                heading: 180
            )

            mapView.fly(
                to: camera,
                withDuration: 4,
                peakAltitude: 3000,
                completionHandler: nil
            )
        }
        
//        func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
//            guard control.state.current.location.isRecording else {
//                    return
//            }
//            
//            // print("MapboxMap.mapView() - didUpdate, userLocation: \(String(describing: userLocation)), mapView: \(mapView)")
//            
//            guard let userLocation = userLocation else { return }
//            guard let userLocationRaw = userLocation.location else { return }
//            
//            // print("User location: \(userLocation)")
//            // print("User location (raw): \(userLocationRaw)")
//                                   
//            
//            if (AddLocationAction.shouldUpdateLocation(
//                oldLocation: control.state.current.location.lastLocation,
//                newLocation: userLocationRaw,
//                updateInterval: control.state.current.location.updateInterval
//            )) {
//                control.state.dispatch(AddLocationAction(location: userLocationRaw))
//            }
//        }
        
        // -----
        // MARK: Private implementation
        // -----
        
        // Update the user tracking mode when the user toggles through the
        // user tracking mode button.
        @IBAction func locationButtonTapped(sender: UserLocationButton) {
            var mode: MGLUserTrackingMode

            switch (control.mapView.userTrackingMode) {
            case .none:
                mode = .follow
            
            case .follow:
                mode = .followWithHeading
            
            case .followWithHeading:
                mode = .followWithCourse
            
            case .followWithCourse:
                mode = .none
            
            @unknown default:
                fatalError("Unknown user tracking mode")
            }

            control.mapView.userTrackingMode = mode
        }
        
        @IBAction func recordingButtonTapped(sender: LocationRecordingButton) {
            let isRecording = !control.state.current.location.isRecording;
            control.state.dispatch(SetRecordingLocationAction(isRecording: isRecording))
            locationRecordingButton?.updateShape(isRecording: isRecording)
        }
        
        private func setupButtons() {
            setupLocationButton()
            setupRecordingButton()
        }
        
        private func setupRecordingButton() {
            let locationRecordingButton = LocationRecordingButton(buttonSize: 40, isRecording: control.state.current.location.isRecording)
            
            locationRecordingButton.addTarget(
                self,
                action: #selector(recordingButtonTapped),
                for: .touchUpInside
            )
            
            self.locationRecordingButton = locationRecordingButton

            locationRecordingButton.tintColor = control.mapView.tintColor
            locationRecordingButton.translatesAutoresizingMaskIntoConstraints = false

            let constraints: [NSLayoutConstraint] = [
                NSLayoutConstraint(item: locationRecordingButton, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: userLocationButton, attribute: .bottom, multiplier: 1, constant: 10),
                NSLayoutConstraint(item: locationRecordingButton, attribute: .leading, relatedBy: .equal, toItem:  userLocationButton, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: locationRecordingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: locationRecordingButton.frame.size.height),
                NSLayoutConstraint(item: locationRecordingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: locationRecordingButton.frame.size.width)
            ]

            control.mapView.addSubview(locationRecordingButton)
            control.mapView.addConstraints(constraints)
        }
        
        private func setupLocationButton() {
            let userLocationButton = UserLocationButton(buttonSize: 40)
            userLocationButton.addTarget(
                self,
                action: #selector(locationButtonTapped),
                for: .touchUpInside
            )
            self.userLocationButton = userLocationButton
            
            userLocationButton.tintColor = control.mapView.tintColor
            userLocationButton.translatesAutoresizingMaskIntoConstraints = false

            let constraints: [NSLayoutConstraint] = [
                NSLayoutConstraint(item: userLocationButton, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: control.mapView.compassView, attribute: .bottom, multiplier: 1, constant: 10),
                NSLayoutConstraint(item: userLocationButton, attribute: .leading, relatedBy: .equal, toItem:  control.mapView.compassView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: userLocationButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.height),
                NSLayoutConstraint(item: userLocationButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.width)
            ]

            control.mapView.addSubview(userLocationButton)
            control.mapView.addConstraints(constraints)
        }
                
    }

}
