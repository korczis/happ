//
//  JourneyChartsView.swift
//  coriander
//
//  Created by Tomas Korcak on 03.06.2021.
//

import SwiftUI
import SwiftUICharts

struct JourneyChartsView: View {
    @State var journey: Journey
    
    var locations: [Location] {
        return journey.locations?
            .sortedArray(
                using: [NSSortDescriptor(key: "timestamp", ascending: false)]
            ) as! [Location]
    }
    
    var body: some View {
        GeometryReader { geometry in
            TabView {
                JourneyLocationsView(journey: journey)
                    .tabItem({
                        Image(systemName: "mappin")
                        Text("Locations")
                    })

                LineChartView(
                    data: locations.map { $0.speed * 3.6 },
                    title: "Speed",
                    legend: "km/h",
                    form: CGSize(
                        width: geometry.size.width,
                        height: geometry.size.height / 2
                    ),
                    rateValue: nil
                )
                .padding(.horizontal)
                .environment(\.colorScheme, .light)
                //                .frame(
                //                      minWidth: 0,
                //                      maxWidth: .infinity,
                //                      minHeight: 0,
                //                      maxHeight: .infinity,
                //                      alignment: .topLeading
                //                    )
                .tabItem({
                    Image(systemName: "speedometer")
                    Text("Speed")
                })

//
//                    //                JourneyLocationsView(journey: journey)
//                    //                    .tabItem({
//                    //                        Image(systemName: "speedometer")
//                    //                        Text("Speed")
//                    //                    })
//                    //
//                    //                JourneyLocationsView(journey: journey)
//                    //                    .tabItem({
//                    //                        Image(systemName: "gyroscope")
//                    //                        Text("Altitude")
//                    //                    })
            }
        }
    }
}
