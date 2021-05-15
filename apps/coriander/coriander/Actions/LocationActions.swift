//
//  LocationActions.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit
import ReSwift

struct SetLastKnownLocation: Action {
    var location: CLLocation
}
