//
//  ContentView.swift
//  joes
//
//  Created by Tomas Korcak on 11.05.2021.
//

// MARK: Imports
import SwiftUI
import ReSwift

// MARK: ReSwift Example Setup

struct AppState {
    var counter: Int = 0
}

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}

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

let mainStore = Store<AppState>(
    reducer: counterReducer,
    state: nil
)


struct ContentView: View {
    // MARK: Private Properties
       
    @ObservedObject private var state = ObservableState(store: mainStore)

    
    // MARK: Body
       
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
    
    var body: some View {
       VStack {
           Text(String(state.current.counter))
           Button(action: state.dispatch(CounterActionIncrease())) {
               Text("Increase")
           }
           Button(action: state.dispatch(CounterActionDecrease())) {
               Text("Decrease")
           }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
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

extension ObservableState: StoreSubscriber {

    // MARK: - <StoreSubscriber>

    public func newState(state: T) {
        DispatchQueue.main.async {
            self.current = state
        }
    }
}
