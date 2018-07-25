//
//  APIClient.swift
//  Interview
//
//  Created by Rok Gregoric on 25/07/2018.
//  Copyright © 2018 Py. All rights reserved.
//

import Foundation
import Alamofire
import SwifterJSON

class APIClient {
  static let session = Alamofire.SessionManager.default

  static func perform(_ api: APIRequest, completion: @escaping (JSON?) -> Void) {
    session.request(api.url, method: api.method, parameters: api.params, encoding: api.encoding, headers: api.headers).log().validate().responseJSON(queue: .global(qos: .userInteractive)) { response in
      func complete(_ json: JSON?) {
        print(api.method.rawValue, api.url, api.params.map { JSON($0) }, response.response.map { "code: \($0.statusCode)" }, json.map { "json:\n\($0)" } ?? response.data?.utf8string?.nilIfEmpty.map { "payload: \($0)" })
        DispatchQueue.main.async { completion(json) }
      }
      switch response.result {
        case .success(let value): complete(JSON(value))
        case .failure(let error as NSError): complete(nil); print("error:", error)
      }
    }
  }
}

// MARK: - Debug Logging

extension Request {
  func log() -> Self {
    #if DEBUG
    debugPrint(self)
    #endif
    return self
  }
}
