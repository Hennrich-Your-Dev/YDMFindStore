//
//  YDMFindStoreViewController+Map.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit

extension YDMFindStoreViewController {

  func createMapGradient() {
    let gradient = CAGradientLayer()

    gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)

    gradient.colors = [
      UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
      UIColor.black.cgColor
    ]
    gradient.locations = [0, 1]
    gradient.startPoint = CGPoint(x: 0.5, y: 0.97)
    gradient.endPoint = CGPoint(x: 0.5, y: 0.32)

    mapView?.layer.addSublayer(gradient)
  }

}
