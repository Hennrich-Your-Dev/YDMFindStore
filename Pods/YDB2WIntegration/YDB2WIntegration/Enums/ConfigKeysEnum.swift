//
//  ConfigKeysEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum YDConfigKeys: String {
  case store = "ydevO2O"
  case live = "ydevLive"

  case restQL = "restQLService"
  case chatService = "userChatService"
  case productService = "catalog_service"
  case storeService = "store_service"
  case spaceyService = "spacey_service"
  case addressService = "address_service"
}

public enum YDConfigProperty: String {
  // Search stores
  case maxStoreRange = "acheUmaLojaFeatureNearbyStores"
  case insideLasaDistance = "distanceUserLasaStore"

  // Store Mode
  case npsEnabled
  case productsQueryVersion = "lasaB2WProductsQueryVersion"

  // Live
  case liveSpaceyOrder = "spaceyPositionIndex"

  case liveYouTubePlayerAutoStart
  case liveYouTubePlayerResetVideoWhenPaused
  case liveYouTubePlayerEnableFullScreenButton

  case liveChatId = "liveHotsite"
  case liveChatEnabled = "chatEnabled"
  case liveChatLikesEnabled = "chatLikesEnabled"
  case liveChatPolling = "liveChatPolling"
  case liveChatLimit
}

//public enum YDConfigProperty: String {
//  // Search stores
//  case maxStoreRange = "acheUmaLojaFeatureNearbyStores"
//  case storesType
//  case storesUrl
//  case storeModeProducts
//
//  // Search products
//  case productsUrl
//  case customerId
//
//  // Search address
//  case addressUrl
//
//  // API
//  case endpoint
//
//  // Store
//  case storeNPSEnabled = "npsEnabled"
//  case storeNPSFeedbackMessage = "npsFeedbackMessage"
//
//  // Live
//  case liveHotsiteUrl
//  case liveProductsUrl
//
//  case liveSpaceyOrder
//  case liveChatPoolling
//  case liveChatLimit
//  case liveChatOffset
//  case liveChatEnabled = "chatEnabled"
//
//  case liveChatGetMessagesUrl = "b2wChatApiURl"
//  case liveChatSendMessageUrl
//  case liveChatLikeUrl
//  case liveChatSendDelay
//
//  case liveChatLikeButtonEnabled = "chatLikesEnabled"
//}
