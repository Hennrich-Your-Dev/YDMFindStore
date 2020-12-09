//
//  YDMFindStoreViewModel+Location.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation
import CoreLocation

import YDB2WIntegration
import YDLocationModule
import YDB2WModels

extension YDMFindStoreViewModel {

  func callAddressModuleFromB2W() {
    YDIntegrationHelper.shared.onAddressModule { [weak self] addressComponentOpt in
      guard let addressComponent = addressComponentOpt,
            let coordinates = addressComponent.coordinates
      else {
        self?.location.fire()
        return
      }

      let address = addressComponent.transformAddress
      let type = addressComponent.type

      self?.searchForNewStore(
        with: coordinates,
        givingAddress: address,
        givingType: type
      )
    }
  }

  func searchForNewStore(
    with location: CLLocationCoordinate2D,
    givingAddress address: String? = nil,
    givingType type: YDAddressType? = .unknown
  ) {
    service.getNearstLasas(with: location) { [weak self] (response: Result<[YDStore], Error>) in
      switch response {
      case .success(let stores):
        var currentAddress = address

        if let storeAddress = stores.first?.formatAddress {
          currentAddress = storeAddress
        }

        self?.location.value = YDLocationViewModel(
          address: currentAddress ?? "",
          location: location,
          store: stores.first
        )

      case .failure(let error):
        self?.location.fire()
        self?.logger.error(error.localizedDescription)
      }
    }
  }
}

// MARK: YDLocation delegate
extension YDMFindStoreViewModel: YDLocationDelegate {

  public func permissionDenied() {
    print(#function)

    location.fire()
  }

  public func locationError(_ error: Error) {
    print(#function, error.localizedDescription)
    location.fire()
  }

  public func onLocation(_ location: CLLocation) {
    geocoder.getAddress(with: location.coordinate) { [weak self] result in
      switch result {
      case .success(let address):
        self?.searchForNewStore(
          with: location.coordinate,
          givingAddress: address.formatAddress,
          givingType: .location
        )

        YDIntegrationHelper.shared.setNewAddress(
          withCoords: location.coordinate,
          withAddress: address.formatAddress,
          withType: .location
        )

      case .failure(let error):
        self?.logger.error(error.localizedDescription)
        self?.location.fire()
      }
    }
  }
}