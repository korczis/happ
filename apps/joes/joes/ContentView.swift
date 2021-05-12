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
    
    var body: some View {
            TabView {
                // Map
                NavigationView{
                    MapView()
                        .navigationBarTitle("Map", displayMode: .inline)
                }
                .tabItem {
                    VStack{
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                
                // Data
                NavigationView{
                    DataView()
                        .navigationBarTitle("Data", displayMode: .inline)
                        .frame(width: 80, height: 80, alignment: .topLeading)
                }
                .tabItem {
                    VStack{
                        Image(systemName: "eye")
                        Text("Data")
                    }
                }

                // Settings
                NavigationView{
                    SettingsView()
                        .navigationBarTitle("Settings", displayMode: .inline)
                        
                }
                .tabItem {
                    VStack{
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
            }

        }
    
//    var body: some View {
//            NavigationView {
//                VStack(spacing: 30) {
//                    Text("You're going to flip a coin – do you want to choose heads or tails?")
//
//                    NavigationLink(destination: MapView()) {
//                        Text("Map")
//                    }
//
//                    NavigationLink(destination: SettingsView()) {
//                        Text("Settings")
//                    }
//                }
//                .navigationBarTitle("Home", displayMode: .inline)
//            }
//        }
    
//    var body: some View {
//       VStack {
//           Text(String(state.current.counter))
//           Button(action: state.dispatch(CounterActionIncrease())) {
//               Text("Increase")
//           }
//           Button(action: state.dispatch(CounterActionDecrease())) {
//               Text("Decrease")
//           }
//       }
//    }
    
//    var body: some View {
//        // Map(coordinateRegion: state.current.map)
//        Map(coordinateRegion: $region)
//            .navigationTitle("Joes")
//            .toolbar {
//                ToolbarItemGroup(placement: .bottomBar) {
//                    Button(action: {
//                        print("Map button was tapped")
//                    }) {
//                        HStack(spacing: 10) {
//                            Image(systemName: "map")
//                            Text("Map")
//                        }
//                    }
//
//                    Spacer()
//
//                    Button(action: {
//                        print("Settings button was tapped")
//                    }) {
//                        HStack(spacing: 10) {
//                            Image(systemName: "gear")
//                            Text("Settings")
//                        }
//                    }
//                }
//            }
//    }
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
