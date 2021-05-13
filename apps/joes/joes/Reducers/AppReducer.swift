//
//  AppReducer.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift

func counterReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
    case _ as CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }

    return state
}

