//
//  AddressTypeEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum YDAddressType: String, CaseIterable, Decodable {
  case search = "SEARCH_CEP"
  case location = "GPS"
  case customer = "CUSTOMER_ADDRESS"

  case unknown = "UNKNOWN"
}
