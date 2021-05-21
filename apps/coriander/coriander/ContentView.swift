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

struct ContentView: View {
    @ObservedObject private var state = globalState
    
    var geolocationService: GeolocationService = GeolocationService(state: globalState)
    
    var body: some View {
        HomeView(state: state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        DataView(state: state)
    }
}
