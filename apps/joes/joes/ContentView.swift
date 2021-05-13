//
//  ContentView.swift
//  joes
//
//  Created by Tomas Korcak on 11.05.2021.
//

// MARK: Imports
import SwiftUI
import ReSwift


// Global store instance
let mainStore = Store<AppState>(
    reducer: appReducer,
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
                    MapView(state: self.state)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
