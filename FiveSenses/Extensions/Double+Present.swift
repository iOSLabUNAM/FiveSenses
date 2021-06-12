//
//  Double+Present.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/18/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import Foundation

extension Double {
    func format(precition: Int = 1000) -> String {
        let trimed = Float(Float(self) * Float(precition)) / Float(precition)
        return "\(trimed)"
    }
}
