//
//  MapViewCoordinator.swift
//  coriander
//
//  Created by Tomas Korcak on 18.05.2021.
//

import Foundation
import Mapbox

final class MapViewCoordinator: NSObject, MGLMapViewDelegate {
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
}
