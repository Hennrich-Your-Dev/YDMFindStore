//
//  YDAddress.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 08/12/20.
//

import UIKit
import CoreLocation

public class YDAddress: Decodable {
  public let address: String?
  public let number: String?
  public let complement: String?
  public let neighborhood: String?
  public let city: String?
  public let state: String?

  public let longitude: Double?
  public let latitude: Double?

  // MARK: Computed variables
  public var formatAddress: String {
    guard let addressString = self.address
      else { return "" }

    var format: String = addressString

    if let number = self.number,
      !number.isEmpty {
      format += ", \(number)"
    }

    if let city = self.city,
      !city.isEmpty {
      format += " - \(city)"
    }

    return format
  }

  public var coords: CLLocationCoordinate2D? {
    guard let latitude = latitude,
          let longitude = longitude
    else {
      return nil
    }

    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
