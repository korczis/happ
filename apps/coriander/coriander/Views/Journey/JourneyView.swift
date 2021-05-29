//
//  JourneyView.swift
//  coriander
//
//  Created by Tomas Korcak on 28.05.2021.
//

import CloudKit
import CoreData
import SwiftUI
import ReSwift
import MapKit

struct JourneyView: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var state: ObservableState<AppState>
    
    @FetchRequest var data: FetchedResults<Journey>
    
    init(state: ObservableState<AppState>) {
        self.state = state
        
        let request: NSFetchRequest<Journey> = Journey.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Journey.startedAt, ascending: false)
        ]
        request.fetchOffset = 0
        request.fetchLimit = 5
        request.includesPendingChanges = false
        
        _data = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        JourneyListView(journeys: self.data)
            .navigationBarTitle("Journeys", displayMode: .inline)
    }
}

struct JourneyListView: View {
    var journeys: FetchedResults<Journey>
    
    var body: some View {
        List (journeys, id: \.self) { journey in
            JourneyRowView(journey: journey)
                .id(journey.id)
        }
        .id(UUID())
    }
}

struct JourneyRowView: View {
    var journey: Journey
    
    var body: some View {
        NavigationLink(
            destination: JourneyDetailsView(journey: journey)
                .navigationTitle("Journey Details")
        ) {
            VStack(alignment: .leading) {
                Text(journey.name!)
                    .font(.subheadline)
            }
        }
    }
}

struct JourneyDetailsView: View {
    @State var journey: Journey
    
    var body: some View {
        let locations  = journey.locations!
        
        VStack {
            Text(String(format: "Locations (%d)", locations.count))
            
            List(Array(locations as Set), id: \.self) { location in
                NavigationLink(
                    destination: LocationDetailsView(location: location as! Location)
                        .navigationTitle("Locations")
                ) {
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.subheadline)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        DataView(state: state)
    }
}
