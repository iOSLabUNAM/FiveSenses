//
//  CLLocations+Bearing.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/22/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLLocation {
    func bearingToLocationRadian(_ destinationLocation: CLLocation) -> Double {
        let lat1 = self.coordinate.latitude.toRadians
        let lon1 = self.coordinate.longitude.toRadians

        let lat2 = destinationLocation.coordinate.latitude.toRadians
        let lon2 = destinationLocation.coordinate.longitude.toRadians

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)

        return radiansBearing
    }

    func bearingToLocationDegrees(destinationLocation: CLLocation) -> Double {
        return bearingToLocationRadian(destinationLocation)
    }
}
