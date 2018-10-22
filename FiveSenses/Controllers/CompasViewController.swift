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
    var lastLocation = CLLocation()

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
            locationManager.startUpdatingLocation()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
        super.viewWillDisappear(animated)
    }

    @IBAction func startTaped(_ sender: Any) {
        if startBtn.switchState() {
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
    }

    // MARK: CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        UIView.animate(withDuration: 0.5) {
            let location = self.lastLocation
            let latestBearing = CGFloat(location.bearingToLocationRadian(location))
            let latestHeading = CGFloat(newHeading.trueHeading.toRadians)
            self.compasIV.transform = CGAffineTransform(rotationAngle: latestBearing - latestHeading)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
    }
}
