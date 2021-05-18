//
//  ContentView.swift
//  joes
//
//  Created by Tomas Korcak on 11.05.2021.
//

// MARK: Imports
import Foundation
import Mapbox
import ReSwift
import SwiftUI

// -----
// MARK: Global Store Instance
// -----
let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

struct ContentView: View {
    @ObservedObject private var state = ObservableState(store: mainStore)
    
    var body: some View {
        TabView {
            // Map
            NavigationView {
                ZStack {
                    
                    MapView(state: self.state, parent: self)
                        .centerCoordinate(
                            .init(
                                latitude: 37.791293,
                                longitude: -122.396324
                            )
                        )
                        .zoomLevel(16)
                        .navigationBarTitle("Map", displayMode: .inline)
                      
                }
                
            }
            .tabItem {
                VStack{
                    Image(systemName: "map")
                    Text("Map")
                }
            }
            
            // Data
            NavigationView{
                DataView(state: self.state)
                    .navigationBarTitle("Data (\(state.current.location.locationHistory.count))", displayMode: .inline)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
