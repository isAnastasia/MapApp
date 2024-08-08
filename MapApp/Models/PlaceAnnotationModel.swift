//
//  PlaceAnnotationModel.swift
//  MapApp
//
//  Created by Anastasia Gorbunova on 08.08.2024.
//

import Foundation
import MapKit

class PlaceAnnotation: MKPointAnnotation {
    let mapItem: MKMapItem
    let id = UUID()
    var isChosen: Bool = false
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate
    }
    
    var name: String {
        mapItem.name ?? ""
    }
    
    var location: CLLocation {
        mapItem.placemark.location ?? CLLocation.defaultLocation
    }
    
    var address: String {
        "\(mapItem.placemark.subThoroughfare ?? "") \(mapItem.placemark.thoroughfare ?? "") \(mapItem.placemark.locality ?? "") \(mapItem.placemark.countryCode ?? "")"
    }
    
}
