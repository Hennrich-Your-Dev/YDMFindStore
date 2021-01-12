//
//  YDMFindStoreCoordinator.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import CoreLocation

import YDB2WIntegration
import YDExtensions
import YDUtilities

public typealias YDMFindStore = YDMFindStoreCoordinator

public class YDMFindStoreCoordinator {

  // Properties
  var rootViewController: UIViewController {
    return self.navigationController
  }

  lazy var navigationController: UINavigationController = {
    let nav = UINavigationController()
    nav.isNavigationBarHidden = true
    nav.modalPresentationStyle = .fullScreen
    return nav
  }()

  var findStoreViewModel: YDMFindStoreViewModelDelegate?

  // MARK: Init
  public init() {}

  // MARK: Actions
  public func start() {
    guard let viewController = YDMFindStorePreStartViewController.initializeFromStoryboard()
    else {
      fatalError("YDMFindStorePreStartViewController.initializeFromStoryboard")
    }
    
    let viewModel = YDMFindStorePreStartViewModel(navigation: self)
    viewController.viewModel = viewModel
    
    let topViewController = UIApplication.shared.keyWindow?
      .rootViewController?.topMostViewController()
    
    viewController.modalPresentationStyle = .overFullScreen
    viewController.modalTransitionStyle = .crossDissolve
    
    navigationController.viewControllers = [viewController]
    topViewController?.present(navigationController, animated: true, completion: nil)
  }
  
  func startFindStore(userLocation: CLLocationCoordinate2D) {
    guard let viewController = YDMFindStoreViewController.initializeFromStoryboard(),
          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.store.rawValue),
          let storesUrl = config.extras?[YDConfigProperty.storesUrl.rawValue] as? String,
          let addressUrl = config.extras?[YDConfigProperty.addressUrl.rawValue] as? String
    else {
      fatalError("YDMFindStoreViewController.initializeFromStoryboard")
    }

    let service = YDServiceClient()
    let serviceFindStore = YDMFindStoreService(service: service, storesUrl: storesUrl)

    let serviceReverseGeocoder = YDMFindStoreReverseGeocoderService(
      service: service,
      reverseGeocodeUrl: addressUrl
    )

    findStoreViewModel = YDMFindStoreViewModel(
      navigation: self,
      service: serviceFindStore,
      geocoder: serviceReverseGeocoder
    )
    viewController.viewModel = findStoreViewModel
    
    navigationController.pushViewController(viewController, animated: false)
  }
}

extension YDMFindStoreCoordinator: YDMFindStoreNavigationDelegate {

  func onExit() {
    rootViewController.dismiss(animated: true, completion: nil)
  }
}

// MARK: Pre Start Navigation Delegate
extension YDMFindStoreCoordinator: YDMFindStorePreStartNavigationDelegate {
  func openFindStore(with coords: CLLocationCoordinate2D) {
    startFindStore(userLocation: coords)
  }
}
