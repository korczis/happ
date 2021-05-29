//
//  AuthReducer.swift
//  coriander
//
//  Created by Tomas Korcak on 21.05.2021.
//

import ReSwift

func authReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    // -----
    
    let setAuthUserAction = { (action: SetAuthUserAction) -> AppState in
        state.auth.user = action.user
        return state
    }
        
    // -----
    
    switch action {
    case let action as SetAuthUserAction:
        return setAuthUserAction(action)
                
    default:
        return state
    }
}
