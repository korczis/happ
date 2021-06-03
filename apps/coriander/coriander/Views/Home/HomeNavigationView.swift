//
//  HomeNavigationListView.swift
//  coriander
//
//  Created by Tomas Korcak on 22.05.2021.
//

import CryptoKit
import ReSwift
import SwiftUI

import Kingfisher
import struct Kingfisher.KFImage
import struct Kingfisher.BlackWhiteProcessor
import struct Kingfisher.DownsamplingImageProcessor

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

struct HomeNavigationView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var user: User? {
        return state.current.user.current
    }
    
    var body: some View {
        // bodyCards
        bodyList
    }
    
    var bodyCards: some View {
        VStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        NavigationLink(
                            destination: MapView(state: state)
                                .navigationTitle("Map")
                        ) {
                            Card(
                                title: "Map"
                            )
                        }
                        
                        Card(
                            title: "Journeys"
                        )
                        
                        Card(
                            title: "Settings"
                        )
                        
                    }
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                .navigationBarTitle("Home", displayMode: .inline)
                .padding(.top)
            }
        }
    }
    
    var bodyList: some View {
        VStack(spacing: 0) {
            NavigationView {
                List() {
                    if let user = user {
                        ProfileCard(user: user)
                            .padding(.leading, 10)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                    }
                    
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
                        destination: JourneyView(state: state)
                            .navigationTitle("Journeys")
                    ) {
                        HStack {
                            Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            // .scaledToFit()
                            
                            Text("Journeys")
                                .padding(.leading, 15)
                                .font(.title)
                                .lineLimit(2)
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
                        destination: MaintenanceView(state: state)
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
        }
    }
}

struct HomeNavigationView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        HomeNavigationView(state: state)
    }
}
