//
//  MapView.swift
//  coriander
//
//  Created by Tomas Korcak on 18.05.2021.
//

import SwiftUI
import Mapbox

struct MapView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var body: some View {
        MapComponentView(state: state)
            .centerCoordinate(
                .init(
                    latitude: 37.791293,
                    longitude: -122.396324
                )
            )
    }
}

struct MapComponentView: UIViewRepresentable {   
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
    
    internal let mapView: MGLMapView = MGLMapView(
        frame: .zero, // view.bounds
        styleURL: MapComponentView.defaultStyleUrl
    )
    
    // -----
    // MARK: Public members
    // -----
    
    @ObservedObject var state: ObservableState<AppState>
    
    // ----
    // MARK: - Configuring UIViewRepresentable protocol
    // -----
    
    func makeUIView(context: UIViewRepresentableContext<MapComponentView>) -> MGLMapView {
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapComponentView>) {
        // NOTE: Put your update code here
    }
    
    func makeCoordinator() -> MapComponentView.Coordinator {
        Coordinator(self)
    }
    
    // -----
    // MARK: - Configuring MGLMapView
    // -----
    
    func styleURL(_ styleURL: URL) -> MapComponentView {
        mapView.styleURL = styleURL
        return self
    }
    
    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapComponentView {
        mapView.centerCoordinate = centerCoordinate
        return self
    }
    
    func zoomLevel(_ zoomLevel: Double) -> MapComponentView {
        mapView.zoomLevel = zoomLevel
        return self
    }
    
    // -----
    // MARK: - Implementing MGLMapViewDelegate
    // -----
    
    
    
    // -----
    // Cache
    // ------
    
}
