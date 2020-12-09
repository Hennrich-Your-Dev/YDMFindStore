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
    let gradientTop = CAGradientLayer()

    gradientTop.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
    gradientTop.opacity = 0.75

    gradientTop.colors = [
      UIColor.black.withAlphaComponent(1).cgColor,
      UIColor.black.withAlphaComponent(0.7).cgColor,
      UIColor.black.withAlphaComponent(0.3).cgColor,
      UIColor.black.withAlphaComponent(0.0).cgColor
    ]
    gradientTop.locations = [0, 0.3, 0.6, 1]

    let height = view.frame.height / 5

    let gradientBottom = CAGradientLayer()
    gradientBottom.frame = CGRect(
      x: 0,
      y: view.frame.maxY - height,
      width: view.frame.width,
      height: height
    )
    gradientBottom.opacity = 0.75

    gradientBottom.colors = [
      UIColor.black.withAlphaComponent(0).cgColor,
      UIColor.black.withAlphaComponent(0.1).cgColor,
      UIColor.black.withAlphaComponent(0.5).cgColor,
      UIColor.black.withAlphaComponent(1).cgColor
    ]
    gradientBottom.locations = [0, 0.3, 0.6, 1]

    mapView?.layer.addSublayer(gradientTop)
    mapView?.layer.addSublayer(gradientBottom)
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
