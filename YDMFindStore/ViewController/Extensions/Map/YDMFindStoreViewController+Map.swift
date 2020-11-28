//
//  YDMFindStoreViewController+Map.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit
import CoreLocation

extension YDMFindStoreViewController {
  func createMapGradient() {
    let gradient = CAGradientLayer()

    gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
    gradient.opacity = 0.75

    gradient.colors = [
      UIColor.black.withAlphaComponent(1).cgColor,
      UIColor.black.withAlphaComponent(0.7).cgColor,
      UIColor.black.withAlphaComponent(0.3).cgColor,
      UIColor.black.withAlphaComponent(0.0).cgColor
    ]
    gradient.locations = [0, 0.3, 0.6, 1]

    mapView?.layer.addSublayer(gradient)
  }

  func zoomToUsersLocation(_ coordinate: CLLocationCoordinate2D) {
    let regionRadius: CLLocationDistance = 200

    let viewRegion = MKCoordinateRegion(
      center: coordinate,
      latitudinalMeters: regionRadius * 2,
      longitudinalMeters: regionRadius * 2
    )

    mapView.setRegion(viewRegion, animated: false)
  }
}
