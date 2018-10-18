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
        if startBtn.switchState() {
            motionManager.startGyroUpdates()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.switchState() {
            motionManager.stopGyroUpdates()
        }
        super.viewWillDisappear(animated)
    }

    var timer: Timer?
    var frecuency = 1.0 / 60.0 // 60Hz
    @IBAction func startTaped(_ sender: Any) {
        if startBtn.switchState() {
            motionManager.gyroUpdateInterval = frecuency
            timer = Timer(fire: Date(), interval: frecuency, repeats: true) { [weak self] _ in
                guard let data = self?.motionManager.gyroData else { return }
                self?.xLabel.text = data.rotationRate.x.format()
                self?.yLabel.text = data.rotationRate.y.format()
                self?.zLabel.text = data.rotationRate.z.format()
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
