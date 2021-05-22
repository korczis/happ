//
//  StatusBar.swift
//  coriander
//
//  Created by Tomas Korcak on 22.05.2021.
//

import Foundation
import ReSwift
import SwiftUI

struct StatusBarView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var body: some View {
        VStack() {
            HStack() {
                let lastLocation = state.current.location.lastLocation
                let lastCoordinate = lastLocation.coordinate
                
                Text("Lng: \(lastCoordinate.longitude), Lat: \(lastCoordinate.latitude), Alt: \(lastLocation.altitude)m")
                
                Spacer()
            }
            .alignmentGuide(.leading) { _ in  10 }
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray)
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        StatusBarView(state: state)
    }
}

