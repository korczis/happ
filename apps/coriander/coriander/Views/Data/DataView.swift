//
//  DataView.swift
//  joes
//
//  Created by Tomas Korcak on 12.05.2021.
//

import SwiftUI
import ReSwift

struct DataView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        
        return formatter
    }()
    
    var body: some View {
        List {
            ForEach(state.current.location.locationHistory, id: \.self) { location in
                VStack(alignment: .leading) {
                    Text("\(location.timestamp, formatter: Self.dateFormatter)")
                    Text(String(format: "Location: %.4f %.4f ± %.2f", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy))
                        .font(.subheadline)
                    Text(String(format: "Altitude: %.4f m ± %.2f m", location.altitude, location.verticalAccuracy))
                        .font(.subheadline)
                    Text(String(format: "Speed: %.4f km/h ± %.2f m", location.speed * 3.6, location.speedAccuracy))
                        .font(.subheadline)
                    Text(String(format: "Heading: %.2f", location.course))
                        .font(.subheadline)
                }

            }
        }
        .id(UUID())
    }
}

struct DataView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        DataView(state: state)
    }
}
