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
    
    var mapView: MGLMapView!
    var userLocationButton: UserLocationButton?
    
    // -----
    // MARK: Public Implementation
    // -----
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup MapView
        setupMapView()
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
        userLocationButton.tintColor = mapView.tintColor

        // Setup constraints such that the button is placed within
        // the upper left corner of the view.
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false

        var leadingConstraintSecondItem: AnyObject
        if #available(iOS 11.0, *) {
            leadingConstraintSecondItem = view.safeAreaLayoutGuide
        } else {
            leadingConstraintSecondItem = view
        }

        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: userLocationButton, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: userLocationButton, attribute: .leading, relatedBy: .equal, toItem: leadingConstraintSecondItem, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: userLocationButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.height),
            NSLayoutConstraint(item: userLocationButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: userLocationButton.frame.size.width)
        ]

        view.addSubview(userLocationButton)
        view.addConstraints(constraints)

        self.userLocationButton = userLocationButton
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
    // MARK: Handlers
    // -----
    
    // void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style;
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    // Update the button state when the user tracking mode updates or resets.
    func mapView(_ mapView: MGLMapView, didChange mode: MGLUserTrackingMode, animated: Bool) {
        guard let userLocationButton = userLocationButton else { return }
        userLocationButton.updateArrowForTrackingMode(mode: mode)
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
    
    // Tweak style when loaded
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        mapView.compassView.compassVisibility = .visible;
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        print("MapboxMap.mapViewDidFinishLoadingMap(\(mapView))")
        
        mapView.locationManager.requestAlwaysAuthorization()
        // mapView.locationManager.requestWhenInUseAuthorization()
        
        // Allow the map view to display the user's location
        mapView.showsUserLocation = true
    }
}

struct MapboxMap: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapboxMapViewController {
        return MapboxMapViewController()
    }

    func updateUIViewController(_ mapboxMapViewController: MapboxMapViewController, context: Context) {

    }
}
