//
//  Journey.swift
//  coriander
//
//  Created by Tomas Korcak on 01.06.2021.
//

import CoreData

extension Journey {
    static let DefaultName: String = "Default Name"
    static let DefaultDesc: String = "Default Description"
    
    func getDistance() -> Double {
        var res: (Double, Location?) = (0, nil)
        
        let locations = self.locations?
            .sortedArray(
                using: [NSSortDescriptor(key: "timestamp", ascending: false)]
            ) as! [Location]
        
        
        res = locations.reduce(res, { acc, el in
            guard let last = acc.1 else {
                return (acc.0, el)
            }
            
            let from = CLLocation(
                latitude: last.latitude,
                longitude: last.longitude
            )

            let to = CLLocation(
                latitude: el.latitude,
                longitude: el.longitude
            )
            
            return (acc.0 + to.distance(from: from), el)
        })
        
        return res.0
    }
    
    func distanceStr() -> String {
        let distance = self.getDistance()
        if distance < 1000 {
            return String(format: "%.2f m", distance)
        } else {
            return String(format: "%.2f km", distance * 0.001)
        }
    }
    
    func startedAtStr() -> String {
        DateHelper.defaultDateFormatter.string(from: startedAt!)
    }
    
    func finishedAtStr() -> String {
        if let date = self.finishedAt {
            return DateHelper.defaultDateFormatter.string(from: date)
        }
        
        let lastLocation = self.locations?
            .sortedArray(
                using: [
                    NSSortDescriptor(key: "timestamp", ascending: false)
                ]
            )
            .first as! Location
        
        return DateHelper.defaultDateFormatter.string(from: lastLocation.timestamp!)
    }
}
