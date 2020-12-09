//
//  YDMFindStoreViewModel.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit

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

  func onExit()
  func onList()
}

// MARK: View Model
class YDMFindStoreViewModel {
  // MARK: Properties
  lazy var logger = Logger.forClass(Self.self)
  let navigation: YDMFindStoreNavigationDelegate
  let service: YDMFindStoreServiceDelegate
  let geocoder: YDMFindStoreReverseGeocoderServiceDelegate

  var location: Binder<YDLocationViewModel?> = Binder(nil)

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
  func onExit() {
    navigation.onExit()
  }

  func onList() {

  }
}
