//
//  GyroscopeViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit
import CoreMotion

class GyroscopeViewController: UIViewController {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if startBtn.isActive() {
            motionManager.startGyroUpdates()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            motionManager.stopGyroUpdates()
        }
        super.viewWillDisappear(animated)
    }

    var timer: Timer?
    var frecuency = 1.0 / 10.0 // 10Hz
    @IBAction func startTaped(_ sender: Any) {
        guard motionManager.isGyroAvailable else {
            print("Gyro is not available")
            return
        }
        if startBtn.switchState() {
            motionManager.gyroUpdateInterval = frecuency
            motionManager.startGyroUpdates()
            self.timer = Timer(fire: Date(), interval: frecuency, repeats: true) {  _ in
                guard let data = self.motionManager.gyroData else { return }
                self.xLabel.text = data.rotationRate.x.format()
                self.yLabel.text = data.rotationRate.y.format()
                self.zLabel.text = data.rotationRate.z.format()
            }
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        } else {
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
                motionManager.stopGyroUpdates()
            }
        }
    }
}
