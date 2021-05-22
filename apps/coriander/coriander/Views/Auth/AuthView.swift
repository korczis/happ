//
//  MainView.swift
//  coriander
//
//  Created by Tomas Korcak on 21.05.2021.
//


import SwiftUI

// -----

struct MainView: View {
    @Environment(\.window) var window: UIWindow?
        
    var body: some View {
        let provider = AuthAppleView()
        
        ZStack {
            Text(String("MainView"))
            
            VStack {
                provider.environment(\.window, window)
                    .frame(width: 280, height: 60)
                    .onTapGesture(perform: provider.show)
            }
        }
    }

}
