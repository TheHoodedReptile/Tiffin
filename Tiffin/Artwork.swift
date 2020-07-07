//
//  Artwork.swift
//  mapTester
//
//  Created by Shaurya Pathak on 8/3/19.
//  Copyright © 2019 WhitneyMediaCommunications. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let tag: Int
    
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, tag: Int) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.tag = tag
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}


