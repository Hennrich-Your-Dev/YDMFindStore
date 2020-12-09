//
//  CurrentAddress.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation
import CoreLocation

public struct YDCurrentAddress: Decodable {
  // MARK: Properties
  public var type: YDAddressType?

  public var postalCode: String?

  public let address: String?

  public let number: String?
  public let complement: String?

  public let neighborhood: String?
  public let city: String?
  public let state: String?

  public let longitude: Double?
  public let latitude: Double?

  // MARK: Computed variables
  public var transformAddress: String {
    guard var address = address else {
      return ""
    }

    if let number = number {
      address += ", \(number)"
    }

    if let complement = complement {
      address += ", \(complement)"
    }

    if let city = city {
      address += ", \(city)"
    }

    if let state = state {
      address += " - \(state)"
    }

    return address
  }

  public var coordinates: CLLocationCoordinate2D? {
    guard let lat = latitude,
          let lng = longitude
    else {
      return nil
    }

    return CLLocationCoordinate2D(latitude: lat, longitude: lng)
  }

  // MARK: Init
  public init(
    type: YDAddressType? = nil,
    postalCode: String? = nil,
    address: String? = nil,
    number: String? = nil,
    complement: String? = nil,
    city: String? = nil,
    state: String? = nil,
    neighborhood: String? = nil,
    latitude: Double? = nil,
    longitude: Double? = nil
  ) {
    self.type = type
    self.postalCode = postalCode
    self.address = address
    self.number = number
    self.complement = complement
    self.city = city
    self.state = state
    self.neighborhood = neighborhood
    self.latitude = latitude
    self.longitude = longitude
  }

  public init(savedAddress: [String: String]) {
    if let type = savedAddress["type"] {
      switch type {
      case YDAddressType.location.rawValue:
        self.type = .location
      case YDAddressType.search.rawValue:
        self.type = .search
      case YDAddressType.customer.rawValue:
        self.type = .customer
      default:
        self.type = .unknown
      }
    } else {
      self.type = .unknown
    }

    self.postalCode = savedAddress["cep"]

    self.address = savedAddress["text"]

    if let latitudeString = savedAddress["latitude"], let latitude = Double(latitudeString),
       let longitudeString = savedAddress["longitude"], let longitude = Double(longitudeString) {
      self.latitude = latitude
      self.longitude = longitude

      //
    } else {
      self.latitude = nil
      self.longitude = nil
    }

    self.city = savedAddress["city"]
    self.state = savedAddress["state"]

    self.number = nil
    self.complement = nil
    self.neighborhood = nil
  }
}
