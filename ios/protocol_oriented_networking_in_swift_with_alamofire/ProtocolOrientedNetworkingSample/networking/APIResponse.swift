//
//  APIResponse.swift
//  DINetworkingSample
//
//  Created by Nicholas Fox on 7/17/16.
//  Copyright © 2016 nickfox. All rights reserved.
//

import Foundation
import Alamofire

struct APIResponse {

  var statusCode: Int = 200
  var errorMessage: String?
  var json: AnyObject?


  init(status: Int = 200,
       error: String? = nil,
       data: AnyObject? = nil ) {
    statusCode = status
    errorMessage = error
    json = data
  }
}

// MARK: Add an initializer for Alamofire's Response object type
extension APIResponse {
  /**
   Convenience initializer for use with Alamofire Response objects

   - parameter response: Alamofire response object to map to APIResponse object
   */
  init(response: Response<AnyObject, NSError>) {

    if let value = response.result.value {
      json = value
    }

    // Check if an error occurred and initialize the errorMessage property.
    if let error = response.result.error {
      errorMessage = error.description
      statusCode = 400
    }

    if let code =  response.response?.statusCode {
      statusCode = code
    }

  }
}
