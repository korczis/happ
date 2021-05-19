//
//  DataView.swift
//  joes
//
//  Created by Tomas Korcak on 12.05.2021.
//

import SwiftUI
import ReSwift
import MapKit

struct LocationListRowView: View {
    var location: CLLocation
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        // formatter.dateStyle = .long
        // formatter.timeStyle = .long
        
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSS"

        return formatter
    }()
    
    var body: some View {
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

struct LocationListView: View {
    var locations: [CLLocation]
    
    var body: some View {
        List (locations.reversed(), id: \.self) { location in
            LocationListRowView(location: location)
        }
        .id(UUID())
    }
}

struct DataView: View {
    @ObservedObject var state: ObservableState<AppState>
    
    var locations: RingArray<CLLocation> {
        let locationState: LocationState = state.current.location;
        return locationState.history;
    }
    
    var body: some View {
        // let lastLocations: [CLLocation] = locations.suffix(5);
        LocationListView(locations: Array(locations))
        
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
