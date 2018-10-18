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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if startBtn.isActive() {
            _ = AccelerometerHandler.shared.start()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            AccelerometerHandler.shared.stop()
        }
    }

    @IBAction func startTaped(_ sender: Any) {
        if startBtn.switchState() {
            _ = AccelerometerHandler.shared.start()
            AccelerometerHandler.shared.fetch(update: updateData)
        } else {
            AccelerometerHandler.shared.stop()
        }
    }

    func updateData(_ data: CMAccelerometerData) {
        xLabel.text = format(data.acceleration.x)
        yLabel.text = format(data.acceleration.y)
        zLabel.text = format(data.acceleration.z)
    }

    func format(_ value: Double, precition: Int = 1000) -> String {
        let trimed = Float(value * Double(precition)) / Float(precition)
        return "\(trimed)"
    }
}
