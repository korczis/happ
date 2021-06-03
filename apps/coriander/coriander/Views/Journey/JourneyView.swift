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
        VStack {
            HStack {
                Text("Journeys")
                    .font(.title)

                // Spacer()
            }
            .padding(.vertical)
            
            JourneyListView(journeys: self.data)
                .navigationBarTitle("Journeys", displayMode: .inline)
                .padding(.vertical)
            //            .toolbar {
            //                ToolbarItemGroup(placement: .navigationBarTrailing) {
            //                    Button("About") {
            //                        print("About tapped!")
            //                    }
            //
            //                    Button("Help") {
            //                        print("Help tapped!")
            //                    }
            //                }
            //            }
            // .navigationBarItems(trailing:
            //    Button(action: {
            //        print("Edit button pressed...")
            //    }) {
            //        Text("Edit")
            //    }
            // )
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
