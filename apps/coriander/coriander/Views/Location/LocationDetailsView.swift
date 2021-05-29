//
//  LocationDetailsView.swift
//  coriander
//
//  Created by Tomas Korcak on 27.05.2021.
//

import CoreLocation
import SwiftUI
import ReSwift

func formatLocationAddress(location: Location) -> String {
    return String(format: "%.4f %.4f", location.longitude, location.latitude)
}

func formatPlacemarkAddress(placemark: CLPlacemark?) -> String? {
    guard let placemark = placemark else {
        return nil
    }
    
    var address = String("")
    
    if let locality = placemark.locality {
        address += locality
    }
    
    if let thoroughfare = placemark.thoroughfare {
        address += ", " + thoroughfare
    }
    
    if let subThoroughfare = placemark.subThoroughfare {
        address += " " + subThoroughfare
    }
    
    if (address != "") {
        return address
    }
    
    return nil
}

struct LocationDetailsView: View {
    @State var location: Location
    @State private var placemark: CLPlacemark?
    
    init(location: Location) {
        // print("Constructor")
        self.location = location
    }
    
    var title: String {
        // print("Getting title")
        
        if let address = formatPlacemarkAddress(placemark: placemark) {
            // print("Getting title - returning placemark")
            return address
        }
        
        // print("Getting title - returnning raw location")
        return formatLocationAddress(location: location)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title)
                
                // Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            // print("onAppear - begin")
            
            if let _ = self.placemark {
                return
            }
            
            let cllocation = CLLocation(
                latitude: location.latitude,
                longitude: location.longitude
            )
            
            //print("onAppear - calling geocoder")
            CLGeocoder().reverseGeocodeLocation(cllocation) { placemark, error in
                guard let placemark = placemark else {
                    return
                }
                
                // print("reverseGeocodeLocation() - \(String(describing: place))")
                
                // print("onAppear - setting placemark")
                self.placemark = placemark[0]
            }
        }
        .onDisappear() {
            print("onDisappear - clearing placemark")
            self.placemark = nil
        }
        .id(location.id)
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let location = Location()
        
        LocationDetailsView(location: location)
    }
}


