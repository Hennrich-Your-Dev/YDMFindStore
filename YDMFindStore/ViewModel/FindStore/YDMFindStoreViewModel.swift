//
//  YDMFindStoreViewModel.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit

import YDB2WIntegration
import YDUtilities
import YDExtensions
import YDB2WModels
import YDLocationModule

// MARK: Delegates
protocol YDMFindStoreNavigationDelegate {
  func onExit()
}

protocol YDMFindStoreViewModelDelegate {
  var location: Binder<YDLocationViewModel?> { get }

  func getPreviousAddress()

  // Buttons actions
  func onExit()
  func onList()
  func onGetLocation()
}

// MARK: View Model
class YDMFindStoreViewModel {
  // MARK: Properties
  lazy var logger = Logger.forClass(Self.self)
  let navigation: YDMFindStoreNavigationDelegate
  let service: YDMFindStoreServiceDelegate
  let geocoder: YDMFindStoreReverseGeocoderServiceDelegate

  var location: Binder<YDLocationViewModel?> = Binder(nil)

  private let locationManager = YDLocation.shared
  private var alreadyGetUsersPosition = false

  // MARK: Init
  init(
    navigation: YDMFindStoreNavigationDelegate,
    service: YDMFindStoreServiceDelegate,
    geocoder: YDMFindStoreReverseGeocoderServiceDelegate
  ) {
    self.navigation = navigation
    self.service = service
    self.geocoder = geocoder
  }
}

// MARK: Extension delegate
extension YDMFindStoreViewModel: YDMFindStoreViewModelDelegate {
  func getPreviousAddress() {
    YDIntegrationHelper.shared.getAddress { [weak self] currentAddress in
      guard let address = currentAddress,
            let coordinates = address.coordinates
      else {
        self?.location.fire()
        return
      }

      self?.searchForNewStore(
        with: coordinates,
        givingAddress: address.transformAddress,
        givingType: address.type
      )
    }
  }

  func onExit() {
    navigation.onExit()
  }

  func onList() {

  }

  func onGetLocation() {
    if locationManager.delegate == nil {
      locationManager.delegate = self
    }

    guard location.value?.address != nil,
          alreadyGetUsersPosition
    else {
      locationManager.start()
      alreadyGetUsersPosition = true
      return
    }

    callAddressModuleFromB2W()
  }
}
