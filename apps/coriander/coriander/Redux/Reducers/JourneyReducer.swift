//
//  JourneyReducer.swift
//  coriander
//
//  Created by Tomas Korcak on 28.05.2021.
//

import ReSwift

func journeyReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
        
    // -----
    
    let journeyActiveSet = { (action: JourneyActiveSetAction) -> AppState in
        state.journey.active = action.journey
        return state
    }
    
    // -----
    
    switch action {
    
    case let action as JourneyActiveSetAction:
        return journeyActiveSet(action)

    default:
        return state
    }
}

