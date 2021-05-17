//
//  YDMFindStoreViewController+Binds.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 10/12/20.
//

import UIKit
import CoreLocation

import YDUtilities
import YDExtensions

extension YDMFindStoreViewController {
  func setUpBinds() {
    viewModel?.loading.bind { [weak self] isLoading in
      guard let self = self else { return }

      if isLoading {
        self.showErrorView(hide: true)
      }
    }

    viewModel?.error.bind { [weak self] _ in
      guard let self = self else { return }
      self.showErrorView(hide: false)
    }

    viewModel?.location.bind { [weak self] location in
      self?.locationActivity(show: false)

      guard let self = self,
        let location = location
        else { return }

      if let address = location.address,
        !address.isEmpty {
        self.locationButton.setTitle(address, for: .normal)
      }

      if let store = location.store,
         let latitude = store.geolocation?.latitude,
         let longitude = store.geolocation?.longitude {

        let userCoords = self.mapView.userLocation.coordinate
        let nearstStoreCoords = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        self.setMapCenterBetween(positionA: userCoords, positionB: nearstStoreCoords)
      } else if let coords = location.location {
        self.zoomToPosition(coords)
      }
    }

    viewModel?.stores.bind { [weak self] stores in
      guard let self = self else { return }

      DispatchQueue.main.async {
        self.storesListContainer.isHidden = false
        self.myLocationButton.isHidden = false
        self.addPinsOnMap(with: stores)
        self.collectionView.reloadData()
        self.verticalCollectionView.reloadData()
        self.collectionView.scrollToItem(
          at: IndexPath(row: 0, section: 0),
          at: .centeredHorizontally,
          animated: true
        )
        self.formatHowManyStoresOnList(with: stores.count)
      }
    }
  }
}
