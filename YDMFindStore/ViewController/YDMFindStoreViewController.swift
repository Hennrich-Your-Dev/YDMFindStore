//
//  YDMFindStoreViewController.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit
import CoreLocation

import YDUtilities
import YDExtensions
import YDLocationModule

class YDMFindStoreViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDMFindStoreViewModelDelegate?
  var locationManager: YDLocation {
    let manager = YDLocation.shared
    manager.delegate = self
    return manager
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    createMapGradient()
    locationManager.start()
  }

  // MARK: IBOutlets
  @IBOutlet weak var mapView: MKMapView!
}

// MARK: Actions
extension YDMFindStoreViewController {

}

// MARK: YDLocation
extension YDMFindStoreViewController: YDLocationDelegate {
  func permissionDenied() {
    //
  }

  func locationError(_ error: Error) {
    //
  }

  func onLocation(_ location: CLLocation) {
    zoomToUsersLocation(location.coordinate)
  }
}
