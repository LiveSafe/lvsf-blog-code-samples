//
//  APIManager.swift
//  DINetworkingSample
//
//  Created by Nicholas Fox on 7/17/16.
//  Copyright © 2016 nickfox. All rights reserved.
//

import Foundation

protocol APIManager {
  /// Proxy that is responsible for making the actual API call
  var proxy: APIProxy { get }
}

struct LiveAPIManager: APIManager {
  var proxy: APIProxy = AlamofireProxyImplementation()
}

struct TestAPIManager: APIManager {

  var proxy: APIProxy = MockProxyImplementation(condition: .Success)

  /**
   INitializer that lets the user control the condition under test.

   -parameter testCondition: The status of the network to use for the API call.
  */
  init(testCondition: APITestStatus) {
    proxy = MockProxyImplementation(condition: testCondition)
  }
}



// MARK: Here is sample implementation of a particular API call.
extension APIManager {

  func sampleCall(completion:(response: APIResponse) -> ()) {
    let router = SampleRouter()
    proxy.makeCall(router) { (response) in
      completion(response: response)
    }
  }
}
