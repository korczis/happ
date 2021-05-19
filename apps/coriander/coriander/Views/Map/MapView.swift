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
    
    internal let mapView: MGLMapView = MGLMapView(
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
