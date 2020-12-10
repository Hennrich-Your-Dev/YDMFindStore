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

class YDMFindStoreViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDMFindStoreViewModelDelegate?
  var alreadyPlaceCurrentLocationMarker = false

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    createMapGradient()
    setUpBinds()

    locationActivity()
    viewModel?.getPreviousAddress()
  }

  // MARK: IBOutlets
  @IBOutlet weak var mapView: MKMapView! {
    didSet {
      mapView.showsUserLocation = true
      mapView.tintColor = UIColor.Zeplin.redBranding
      mapView.delegate = self
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

  @IBOutlet weak var locationPinIcon: UIImageView! {
    didSet {
      locationPinIcon.image = Icons.locationPin
    }
  }

  @IBOutlet weak var locationButton: UIButton! {
    didSet {
      locationButton.setImage(Icons.point, for: .normal)
    }
  }

  @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var locationChevronIcon: UIImageView! {
    didSet {
      locationChevronIcon.image = Icons.chevronDown
    }
  }

  // MARK: IBActions
  @IBAction func onExitAction(_ sender: Any) {
    viewModel?.onExit()
  }

  @IBAction func onListAction(_ sender: Any) {
    viewModel?.onList()
  }

  @IBAction func onLocationAction(_ sender: Any) {
    locationActivity()
    viewModel?.onGetLocation()
  }
}

// MARK: Actions
extension YDMFindStoreViewController {

}
