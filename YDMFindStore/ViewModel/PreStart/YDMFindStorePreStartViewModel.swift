//
//  YDMFindStorePreStartViewModel.swift
//  YDMFindStore
//
//  Created by Douglas on 10/01/21.
//

import Foundation
import CoreLocation

import YDUtilities
import YDLocationModule

// MARK: Navigation Delegate
protocol YDMFindStorePreStartNavigationDelegate {
  func openFindStore()
}

// MARK: Delegate
protocol YDMFindStorePreStartViewModelDelegate {
  var showPermission: Binder<Bool> { get }
  
  func getCurrentLocation()
  func openButtonAction()
}

class YDMFindStorePreStartViewModel {
  // MARK: Properties
  lazy var logger = Logger.forClass(Self.self)
  private let locationManager = YDLocation.shared
  let navigation: YDMFindStorePreStartNavigationDelegate
  
  var showPermission: Binder<Bool> = Binder(false)
  
  // MARK: Init
  init(navigation: YDMFindStorePreStartNavigationDelegate) {
    self.navigation = navigation
  }
}

// MARK: extend delegate
extension YDMFindStorePreStartViewModel: YDMFindStorePreStartViewModelDelegate {
  func getCurrentLocation() {
    locationManager.delegate = nil
    locationManager.delegate = self
    
    if locationManager.getStatus() == .denied || locationManager.getStatus() == .notDetermined {
      showPermission.value = true
      
    } else {
      locationManager.start()
    }
  }
  
  func openButtonAction() {
    if locationManager.getStatus() == .denied {
      UIApplication.shared.open(
        URL(
          string: UIApplication.openSettingsURLString)!,
          options: [:],
        completionHandler: nil)
    } else {
      locationManager.start()
    }
  }
}

// MARK: YDLocation delegate
extension YDMFindStorePreStartViewModel: YDLocationDelegate {

  public func permissionDenied() {
    print(#function)
    showPermission.value = true
  }

  public func locationError(_ error: Error) {
    print(#function, error.localizedDescription)
    showPermission.value = true
  }
  
  func onStatusChange(_ status: CLAuthorizationStatus) {
    //
    // print("[YDLocation] status changed")
    
    if status == .notDetermined {
      showPermission.value = true
    } else if status == .authorizedWhenInUse {
      showPermission.value = false
    }
  }

  public func onLocation(_ location: CLLocation) {
    self.navigation.openFindStore()
  }
}
