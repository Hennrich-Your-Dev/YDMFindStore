//
//  YDMFindStoreCoordinator.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import YDIntegration
import YDExtensions

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
  public func start(navCon: UINavigationController? = nil) {
    guard let viewController = YDMFindStoreViewController.initializeFromStoryboard()
//          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.store.rawValue),
//          let addressUrl = config.extras?[YDConfigProperty.addressUrl.rawValue] as? String,
//          let npsEnabled = config.extras?[YDConfigProperty.storeNPSEnabled.rawValue] as? Bool
    else {
      fatalError("YDMFindStoreViewController.initializeFromStoryboard")
    }

    let topViewController = UIApplication.shared.keyWindow?
      .rootViewController?.topMostViewController()

//    let service = YDMServiceClient()
//    let serviceHome = YDMHomeService(service: service)

//    let serviceReverseGeocoder = YDMReverseGeocoderService(
//      service: service,
//      reverseGeocodeUrl: addressUrl
//    )

    findStoreViewModel = YDMFindStoreViewModel()
    viewController.viewModel = findStoreViewModel

    if let nav = navCon {
      navigationController = nav
      navigationController.pushViewController(viewController, animated: true)

    } else {
      navigationController.viewControllers = [viewController]
      topViewController?.present(navigationController, animated: true)
    }
  }
}

//extension YDMFindStoreCoordinator: YDMHomeNavigationDelegate {
//
//  func exit() {
//    rootViewController.dismiss(animated: true, completion: nil)
//  }
//
//  func openRating() {
//    guard let viewController = YDMRatingViewController.initializeFromStoryboard() else {
//      fatalError("YDMRatingViewController.initializeFromStoryboard")
//    }
//
//    viewController.hero.isEnabled = true
//    viewController.hero.modalAnimationType = .fade
//    viewController.viewModel = rateViewModel
//
//    navigationController.pushViewController(viewController, animated: true)
//  }
//}
