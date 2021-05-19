//
//  MapView.swift
//  coriander
//
//  Created by Tomas Korcak on 18.05.2021.
//

import SwiftUI
import Mapbox

struct MapView: UIViewRepresentable {
    // -----
    // MARK: Constants
    // -----
    
    static let defaultCenterCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 49.195060,
        longitude: 16.606837
    )
    
    static let defaultStyleUrl = URL(string: "mapbox://styles/korczis/ckonz34zh1hi717qlog0tf45n")
    
    static let defaultZoom: Double = 9
    
    // -----
    // MARK: Private members
    // -----
    
    private let mapView: MGLMapView = MGLMapView(
        frame: .zero, // view.bounds
        styleURL: MapView.defaultStyleUrl
    )
        
    // -----
    // MARK: Public members
    // -----
    
    @ObservedObject var state: ObservableState<AppState>
        
    // ----
    // MARK: - Configuring UIViewRepresentable protocol
    // -----
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MGLMapView {
        mapView.delegate = context.coordinator
                
        return mapView
    }
    
    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapView>) {
       // NOTE: Put your update code here
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    // -----
    // MARK: - Configuring MGLMapView
    // -----
    
    func styleURL(_ styleURL: URL) -> MapView {
        mapView.styleURL = styleURL
        return self
    }
    
    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapView {
        mapView.centerCoordinate = centerCoordinate
        return self
    }
    
    func zoomLevel(_ zoomLevel: Double) -> MapView {
        mapView.zoomLevel = zoomLevel
        return self
    }
    
    // -----
    // MARK: - Implementing MGLMapViewDelegate
    // -----
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapView
        
        // -----
        // MARK: Private members
        // -----
        
        private var locationRecordingButton: LocationRecordingButton?
        private var userLocationButton: UserLocationButton?
        
        // -----
        // MARK: Handlers
        // -----
                
        init(_ control: MapView) {
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
                MapView.defaultCenterCoordinate,
                zoomLevel: MapView.defaultZoom,
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
        
        func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
            guard control.state.current.location.isRecording else {
                    return
            }
            
            // print("MapboxMap.mapView() - didUpdate, userLocation: \(String(describing: userLocation)), mapView: \(mapView)")
            
            guard let userLocation = userLocation else { return }
            guard let userLocationRaw = userLocation.location else { return }
            
            // print("User location: \(userLocation)")
            // print("User location (raw): \(userLocationRaw)")
                                   
            
            if (AddLocationAction.shouldUpdateLocation(
                oldLocation: control.state.current.location.lastLocation,
                newLocation: userLocationRaw,
                updateInterval: control.state.current.location.updateInterval
            )) {
                control.state.dispatch(AddLocationAction(location: userLocationRaw))
            }
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
    
    // -----
    // Cache
    // ------
    
    // Check whether the tiles locally cached match those on the tile server. If the local tiles are out-of-date, they will be updated. Invalidating the ambient cache is preferred to clearing the cache. Tiles shared with offline packs will not be affected by this method.
//        func invalidateAmbientCache() {
//            let start = CACurrentMediaTime()
//            MGLOfflineStorage.shared.invalidateAmbientCache { (error) in
//                guard error == nil else {
//                    print("Error: \(error?.localizedDescription ?? "unknown error")")
//                    return
//                }
//                let difference = CACurrentMediaTime() - start
//
//                // Display an alert to indicate that the invalidation is complete.
//                DispatchQueue.main.async { [unowned self] in
//                    self.presentCompletionAlertWithContent(title: "Invalidated Ambient Cache", message: "Invalidated ambient cache in \(difference) seconds")
//                }
//            }
//        }
//
//        // Check whether the local offline tiles match those on the tile server. If the local tiles are out-of-date, they will be updated. Invalidating an offline pack is preferred to removing and reinstalling the pack.
//        func invalidateOfflinePack() {
//            if let pack = MGLOfflineStorage.shared.packs?.first {
//                let start = CACurrentMediaTime()
//                MGLOfflineStorage.shared.invalidatePack(pack) { (error) in
//                    guard error == nil else {
//                        // The pack couldn’t be invalidated for some reason.
//                        print("Error: \(error?.localizedDescription ?? "unknown error")")
//                        return
//                    }
//                    let difference = CACurrentMediaTime() - start
//                   // Display an alert to indicate that the invalidation is complete.
//                    DispatchQueue.main.async { [unowned self] in
//                        self.presentCompletionAlertWithContent(title: "Offline Pack Invalidated", message: "Invalidated offline pack in \(difference) seconds")
//                    }
//                }
//            }
//        }
//
//        // This removes resources from the ambient cache. Resources which overlap with offline packs will not be impacted.
//        func clearAmbientCache() {
//            let start = CACurrentMediaTime()
//            MGLOfflineStorage.shared.clearAmbientCache { (error) in
//                guard error == nil else {
//                    print("Error: \(error?.localizedDescription ?? "unknown error")")
//                    return
//                }
//                let difference = CACurrentMediaTime() - start
//               // Display an alert to indicate that the ambient cache has been cleared.
//                DispatchQueue.main.async { [unowned self] in
//                    self.presentCompletionAlertWithContent(title: "Cleared Ambient Cache", message: "Ambient cache has been cleared in \(difference) seconds.")
//                }
//            }
//        }
//
//        // This method deletes the cache.db file, then reinitializes it. This deletes offline packs and ambient cache resources. You should not need to call this method. Invalidating the ambient cache and/or offline packs should be sufficient for most use cases.
//        func resetDatabase() {
//            let start = CACurrentMediaTime()
//            MGLOfflineStorage.shared.resetDatabase { (error) in
//                guard error == nil else {
//                    print("Error: \(error?.localizedDescription ?? "unknown error")")
//                    return
//                }
//                let difference = CACurrentMediaTime() - start
//
//                // Display an alert to indicate that the cache.db file has been reset.
//                DispatchQueue.main.async { [unowned self] in
//                    self.presentCompletionAlertWithContent(title: "Database Reset", message: "The cache.db file has been reset in \(difference) seconds.")
//                }
//            }
//        }
//
//        func addOfflinePack() {
//            let region = MGLTilePyramidOfflineRegion(styleURL: mapView.styleURL, bounds: mapView.visibleCoordinateBounds, fromZoomLevel: 0, toZoomLevel: 2)
//
//            let info = ["name": "Offline Pack"]
//
//
//            do {
//                let context = try NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: false)
//
//                MGLOfflineStorage.shared.addPack(for: region, withContext: context) { (pack, error) in
//                    guard error == nil else {
//                        // The pack couldn’t be created for some reason.
//                        print("Error: \(error?.localizedDescription ?? "unknown error")")
//                        return
//                    }
//                    pack?.resume()
//                }
//            } catch {
//                print("MapboxMapViewController.addOfflinePack()")
//            }
//        }
//
//        // -----
//        // Cache - UI Components
//        // -----
//
//        // Create an action sheet that handles the cache management.
//        @objc func presentActionSheet() {
//            let alertController = UIAlertController(title: "Cache Management Options", message: nil, preferredStyle: .actionSheet)
//            alertController.addAction(UIAlertAction(title: "Invalidate Ambient Cache", style: .default, handler: { (action) in
//                self.invalidateAmbientCache()
//            }))
//            alertController.addAction(UIAlertAction(title: "Invalidate Offline Pack", style: .default, handler: { (action) in
//                self.invalidateOfflinePack()
//            }))
//            alertController.addAction(UIAlertAction(title: "Clear Ambient Cache", style: .default, handler: { (action) in
//                self.clearAmbientCache()
//            }))
//            alertController.addAction(UIAlertAction(title: "Reset Database", style: .default, handler: { (action) in
//                self.resetDatabase()
//            }))
//            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//            alertController.popoverPresentationController?.sourceView = mapView
//            present(alertController, animated: true, completion: nil)
//        }
//
//        func presentCompletionAlertWithContent(title: String, message: String) {
//            let completionController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            completionController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//
//            present(completionController, animated: false, completion: nil)
//        }
    
}
