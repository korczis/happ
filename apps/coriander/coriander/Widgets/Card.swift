//
//  Card.swift
//  coriander
//
//  Created by Tomas Korcak on 29.05.2021.
//

import SwiftUI

// See:
// - https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
struct Card: View {
    
    var title: String
    var subtitle: String?
    var description: String?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 25)
                            .scaledToFill()
                            // .padding(.trailing)
                        
                        Text(title)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                    }
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .bold()
                    }
                    
                    if let description = description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Spacer() // Add a spacer to push our HStack to the left and the spacer fill the empty space
                
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Card(
                    title: "Map"
                )
                
                Card(
                    title: "Journeys"
                )
                
                Card(
                    title: "Settings"
                )
                
            }
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}
