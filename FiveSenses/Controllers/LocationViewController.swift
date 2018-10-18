//
//  LocationViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var lonLbl: UILabel!
    @IBOutlet weak var altLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startTaped(_ sender: Any) {
        _ = startBtn.switchState()
    }
}
