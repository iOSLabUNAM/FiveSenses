//
//  LocationViewController.swift
//  FiveSenses
//
//  Created by Luis Ezcurdia on 10/17/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var startBtn: RunnerButton!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var lonLbl: UILabel!
    @IBOutlet weak var altLbl: UILabel!

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
        @unknown default:
            fatalError()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if startBtn.isActive() {
            locationManager.startUpdatingLocation()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if startBtn.isActive() {
            locationManager.stopUpdatingLocation()
        }
        super.viewWillDisappear(animated)
    }

    @IBAction func startTaped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            if startBtn.switchState() {
                locationManager.startUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
        } else {
            // TODO: Update your app’s UI to show that the location is unavailable.
        }
    }

    // MARK: CLLocationManagerDelegate methods\
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latLbl.text = location.coordinate.latitude.format()
        lonLbl.text = location.coordinate.longitude.format()
        altLbl.text = location.altitude.format()
    }
}
