//
//  ContentView.swift
//  joes
//
//  Created by Tomas Korcak on 11.05.2021.
//

// MARK: Imports
import Foundation
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
            NavigationView {
                ZStack {
                    MapboxMap(state: self.state)
                        .navigationBarTitle("Map", displayMode: .inline)
                        .ignoresSafeArea()
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
