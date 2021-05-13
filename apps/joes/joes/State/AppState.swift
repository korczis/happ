//
//  AppState.swift
//  joes
//
//  Created by Tomas Korcak on 13.05.2021.
//

import Foundation
import MapKit
import ReSwift

// MARK: MapState

struct MapState {
    var locationManager: CLLocationManager = CLLocationManager()
}

// MARK: AppState

struct AppState {
    var counter: Int = 0
    var map: MapState = MapState()

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

    public func dispatch(_ action: Action) -> () -> Void {
        {
            self.store.dispatch(action)
        }
    }
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
