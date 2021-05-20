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
