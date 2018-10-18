//
//  GyroscopeViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit

class GyroscopeViewController: UIViewController {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startTaped(_ sender: Any) {
        _ = startBtn.switchState()
//        if let run = self.active, run {
//            _ = AccelerometerHandler.shared.start()
//            AccelerometerHandler.shared.fetch(update: updateData)
//        } else {
//            AccelerometerHandler.shared.stop()
//        }
    }
}
