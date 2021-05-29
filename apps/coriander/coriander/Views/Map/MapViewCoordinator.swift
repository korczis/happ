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
            // TODO: Duplicate of implementation in SatusBarView
            
            let isRecording = control.state.current.location.isRecording;
            
            switch isRecording {
            case true:
                control.state.dispatch(LocationRecordingStopAction())
                break
                
            case false:
                control.state.dispatch(LocationRecordingStartAction())
                break
            }
                        
            locationRecordingButton?.updateShape(isRecording: isRecording)
        }
        
        private func setupButtons() {
            setupLocationButton()
            
            // setupRecordingButton()
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
