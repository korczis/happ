//
//  JourneyLocationsView.swift
//  coriander
//
//  Created by Tomas Korcak on 02.06.2021.
//

import SwiftUI

struct JourneyLocationsView: View {
    @State var journey: Journey
    
    private var locations: [Location] {
        journey.locations?
            .sortedArray(
                using: [NSSortDescriptor(key: "timestamp", ascending: false)]
            ) as! [Location]
    }
    
    var body: some View {
        VStack {
            List(self.locations, id: \.self) { location in
                NavigationLink(
                    destination: LocationDetailsView(location: location)
                        .navigationTitle("Location")
                ) {
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.headline)
                        
                        Text("\(location.timestamp!, formatter: DateHelper.defaultDateFormatter)")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}
