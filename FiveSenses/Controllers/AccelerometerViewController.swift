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
        super.viewWillAppear(animated)
        if startBtn.isActive() {
            _ = AccelerometerHandler.shared.start()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            AccelerometerHandler.shared.stop()
        }
        super.viewWillDisappear(animated)
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
        xLabel.text = data.acceleration.x.format()
        yLabel.text = data.acceleration.y.format()
        zLabel.text = data.acceleration.z.format()
    }
}
