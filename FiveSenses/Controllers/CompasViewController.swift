//
//  MagnetometerViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit
import CoreLocation

class CompasViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var compasIV: UIImageView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        enableBasicLocationServices()
    }

    func enableBasicLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Disable location features")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Enable location features")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if startBtn.isActive() {
            locationManager.startUpdatingHeading()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            locationManager.stopUpdatingHeading()
        }
        super.viewWillDisappear(animated)
    }

    @IBAction func startTaped(_ sender: Any) {
        if startBtn.switchState() {
            locationManager.startUpdatingHeading()
        } else {
            locationManager.stopUpdatingHeading()
        }
    }

    // MARK: CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        UIView.animate(withDuration: 0.5) {
            let angle = newHeading.trueHeading.toRadians
            self.compasIV.transform = CGAffineTransform(rotationAngle: CGFloat(angle)) // rotate the picture
        }
    }
}
