//
//  YDMFindStoreViewController.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit
import CoreLocation

import YDB2WAssets
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
  @IBOutlet weak var mapView: MKMapView! {
    didSet {
      mapView.showsUserLocation = true
      mapView.tintColor = UIColor.Zeplin.redBranding
    }
  }

  @IBOutlet weak var navBarContainer: UIView! {
    didSet {
      navBarContainer.backgroundColor = .clear
    }
  }

  @IBOutlet weak var exitButton: UIButton! {
    didSet {
      exitButton.layer.cornerRadius = exitButton.frame.height / 2
      exitButton.setImage(Icons.leftArrow, for: .normal)
    }
  }

  @IBOutlet weak var listButton: UIButton! {
    didSet {
      listButton.layer.cornerRadius = 16
      listButton.setImage(Icons.bars, for: .normal)
    }
  }

  @IBOutlet weak var locationContainer: UIView!

  @IBOutlet weak var locationPinIcon: UIImageView!

  @IBOutlet weak var locationButton: UIButton!

  @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var locationChevronIcon: UIImageView!
  
  // MARK: IBActions

  @IBAction func onExitAction(_ sender: Any) {
    viewModel?.onExit()
  }

  @IBAction func onListAction(_ sender: Any) {
    viewModel?.onList()
  }
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
