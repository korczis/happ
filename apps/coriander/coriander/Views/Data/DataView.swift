//
//  DataView.swift
//  joes
//
//  Created by Tomas Korcak on 12.05.2021.
//

import CloudKit
import CoreData
import SwiftUI
import ReSwift
import MapKit

struct DataView: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var state: ObservableState<AppState>
    
    @FetchRequest var data: FetchedResults<Location>
    
    init(state: ObservableState<AppState>) {
        self.state = state
        
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        // request.predicate = NSPredicate(format: "active = true")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Location.timestamp, ascending: false)
        ]
        request.fetchOffset = 0
        request.fetchLimit = 5
        request.includesPendingChanges = false
        
        _data = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        let count = data.count;
        
        DataListView(locations: self.data)
            .navigationBarTitle("Data (\(count))", displayMode: .inline)
    }
}

struct DataListView: View {
    var locations: FetchedResults<Location>
    
    var body: some View {
        List (locations, id: \.self) { location in
            DataRowView(location: location)
                .id(location.id)
        }
        .id(UUID())
    }
}

struct DataRowView: View {
    var location: Location
        
    var body: some View {
        NavigationLink(
            destination: LocationDetailsView(location: location)
                .navigationTitle("Location Details")
        ) {
            VStack(alignment: .leading) {
                Text("\(location.timestamp!, formatter: DateHelper.defaultDateFormatter)")
                Text(String(format: "Location: %.4f %.4f", location.latitude, location.longitude))
                    .font(.subheadline)
            }
        }
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


//struct LocationListRowView: View {
//    var location: CLLocation
//
//    static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//
//        // formatter.dateStyle = .long
//        // formatter.timeStyle = .long
//
//        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSS"
//
//        return formatter
//    }()
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("\(location.timestamp, formatter: Self.dateFormatter)")
//            Text(String(format: "Location: %.4f %.4f ± %.2f", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy))
//                .font(.subheadline)
//            Text(String(format: "Altitude: %.4f m ± %.2f m", location.altitude, location.verticalAccuracy))
//                .font(.subheadline)
//            Text(String(format: "Speed: %.4f km/h ± %.2f m", location.speed * 3.6, location.speedAccuracy))
//                .font(.subheadline)
//            Text(String(format: "Heading: %.2f", location.course))
//                .font(.subheadline)
//        }
//    }
//}
//
//struct LocationListView: View {
//    var locations: [CLLocation]
//
//    var body: some View {
//        List (locations.reversed(), id: \.self) { location in
//            LocationListRowView(location: location)
//        }
//        .id(UUID())
//    }
//}
//
//struct DataView: View {
//    @ObservedObject var state: ObservableState<AppState>
//
//    var locations: RingArray<CLLocation> {
//        let locationState: LocationState = state.current.location;
//        return locationState.history;
//    }
//
//    var body: some View {
//        LocationListView(locations: Array(locations))
//            .navigationBarTitle("Data (\(state.current.location.history.count) / \(state.current.location.processedCount))", displayMode: .inline)
//    }
//}
//
//struct DataView_Previews: PreviewProvider {
//    static let previewStore = Store<AppState>(
//        reducer: appReducer,
//        state: nil
//    )
//
//    static var previews: some View {
//        let state = ObservableState(store: previewStore)
//        DataView(state: state)
//    }
//}
