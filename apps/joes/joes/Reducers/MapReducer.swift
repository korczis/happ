//
//  MapReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift

func mapReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case let action as SetMapCenter:
        state.map.center = action.location
        
    default:
        break
    }

    return state
}

