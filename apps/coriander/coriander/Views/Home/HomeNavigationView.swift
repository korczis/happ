//
//  HomeNavigationView.swift
//  coriander
//
//  Created by Tomas Korcak on 20.05.2021.
//

import Foundation
import ReSwift
import SwiftUI

struct HomeNavigationView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var body: some View {
        VStack(spacing: 0) {
            HomeNavigationListView(state: state)
                            
            Spacer()
            
            StatusBarView(state: state)
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
        HomeView(state: state)
    }
}
