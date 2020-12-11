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
  var annotations: [MKAnnotation] = []

  // MARK: IBOutlets
  @IBOutlet weak var mapView: MKMapView! {
    didSet {
      mapView.showsUserLocation = true
      mapView.tintColor = UIColor.Zeplin.redBranding
      mapView.delegate = self

      mapView.register(
        CustomLargerAnnotation.self,
        forAnnotationViewWithReuseIdentifier: CustomLargerAnnotation.identifier
      )

      mapView.register(
        CustomSmallAnnotation.self,
        forAnnotationViewWithReuseIdentifier: CustomSmallAnnotation.identifier
      )
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

  @IBOutlet weak var storesListContainer: UIView!

  @IBOutlet weak var howManyStoresLabel: UILabel!

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self

      let bundle = Bundle.init(for: YDMFindStoreViewController.self)
      let storeCard = YDMFindStoreStoreCardCollectionViewCell.loadNib(bundle)

      collectionView.register(
        storeCard,
        forCellWithReuseIdentifier: YDMFindStoreStoreCardCollectionViewCell.identifier
      )
    }
  }

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    createMapGradient()
    setUpBinds()

    collectionView.reloadData()
    locationActivity()
    viewModel?.getPreviousAddress()
  }

  deinit {
    mapView.delegate = nil
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
  func formatHowManyStoresOnList(with howMany: Int) {
    howManyStoresLabel.text = String(format: howManyStoresLabel.text ?? "", howMany)
  }
}
