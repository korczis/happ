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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.74699, longitude: -73.98742), zoomLevel: 9, animated: false)
        view.addSubview(mapView)

        mapView.styleURL = MGLStyle.satelliteStyleURL
         
        // Add a point annotation
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77014, longitude: -73.97480)
        annotation.title = "Central Park"
        annotation.subtitle = "The biggest park in New York City!"
        mapView.addAnnotation(annotation)
         
        // Set the map view's delegate
        mapView.delegate = self
         
        // Allow the map view to display the user's location
        mapView.showsUserLocation = true
    }
         
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4500, pitch: 15, heading: 180)
        mapView.fly(to: camera, withDuration: 4,
        peakAltitude: 3000, completionHandler: nil)
    }
}

//class MapboxMapController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
//        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 9, animated: false)
//        view.addSubview(mapView)
//    }
//}


struct MapboxMap: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> MapboxMapViewController {
        let mapboxMap = MapboxMapViewController()
        return mapboxMap
    }

    func updateUIViewController(_ mapboxMapViewController: MapboxMapViewController, context: Context) {

    }
}
