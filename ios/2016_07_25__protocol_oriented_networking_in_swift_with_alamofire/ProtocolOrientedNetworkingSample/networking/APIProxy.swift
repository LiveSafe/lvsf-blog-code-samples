//
//  APIProxy.swift
//  DINetworkingSample
//
//  Created by Nicholas Fox on 7/17/16.
//  Copyright © 2016 nickfox. All rights reserved.
//

import Foundation
import Alamofire

protocol APIProxy {
  /**
   A method which will make an API call

   -parameter router: The APIRouter object containing the details of the call to be made
   - parameter completion: The closure to be called when the API call completes. This will be executed asynchronously.
  */
  func makeCall(router: APIRouter, completion: (response: APIResponse) -> ()) -> APIRequest
}

/// Implementation of APIProxy specific to Alamofire
struct AlamofireProxyImplementation: APIProxy {

  let manager = Alamofire.Manager.sharedInstance

  func makeCall(router: APIRouter, completion: (response: APIResponse) -> ()) -> APIRequest {

    let request =  manager.request(router).responseJSON { response in
      print(response.debugDescription)
      let wrappedResponse = APIResponse(response: response)
      completion(response: wrappedResponse)
    }
    debugPrint(request)

    return APIRequest(request: request)
  }
}

/// API test scenarios
enum APITestStatus {
  case Success
  case InvalidPermissions
  case TimeOut
  case NoNetwork
}

/// Mock implementation of APIProxy for use in testing
class MockProxyImplementation: APIProxy {

  /// The state of the simulated network connection.
  var state: APITestStatus = .Success

  init(condition: APITestStatus) {
    state = condition
  }

  func makeCall(router: APIRouter, completion: (response: APIResponse) -> ()) -> APIRequest {
    return getProxyResponse(router, completion: completion)
  }

  private func getProxyResponse(router: APIRouter, completion: (response: APIResponse) -> ()) -> APIRequest {

    // Here you should switch on self.state and the router to create the specific response object
    let mockResponse: APIResponse = {
      switch router {
      case is SampleRouter:
        return getMockResponseForSampleRouter()
      default:
        return APIResponse()
      }
    }()

    completion(response: mockResponse)
    let mockRequest = MockRequest(router: router)
    return APIRequest(request: mockRequest)
  }
}

extension MockProxyImplementation {

  func getMockResponseForSampleRouter() -> APIResponse {

    let mockResponse: APIResponse = {
      switch state {
      case .Success:
        let json = JSONFileReader.getJSONNamed("mockResponse")
        return APIResponse(status: 200, error: nil, data: json)
      default:
        return APIResponse(status: 400, error: "Some Error", data: nil)
      }
    }()

    return mockResponse
  }
}
