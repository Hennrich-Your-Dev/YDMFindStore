//
//  YDLocation.swift
//  YDLocationModule
//
//  Created by Douglas Hennrich on 14/09/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit
import CoreLocation

public class YDLocation: NSObject {

  // MARK: Properties
  public static let shared = YDLocation()

  public var delegate: YDLocationDelegate? {
    didSet {
      canTrigger = true
    }
  }

  private var canTrigger = false

  private var status: CLAuthorizationStatus = {
    return CLLocationManager.authorizationStatus()
  }()

  private let locationManager = CLLocationManager()

  // MARK: Init
  public override init() {
    super.init()
    locationManager.delegate = self
  }

  // MARK: Actions
  private func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }

  private func searchForCurrentLocation() {
    locationManager.requestLocation()
  }

}

// MARK: Public Actions
extension YDLocation {

  public func getStatus() -> CLAuthorizationStatus {
    return status
  }

  public func start() {
    if status == .notDetermined {
      return requestAuthorization()
    }

    if status == .denied {
      delegate?.permissionDenied()
      return
    }

    searchForCurrentLocation()
  }

}

extension YDLocation: CLLocationManagerDelegate {

  public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    self.status = status

    if !canTrigger {
      return
    }

    if status == .authorizedWhenInUse {
      searchForCurrentLocation()

    } else if status == .denied {
      delegate?.permissionDenied()
    }

  }

  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let currentLocation = locations.last {
      delegate?.onLocation(currentLocation)
    }
  }

  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    delegate?.locationError(error)
  }
}
