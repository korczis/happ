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
    
    var body: some View {
        // bodyCards
        bodyList
    }
    
    var avatar: KFImage {
        let hash: String = (state.current.user.current?.email?.MD5)!
        let url = "https://www.gravatar.com/avatar/\(hash)?s=200"
        
        return KFImage(
            source: .network(URL(string: url)!)
        )
    }
    
    var bodyCards: some View {
        ZStack {
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
        VStack() {
            NavigationView {
                List() {
                    
                    if let user = state.current.user.current {
                        VStack {
                            HStack() {
                                Spacer()
                                
                                Text(String("\(user.firstname!) \(user.lastname!)"))
                                    .font(.title)
                                
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            avatar
                                //.scaleFactor(UIScreen.main.scale)
                                .renderingMode(.original)
                                .resizable()
                            
                            HStack() {
                                Spacer()
                                
                                Text("\(user.email!)")
                                    .font(.subheadline)
                                
                                Spacer()
                            }
                            .padding(.bottom)
                        }
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
