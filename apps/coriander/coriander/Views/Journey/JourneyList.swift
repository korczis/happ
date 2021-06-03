//
//  JourneyList.swift
//  coriander
//
//  Created by Tomas Korcak on 01.06.2021.
//

import SwiftUI

struct JourneyListView: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var showingAlert = false
    @State private var toBeDeleted: [Journey]?
    
    var journeys: FetchedResults<Journey>
    
    var body: some View {
        VStack {
            List {
                ForEach(journeys, id: \.self) { journey in
                    JourneyRowView(journey: journey)
                        .id(journey.id)
                }
                .onDelete(perform: delete)
            }
            .id(UUID())
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this?"),
                    message: Text("There is no undo"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteJourneys()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        // .border(Color.red, width: 10)
    }
    
    func delete(at offsets: IndexSet) {
        toBeDeleted = offsets.map { journeys[$0] }
        showingAlert = true
    }
    
    private func deleteJourneys() {
        DispatchQueue.main.async {
            for journey in self.toBeDeleted ?? [] {
                context.delete(journey)
            }            
            toBeDeleted = nil
            
            do {
                try context.save()
                print("JourneyListView - Journey(s) was deleted")
                
            } catch let error {
                print("userReducer() - Unable to delete journey(s), reason: \(error)")
            }
        }
    }
}

struct JourneyRowView: View {
    @State var journey: Journey
    
    var body: some View {
        NavigationLink(
            destination: JourneyDetailsView(journey: journey)
                .navigationTitle("Journey Details")
        ) {
            VStack(alignment: .leading) {
                Text(String("\(journey.name!)"))
                    .font(.headline)
                
                Text(journey.startedAtStr())
                    .font(.subheadline)
                
                //                Text(journey.finishedAtStr())
                //                    .font(.subheadline)
                
                Text("\(journey.distanceStr()) - \(journey.locations!.count) points")
                    .font(.subheadline)
                
                //                Text(journey.distanceStr())
                //                    .font(.subheadline)
                //
                //                Text(String("\(journey.locations!.count) points"))
                //                    .font(.subheadline)
            }
        }
    }
}
