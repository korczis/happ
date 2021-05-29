//
//  AppState.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import ReSwift

// MARK: AppState

struct AppState {
    var auth: AuthState = AuthState()
    var journey: JourneyState = JourneyState()
    var location: LocationState = LocationState()
}

// MARK: ObservableState

public class ObservableState<T>: ObservableObject {

    // MARK: Public properties

    @Published public var current: T

    // MARK: Private properties

    private var store: Store<T>

    // MARK: Lifecycle

    public init(store: Store<T>) {
        self.store = store
        self.current = store.state

        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    // MARK: Public methods

    public func dispatch(_ action: Action) {
        store.dispatch(action)
    }

//    private func dispatch(_ action: Action) -> () -> Void {
//        {
//            self.store.dispatch(action)
//        }
//    }
}

// MARK: ObservableState - StoreSubscriber

extension ObservableState: StoreSubscriber {

    // MARK: - <StoreSubscriber>

    public func newState(state: T) {
        DispatchQueue.main.async {
            self.current = state
        }
    }
}

// MARKL Create state global instance
// -----
// MARK: Global Store Instance
// -----
let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

var globalState = ObservableState(store: mainStore)
