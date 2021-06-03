//
//  LocationDetailsView.swift
//  coriander
//
//  Created by Tomas Korcak on 27.05.2021.
//

import CoreLocation
import SwiftUI
import ReSwift
import MapKit

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

struct LocationDetailsDataView: View {
    @State var location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
            // -----
            
            HStack {
                Text("Position")
                    .font(.headline)
                Spacer()
            }
            
//            HStack {
//                 Text(String(format: "%.4f %.4f ± %.2f m", location.longitude, location.latitude, location.horizontalAccuracy))
//                    .font(.subheadline)
//
//                Spacer()
//            }
//            .padding(.bottom, 3)
//
            HStack {
                Text(location.latitude.asLatitude)
                    .font(.subheadline)
                
                Spacer()
            }
            
            HStack {
                Text(location.longitude.asLongitude)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.bottom, 3)
            
            // -----
            
            HStack {
                Text("Altitude")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(String(format: "%.2f m ± %.2f m", location.altitude, location.verticalAccuracy))
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
            
            // -----
            
            if let floor = location.floor {
                HStack {
                    Text("Floor")
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Text("\(floor)")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.bottom, 3)
            }
            
            // -----
            
            HStack {
                Text("Course")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(String(format: "%.4f ° ± %.2f °", location.course, location.courseAccuracy))
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
            
            // -----
            
            HStack {
                Text("Speed")
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Text(String(format: "%.2f km/h ± %.2f km/h", location.speed * 3.6, location.speedAccuracy * 3.6))
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom, 3)
            
        }
        .padding(.horizontal)
    }
}

struct LocationDetailsMapView: View {
    @State var location: Location
    
    @State var region: MKCoordinateRegion
    
    init(location: Location) {
        self.location = location
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.5,
                longitudeDelta: 0.5
            )
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [location]) { item in
            MapPin(coordinate: .init(latitude: item.latitude, longitude: item.longitude))
        }
    }
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
            //            var data = [
            //                (name: "Longitude", value: location.longitude)
            //            ]
            
            HStack {
                Text(title)
                    .font(.title)
                
                // Spacer()
            }
            .padding(.vertical)
            
            LocationDetailsDataView(location: location)
            
            LocationDetailsMapView(location: location)
            
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
    
    var location: Location {
        let location = Location()
        
        location.timestamp = Date()
        location.latitude = 49.195060
        location.longitude = 16.606837
        
        return location
    }
    
    static var previews: some View {
        let context = ((UIApplication.shared.delegate as? AppDelegate)?.dataStack.context)!
        
        let location = Location(context: context)
        
        location.timestamp = Date()
        location.latitude = 49.195060
        location.longitude = 16.606837
        location.altitude = 237.0
        location.speed = 4.56
        location.course = 1.23
        location.horizontalAccuracy = 4
        location.verticalAccuracy = 5
        location.speedAccuracy = 6
        location.courseAccuracy = 7
        
        return LocationDetailsView(location: location)
    }
}


