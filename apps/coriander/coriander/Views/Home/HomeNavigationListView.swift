//
//  HomeNavigationListView.swift
//  coriander
//
//  Created by Tomas Korcak on 22.05.2021.
//

import ReSwift
import SwiftUI

struct HomeNavigationListView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var body: some View {
        ZStack() {
            NavigationView {
                List() {
                    // -----
                    NavigationLink(
                        destination: MapView(state: state)
                            .navigationTitle("Map")
                    ) {
                        HStack {
                            Image(systemName: "map")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            // .scaledToFit()
                            
                            Text("Map")
                                .padding(.leading, 15)
                                .font(.title)
                        }
                        .frame(maxHeight: 25)
                    }
                    
                    
                    // -----
                    
                    
                    NavigationLink(
                        destination: DataView(state: state)
                            .navigationTitle("Data")
                    ) {
                        HStack {
                            Image(systemName: "list.dash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            // .scaledToFit()
                            
                            Text("Data")
                                .padding(.leading, 15)
                                .font(.title)
                                .lineLimit(2)
                        }
                        .frame(maxHeight: 25)
                    }
                    
                    // -----
                    
                    
                    NavigationLink(
                        destination: SettingsView()
                            .navigationTitle("Settings")
                    ) {
                        HStack {
                            Image(systemName: "gearshape")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            // .scaledToFit()
                            
                            Text("Settings")
                                .padding(.leading, 15)
                                .font(.title)
                                .lineLimit(2)
                        }
                        .frame(maxHeight: 25)
                    }
                    
                    
                }
                .navigationBarTitle("Home", displayMode: .inline)
            }
            .background(Color(UIColor(named: "BackgroundColor") ?? UIColor()))
        }
    }
}

struct HomeNavigationListView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        HomeNavigationListView(state: state)
    }
}
