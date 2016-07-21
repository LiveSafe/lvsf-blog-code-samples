//
//  Router.swift
//  DINetworkingSample
//
//  Created by Nicholas Fox on 7/17/16.
//  Copyright © 2016 nickfox. All rights reserved.
//

import Foundation
import Alamofire

typealias APIParams = [String : AnyObject]

protocol APIRouter: URLRequestConvertible {
  var method: Alamofire.Method { get }
  var encoding: Alamofire.ParameterEncoding? { get }
  var path: String { get }
  var parameters: APIParams { get }
  var baseUrl: String { get }
}

extension APIRouter {

  var URLRequest: NSMutableURLRequest {

    let baseURL = NSURL(string: baseUrl)
    let mutableURLRequest = NSMutableURLRequest(URL: baseURL!.URLByAppendingPathComponent(path))
    mutableURLRequest.HTTPMethod = method.rawValue

    if let encoding = encoding {
      return encoding.encode(mutableURLRequest, parameters: parameters).0
    }
    return mutableURLRequest
  }

}

struct SampleRouter: APIRouter {
  var method: Alamofire.Method {
    return .GET
  }

  var encoding: Alamofire.ParameterEncoding? {
    return .URL
  }

  var path: String {
    return "/posts/1"
  }

  var parameters: APIParams {
    return APIParams()
  }

  var baseUrl: String {
    return "http://jsonplaceholder.typicode.com"
  }
}
