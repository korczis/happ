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
    // MARK: Public Implementation
    // -----
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(
            frame: view.bounds,
            styleURL: MapboxMapViewController.defaultStyleUrl
        )
        
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
         
        // Set the map view's delegate
        mapView.delegate = self
        
        // And finally add as Subview of current View
        view.addSubview(mapView)
    }
    
    // -----
    // MARK: Private Implementation
    // -----
    
    // -----
    // MARK: Handlers
    // -----
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
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
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        print("MapboxMap.mapViewDidFinishLoadingMap(\(mapView))")
        
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
