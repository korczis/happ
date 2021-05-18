//
//  MapViewController.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import SwiftUI
import Mapbox


class MapboxMapViewController: UIViewController, MGLMapViewDelegate {
    // -----
    // MARK: Constants
    // -----
    static let defaultCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 49.195060,
        longitude: 16.606837
    )
    
    static let defaultStyleUrl = URL(string: "mapbox://styles/korczis/ckonz34zh1hi717qlog0tf45n")
    
    static let defaultZoom: Double = 9
    
    // -----
    // MARK: Private members / attributes
    // -----
    
    private var _state: ObservableState<AppState>?
    
    var mapView: MGLMapView!
    var userLocationButton: UserLocationButton?
    
    // -----
    // Getters / Setters
    // -----
    
    public var state: ObservableState<AppState>? {
        get {
            return self._state
        }
        set {
            self._state = newValue
        }
    }
    
    // -----
    // MARK: Public Implementation
    // -----
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the maximum ambient cache size in bytes.
        // Call this method before the map view is loaded.
        // The ambient cache is created through the end user loading and using a map view.
        let maximumCacheSizeInBytes = UInt(64 * 1024 * 1024)
        MGLOfflineStorage.shared.setMaximumAmbientCacheSize(maximumCacheSizeInBytes) { (error) in
            guard error == nil else {
                print("Unable to set maximum ambient cache size: \(error?.localizedDescription ?? "error")")
                return
            }

            DispatchQueue.main.async { [self] in
                // Setup map first
                self.setupMapView()

                // Create an offline pack.
                self.addOfflinePack()
            }
            
            // Add a bar button. Tapping this button will present a menu of options.
            // For this example, the cache is managed through the UI.
            // It can also be managed by developers through remote notifications.
            // For more information about managing remote notifications in your iOS app, see the Apple "UserNotifications" documentation: https://developer.apple.com/documentation/usernotification
            let alertButton = UIBarButtonItem(
                title: "Cache",
                style: .plain,
                target: self,
                action: #selector(self.presentActionSheet)
            )
            
            self.parent?.navigationItem.setRightBarButton(
                alertButton,
                animated: false
            )
        }
    }
    
    // -----
    // MARK: Private Implementation
    // -----
    
    // Update the user tracking mode when the user toggles through the
    // user tracking mode button.
    @IBAction func locationButtonTapped(sender: UserLocationButton) {
        var mode: MGLUserTrackingMode

        switch (mapView.userTrackingMode) {
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

        mapView.userTrackingMode = mode
    }
    
    // Button creation and autolayout setup
    private func setupLocationButton() {
        let userLocationButton = UserLocationButton(buttonSize: 40)
        userLocationButton.addTarget(
            self,
            action: #selector(locationButtonTapped),
            for: .touchUpInside
        )
        self.userLocationButton = userLocationButton
        
        userLocationButton.tintColor = mapView.tintColor
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: userLocationButton, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: mapView.compassView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: userLocationButton, attribute: .leading, relatedBy: .equal, toItem:  mapView.compassView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: userLocationButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.height),
            NSLayoutConstraint(item: userLocationButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.width)
        ]

        view.addSubview(userLocationButton)
        view.addConstraints(constraints)
    }
    
    private func setupMapView() {
        let mapView = MGLMapView(
            frame: view.bounds,
            styleURL: MapboxMapViewController.defaultStyleUrl
        )
        self.mapView = mapView
        
        mapView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        
        mapView.setCenter(
            MapboxMapViewController.defaultCenter,
            zoomLevel: MapboxMapViewController.defaultZoom,
            animated: false
        )
         
        // Add a point annotation
        // let annotation = MGLPointAnnotation()
        // annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77014, longitude: -73.97480)
        // annotation.title = "Central Park"
        // annotation.subtitle = "The biggest park in New York City!"
        // mapView.addAnnotation(annotation)
         
        // Enable the always-on heading indicator for the user location annotation.
        mapView.showsUserLocation = true
        mapView.showsUserHeadingIndicator = true
        
        mapView.compassView.isHidden = false

        
        // Set the map view's delegate
         mapView.delegate = self
        
        // And finally add as Subview of current View
        view.addSubview(mapView)
        
        // Create button to allow user to change the tracking mode.
        setupLocationButton()
    }
    
    // -----
    // Cache
    // ------
    
    // Check whether the tiles locally cached match those on the tile server. If the local tiles are out-of-date, they will be updated. Invalidating the ambient cache is preferred to clearing the cache. Tiles shared with offline packs will not be affected by this method.
    func invalidateAmbientCache() {
        let start = CACurrentMediaTime()
        MGLOfflineStorage.shared.invalidateAmbientCache { (error) in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            let difference = CACurrentMediaTime() - start
           
            // Display an alert to indicate that the invalidation is complete.
            DispatchQueue.main.async { [unowned self] in
                self.presentCompletionAlertWithContent(title: "Invalidated Ambient Cache", message: "Invalidated ambient cache in \(difference) seconds")
            }
        }
    }

    // Check whether the local offline tiles match those on the tile server. If the local tiles are out-of-date, they will be updated. Invalidating an offline pack is preferred to removing and reinstalling the pack.
    func invalidateOfflinePack() {
        if let pack = MGLOfflineStorage.shared.packs?.first {
            let start = CACurrentMediaTime()
            MGLOfflineStorage.shared.invalidatePack(pack) { (error) in
                guard error == nil else {
                    // The pack couldn’t be invalidated for some reason.
                    print("Error: \(error?.localizedDescription ?? "unknown error")")
                    return
                }
                let difference = CACurrentMediaTime() - start
               // Display an alert to indicate that the invalidation is complete.
                DispatchQueue.main.async { [unowned self] in
                    self.presentCompletionAlertWithContent(title: "Offline Pack Invalidated", message: "Invalidated offline pack in \(difference) seconds")
                }
            }
        }
    }

    // This removes resources from the ambient cache. Resources which overlap with offline packs will not be impacted.
    func clearAmbientCache() {
        let start = CACurrentMediaTime()
        MGLOfflineStorage.shared.clearAmbientCache { (error) in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            let difference = CACurrentMediaTime() - start
           // Display an alert to indicate that the ambient cache has been cleared.
            DispatchQueue.main.async { [unowned self] in
                self.presentCompletionAlertWithContent(title: "Cleared Ambient Cache", message: "Ambient cache has been cleared in \(difference) seconds.")
            }
        }
    }

    // This method deletes the cache.db file, then reinitializes it. This deletes offline packs and ambient cache resources. You should not need to call this method. Invalidating the ambient cache and/or offline packs should be sufficient for most use cases.
    func resetDatabase() {
        let start = CACurrentMediaTime()
        MGLOfflineStorage.shared.resetDatabase { (error) in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            let difference = CACurrentMediaTime() - start

            // Display an alert to indicate that the cache.db file has been reset.
            DispatchQueue.main.async { [unowned self] in
                self.presentCompletionAlertWithContent(title: "Database Reset", message: "The cache.db file has been reset in \(difference) seconds.")
            }
        }
    }
    
    func addOfflinePack() {
        let region = MGLTilePyramidOfflineRegion(styleURL: mapView.styleURL, bounds: mapView.visibleCoordinateBounds, fromZoomLevel: 0, toZoomLevel: 2)

        let info = ["name": "Offline Pack"]
        
        
        do {
            let context = try NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: false)
            
            MGLOfflineStorage.shared.addPack(for: region, withContext: context) { (pack, error) in
                guard error == nil else {
                    // The pack couldn’t be created for some reason.
                    print("Error: \(error?.localizedDescription ?? "unknown error")")
                    return
                }
                pack?.resume()
            }
        } catch {
            print("MapboxMapViewController.addOfflinePack()")
        }
    }
    
    // -----
    // Cache - UI Components
    // -----
    
    // Create an action sheet that handles the cache management.
    @objc func presentActionSheet() {
        let alertController = UIAlertController(title: "Cache Management Options", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Invalidate Ambient Cache", style: .default, handler: { (action) in
            self.invalidateAmbientCache()
        }))
        alertController.addAction(UIAlertAction(title: "Invalidate Offline Pack", style: .default, handler: { (action) in
            self.invalidateOfflinePack()
        }))
        alertController.addAction(UIAlertAction(title: "Clear Ambient Cache", style: .default, handler: { (action) in
            self.clearAmbientCache()
        }))
        alertController.addAction(UIAlertAction(title: "Reset Database", style: .default, handler: { (action) in
            self.resetDatabase()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alertController.popoverPresentationController?.sourceView = mapView
        present(alertController, animated: true, completion: nil)
    }

    func presentCompletionAlertWithContent(title: String, message: String) {
        let completionController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        completionController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

        present(completionController, animated: false, completion: nil)
    }
    
    // -----
    // MARK: Handlers
    // -----
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    // Update the button state when the user tracking mode updates or resets.
    func mapView(_ mapView: MGLMapView, didChange mode: MGLUserTrackingMode, animated: Bool) {
        guard let userLocationButton = userLocationButton else { return }
        userLocationButton.updateArrowForTrackingMode(mode: mode)
    }
    
    // Tweak style when loaded
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        mapView.compassView.compassVisibility = .visible;
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
    
    // - (void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(nullable MGLUserLocation *)userLocation;
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        print("MapboxMap.mapView() - didUpdate, mapView: \(mapView), userLocation: \(userLocation)")
        
        guard let userLocation = userLocation else { return }
        guard let userLocationRaw = userLocation.location else { return }
        
        // print("User location: \(userLocation)")
        // print("User location (raw): \(userLocationRaw)")
        
        guard let state = self.state else { return }
        
        if (AddLocationAction.shouldUpdateLocation(
            oldLocation: state.current.location.lastKnownLocation,
                newLocation: userLocationRaw
        )) {
            state.dispatch(AddLocationAction(location: userLocationRaw))
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.locationManager.requestAlwaysAuthorization()
        // mapView.locationManager.requestWhenInUseAuthorization()
        
        // Allow the map view to display the user's location
        mapView.showsUserLocation = true
    }
}

struct MapboxMap: UIViewControllerRepresentable {
    @ObservedObject var state: ObservableState<AppState>
    
    func makeUIViewController(context: Context) -> MapboxMapViewController {
        let controller = MapboxMapViewController()
        controller.state = state
        
        return controller;
    }

    func updateUIViewController(_ mapboxMapViewController: MapboxMapViewController, context: Context) {

    }
}
