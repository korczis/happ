//
//  LineChart.swift
//  coriander
//
//  Created by Tomas Korcak on 03.06.2021.
//

import Charts
import SwiftUI

// -----

//struct GenericChart<
//    ViewType: ChartViewBase, ChartDataProvider> : UIViewRepresentable {
//    typealias SetupChartCallback = (ViewType, LineChartDataSet) ->Void
//    
//    private var _setupChart: SetupChartCallback
//    
//    // Bar chart accepts data as array of BarChartDataEntry objects
//    private var _entries : [ChartDataEntry]
//    
//    @State private var _chart: ViewType
//    
//    init(entries: [ChartDataEntry], setupChart: @escaping SetupChartCallback) {
//        _entries = entries
//        
//        _chart = ViewType()
//        
//        self._setupChart = setupChart
//    }
//    
//    var entries: [ChartDataEntry] {
//        _entries
//    }
//    
//    // This func is required to conform to UIViewRepresentable protocol
//    func makeUIView(context: Context) -> ViewType {
//        _chart.data = addData()
//        
//        return _chart
//    }
//    
//    // This func is required to conform to UIViewRepresentable protocol
//    func updateUIView(_ uiView: ViewType, context: Context) {
//        // When data changes chartd.data update is required
//        uiView.data = addData()
//    }
//    
//    func addData() -> LineChartData {
//        let dataSet = LineChartDataSet(entries: entries)
//        
//        self._setupChart(_chart, dataSet)
//        
//        return LineChartData(dataSet: dataSet)
//    }
//    
//    typealias UIViewType = ViewType
//}

// -----

struct LineChart : UIViewRepresentable {
    typealias SetupChartCallback = (LineChartView, LineChartDataSet) ->Void
    
    private var _setupChart: SetupChartCallback
    
    // Bar chart accepts data as array of BarChartDataEntry objects
    private var _entries : [ChartDataEntry]
    
    @State private var _chart: LineChartView
    
    init(entries: [ChartDataEntry], setupChart: @escaping SetupChartCallback) {
        _entries = entries
        
        _chart = LineChartView()
        
        self._setupChart = setupChart
    }
    
    var entries: [ChartDataEntry] {
        _entries
    }
    
    // This func is required to conform to UIViewRepresentable protocol
    func makeUIView(context: Context) -> LineChartView {
        _chart.data = addData()
        
        return _chart
    }
    
    // This func is required to conform to UIViewRepresentable protocol
    func updateUIView(_ uiView: LineChartView, context: Context) {
        // When data changes chartd.data update is required
        uiView.data = addData()
    }
    
    func addData() -> LineChartData {
        let dataSet = LineChartDataSet(entries: entries)
        
        self._setupChart(_chart, dataSet)
        
        return LineChartData(dataSet: dataSet)
    }
    
    typealias UIViewType = LineChartView
}

// -----

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(
            entries: [
                //x - position of a bar, y - height of a bar
                ChartDataEntry(x: 1, y: 1),
                ChartDataEntry(x: 2, y: 1),
                ChartDataEntry(x: 3, y: 1),
                ChartDataEntry(x: 4, y: 1),
                ChartDataEntry(x: 5, y: 1)
                
            ],
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

