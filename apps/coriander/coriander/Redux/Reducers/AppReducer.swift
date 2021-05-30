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

    // print("AppState - Before reducing, action: \(action), state: \(state)")
    
    // MARK: JourneyReducer
    state = journeyReducer(action: action, state: state)
    
    // MARK: LocationReducer
    state = locationReducer(action: action, state: state)
    
    // MARK: UserReducer
    state = userReducer(action: action, state: state)
    
    // Print  ActionState
    // print("AppState - After reducing, state: \(state)")
    
    // Return ActionState
    return state
}

