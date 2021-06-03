//
//  JourneyDetailsView.swift
//  coriander
//
//  Created by Tomas Korcak on 01.06.2021.
//

import SwiftUI
import SwiftUICharts

struct JourneyDetailsDataView: View {
    @State var journey: Journey
    
    var body: some View {
        VStack(alignment: .leading) {
            // -----
            
            HStack {
                Text("Started")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(journey.startedAtStr())
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
            // -----
            
            HStack {
                Text("Finished")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(journey.finishedAtStr())
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
            // -----
            
            HStack {
                Text("Distance")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(journey.distanceStr())
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
            // -----
            
            HStack {
                Text("Points")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(String("\(journey.locations!.count)"))
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
        }.padding(.horizontal)
    }
}

struct JourneyDetailsView: View {
    @Environment(\.managedObjectContext) var context
    
    @State var journey: Journey
       
    @State private var name: String = ""
    @State private var isEditingName: Bool = false
    
    init(journey: Journey) {
        self.journey = journey
        self.name = journey.name ?? Journey.DefaultName
    }
    
    var body: some View {
        VStack {
            HStack {
                if (!isEditingName) {
                    Text(journey.name ?? Journey.DefaultName)
                        .font(.title)
                        .onTapGesture(count: 2) {
                            name = journey.name ?? Journey.DefaultName
                            isEditingName = true
                        }
                } else {
                    TextField("Name", text: $name) { isEditing in
                        self.isEditingName = isEditing
                    } onCommit: {
                        if (name != "") {
                            journey.name = name
                            
                            do {
                                try context.save()
                                print("JourneyDetailsView - Journey name was update")
                                
                            } catch let error {
                                print("JourneyDetailsView() - Unable to update journey name, reason: \(error)")
                            }
                        }
                        self.isEditingName = false
                    }
                    
                    .font(.title)
                }
            }
            .padding(.vertical)
            
            JourneyDetailsDataView(journey: journey)
            
            JourneyChartsView(journey: journey)
            
            // JourneyLocationsView(journey: journey)
            
            Spacer()
        }
        //        .navigationBarItems(
        //            trailing:
        //                NavigationLink(destination: SettingsView()) {
        //                       Text("Push")
        //                   }.navigationBarTitle(Text("Master"))
        //        )
        //        .navigationBarItems(
        //            trailing: Button(action: {
        //                print("Export button pressed...")
        //
        //                // path to documents directory
        //                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        //                if let documentDirectoryPath = documentDirectoryPath {
        //                    // create the custom folder path
        //                    let imagesDirectoryPath = documentDirectoryPath.appending("/images")
        //                    let fileManager = FileManager.default
        //                    if !fileManager.fileExists(atPath: imagesDirectoryPath) {
        //                        do {
        //                            try fileManager.createDirectory(
        //                                atPath: imagesDirectoryPath,
        //                                withIntermediateDirectories: false,
        //                                attributes: nil
        //                            )
        //                        } catch {
        //                            print("Error creating images folder in documents dir: \(error)")
        //                        }
        //                    }
        //                }
        //            }) {
        //                Text("Export")
        //            }
        //        )
        //        .navigationBarItems(
        //            trailing: NavigationLink(
        //                destination: SettingsView()
        //                    .navigationTitle("Location")
        //            ) {
        //                VStack(alignment: .leading) {
        //                    Text("Location")
        //                        .font(.headline)
        //
        //                }
        //            }
        //        )
    }
}

//struct JourneyDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        JourneyDetailsView()
//    }
//}

