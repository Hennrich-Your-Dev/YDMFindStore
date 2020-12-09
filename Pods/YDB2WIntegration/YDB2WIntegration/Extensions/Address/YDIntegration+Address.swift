//
//  YDIntegration+Address.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation
import CoreLocation

// MARK: Open address module
public extension YDIntegrationHelper {
  func onAddressModule(onCompletion: ((YDCurrentAddress?) -> Void)?) {
    presentationDelegate?.presentSelectAddress { [weak self] address in
      self?.currentAddres = address
      onCompletion?(address)
    }
  }
}

// MARK: Get address
public extension YDIntegrationHelper {
  func getAddress(completion: ((YDCurrentAddress?) -> Void)?) {
    if let address = self.currentAddres {
      completion?(address)
    } else {
      accountDelegate?.getAddress(completion: completion)
    }
  }
}

// MARK: Set new address
public extension YDIntegrationHelper {
  func setNewAddress(
    withCoords coords: CLLocationCoordinate2D,
    withAddress name: String,
    withType type: YDAddressType
  ) {
    currentAddres = YDCurrentAddress(
      type: type,
      address: name,
      latitude: coords.latitude,
      longitude: coords.longitude
    )
  }
}
