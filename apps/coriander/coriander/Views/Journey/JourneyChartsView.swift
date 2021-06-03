//
//  JourneyChartsView.swift
//  coriander
//
//  Created by Tomas Korcak on 03.06.2021.
//

import SwiftUI
import Charts

struct JourneyChartsView: View {
    @State var journey: Journey
    
    // @State private var chartSpeed: LineChart
    
    init(journey: Journey) {
        self.journey = journey
    }
    
    var locations: [Location] {
        return journey.locations?
            .sortedArray(
                using: [NSSortDescriptor(key: "timestamp", ascending: false)]
            ) as! [Location]
    }
    
    private var chartAltitude: some View {
        VStack {
            LineChart(
                entries: locations.enumerated().map { (index, element) in
                    ChartDataEntry(
                        x: Double(index), // Double((element.timestamp?.timeIntervalSince1970)!),
                        y: element.altitude // element.speed * 3.6
                    )
                },
                setupChart: { chart, dataSet in
                    // Change bars color to green
                    dataSet.colors = [NSUIColor.green]
                    
                    // Change data label
                    dataSet.label = "Altitude"
                    dataSet.drawCirclesEnabled = false
                    dataSet.drawFilledEnabled = true
                    dataSet.fillColor = .green
                    dataSet.mode = .cubicBezier
                }
            )
        }
    }
    
    private var chartSpeed: some View {
        VStack {
            LineChart(
                entries: locations.enumerated().map { (index, element) in
                    ChartDataEntry(
                        x: Double(index), // Double((element.timestamp?.timeIntervalSince1970)!),
                        y: element.speed * 3.6
                    )
                },
                setupChart: { chart, dataSet in
                    // Change bars color to green
                    dataSet.colors = [NSUIColor.green]
                    
                    // Change data label
                    dataSet.label = "Speed"
                    dataSet.drawCirclesEnabled = false
                    dataSet.drawFilledEnabled = true
                    dataSet.fillColor = .green
                    dataSet.mode = .cubicBezier
                }
            )
        }
    }
    
    var body: some View {
        TabView {
            // Chart speed
            chartSpeed
            .tabItem({
              Image(systemName: "speedometer")
              Text("Speed")
            })
            
            // Chart speed
            chartAltitude
            .tabItem({
              Image(systemName: "thermometer")
              Text("Altitude")
            })
        }
    }
}
