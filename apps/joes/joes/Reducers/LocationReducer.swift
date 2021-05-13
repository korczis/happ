//
//  LocationReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift

func locationReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case let action as SetLastKnownLocation:
        state.location.lastKnownLocation = action.location
        state.location.locationHistory.append(action.location)
        
    default:
        break
    }

    return state
}
