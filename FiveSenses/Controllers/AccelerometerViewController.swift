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
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!

    var active: Bool? {
        didSet {
            if let active = self.active, active {
                startBtn.setTitle("Stop", for: .normal)
            } else {
                startBtn.setTitle("Start", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.active = false
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let run = self.active else { return }
        if run {
            _ = AccelerometerHandler.shared.start()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        guard let run = self.active else { return }
        if run {
            AccelerometerHandler.shared.stop()
        }
    }

    @IBAction func startTaped(_ sender: Any) {
        self.active = !(self.active ?? false)
        if let run = self.active, run {
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
