//
//  YDMFindStoreViewController+Binds.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 10/12/20.
//

import UIKit

import YDUtilities
import YDExtensions

extension YDMFindStoreViewController {
  func setUpBinds() {

//    viewModel?.loading.bind { [weak self] isLoading in
//      isLoading ? self?.view.startLoader() : self?.view.stopLoader()
//    }

    viewModel?.location.bind { [weak self] location in
      self?.locationActivity(show: false)

      guard let self = self,
        let location = location
        else { return }

      if let coords = location.location {
        self.zoomToUsersLocation(coords)
      }

      if let address = location.address,
        !address.isEmpty {
        self.locationButton.setTitle(address, for: .normal)
      }

      if let store = location.store {
        self.fetchDirection(to: store)
      }
    }

    viewModel?.stores.bind { [weak self] stores in
      self?.addPinsOnMap(with: stores)
    }
  }
}
