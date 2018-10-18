//
//  AccelerometerHandler.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import Foundation
import CoreMotion

class AccelerometerHandler {
    static let shared = AccelerometerHandler()
    private let motion: CMMotionManager = CMMotionManager()
    var frequency: Double {
        didSet {
            self.motion.accelerometerUpdateInterval = frequency
        }
    }
    var timer: Timer!

    init() {
        self.frequency = 1.0 / 10.0 // 10 Hz
    }

    func start() -> Bool {
        guard self.motion.isAccelerometerAvailable else { return false }
        self.motion.startAccelerometerUpdates()
        return true
    }

    func fetch(update: @escaping (CMAccelerometerData) -> Void) {
        self.timer = Timer(fire: Date(), interval: frequency, repeats: true) { _ in
            if let data = self.motion.accelerometerData {
                update(data)
            }
        }
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }

    func stop() {
        if self.timer == nil { return }
        self.timer?.invalidate()
        self.timer = nil
        self.motion.stopAccelerometerUpdates()
    }
}
