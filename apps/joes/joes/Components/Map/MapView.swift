//
//  MapView.swift
//  joes
//
//  Created by Tomas Korcak on 12.05.2021.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit
import ReSwift

//struct MapView: UIViewRepresentable
//{
//    @ObservedObject var state: ObservableState<AppState>
//    @State var map: MKMapView = MKMapView(frame: UIScreen.main.bounds)
//        
//    func makeUIView(context: Context) -> MKMapView {
//        // dump(self, name: "MapView - makeUIView");
//        
//        // MARK: Global Map Settings
//        map.delegate = context.coordinator
//        
//        // map.showsCompass = false
//        // map.isRotateEnabled = false
//        // map.showsScale = false
//        // map.showsUserLocation = true
//        // map.userTrackingMode = .none
//        
//        
//        // Return created map
//        return map
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        // map.setCenter(state.current.location.currentLocation.coordinate, animated: true)
//        // map.setCenter(state.current.map.center, animated: true)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(state)
//    }
//    
//}
//
//struct MapView_Previews: PreviewProvider {
//    static let previewStore = Store<AppState>(
//        reducer: appReducer,
//        state: nil
//    )
//    
//    static var previews: some View {
//        let state = ObservableState(store: mainStore)
//        MapView(state: state)
//    }
//}
