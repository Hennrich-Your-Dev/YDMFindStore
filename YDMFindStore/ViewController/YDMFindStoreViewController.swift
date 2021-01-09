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
  var reAdjustinRect = false
  var currentStoreIndex = 0

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

      if #available(iOS 13, *) {
        let pointsFilter = MKPointOfInterestFilter(including: [
          .hotel,
          .hospital,
          .aquarium,
          .beach,
          .nationalPark,
          .museum,
          .stadium,
          .zoo,
          .theater,
          .movieTheater,
          .publicTransport,
          .airport
        ])

        mapView.showsPointsOfInterest = true
        mapView.pointOfInterestFilter = pointsFilter
      } else {
        mapView.showsPointsOfInterest = false
      }
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
  
  @IBOutlet weak var myLocationButton: UIButton! {
    didSet {
      myLocationButton.layer.cornerRadius = myLocationButton.frame.height / 2
      myLocationButton.setImage(Icons.gps, for: .normal)
      myLocationButton.imageView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
      myLocationButton.imageView?.center = myLocationButton.center
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
  
  @IBAction func onMyLocationAction(_ sender: UIButton) {
    let userCoords = mapView.userLocation.coordinate
    
    if let firstStoreCoords = viewModel?.stores.value.first?.geolocation,
       let latitude = firstStoreCoords.latitude,
       let longitude = firstStoreCoords.longitude {
      
      let nearstStoreCoords = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      setMapCenterBetween(positionA: userCoords, positionB: nearstStoreCoords)
      
    } else {
      let span = mapView.region.span
      zoomToPosition(userCoords, withSpan: span)
    }
  }
}

// MARK: Actions
extension YDMFindStoreViewController {
  func formatHowManyStoresOnList(with howMany: Int) {
    howManyStoresLabel.text = String(format: howManyStoresLabel.text ?? "", howMany)
  }
}
