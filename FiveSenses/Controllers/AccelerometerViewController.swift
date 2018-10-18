//
//  AccelerometerViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit
import CoreMotion

class AccelerometerViewController: UIViewController {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    let motionManager: CMMotionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if startBtn.isActive() {
            motionManager.startAccelerometerUpdates()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            motionManager.stopAccelerometerUpdates()
        }
        super.viewWillDisappear(animated)
    }

    var timer: Timer?
    var frecuency = 1.0 / 10.0 // 10Hz
    @IBAction func startTaped(_ sender: Any) {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available")
            return
        }
        if startBtn.switchState() {
            motionManager.accelerometerUpdateInterval = frecuency
            motionManager.startAccelerometerUpdates()
            self.timer = Timer(fire: Date(), interval: frecuency, repeats: true) { _ in
                guard let data = self.motionManager.accelerometerData else { return }
                self.xLabel.text = data.acceleration.x.format()
                self.yLabel.text = data.acceleration.y.format()
                self.zLabel.text = data.acceleration.z.format()
            }
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        } else {
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
                self.motionManager.stopAccelerometerUpdates()
            }
        }
    }
}
