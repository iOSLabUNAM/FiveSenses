//
//  CGFloat+Radiants.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/18/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import Foundation

extension Double {
    var toRadians: Double { return self * .pi / 180 }
    var toDegrees: Double { return self * 180 / .pi }
}
