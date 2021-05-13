//
//  AppReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    // MARK: LocationReducer
    state = locationReducer(action: action, state: state)
    
    // Print  ActionState
    dump(state, name: "AppState")
    
    // Return ActionState
    return state
}

