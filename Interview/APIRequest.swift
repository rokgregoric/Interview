//
//  APIRequest.swift
//  Interview
//
//  Created by Rok Gregoric on 25/07/2018.
//  Copyright © 2018 Py. All rights reserved.
//

import Foundation
import Alamofire

enum APIRequest {
  case landscapes
  case createLandscape(String, String, String)

  var path: String {
    switch self {
      case .landscapes: return "/landscapes"
      case .createLandscape: return "/landscapes"
    }
  }

  var params: [String: Any]? {
    switch self {
      case .createLandscape(let title, let subtitle, let url): return [
        "title": title,
        "subtitle": subtitle,
        "image_url": url
      ]
      default: return nil
    }
  }

  var method: HTTPMethod {
    switch self {
      case .createLandscape: return .post
      default: return .get
    }
  }

  var encoding: ParameterEncoding {
    return method == .get ? URLEncoding.default : JSONEncoding.default
  }

  var headers: [String: String] {
    return [
      "Content-Type": "application/json",
      "JsonStub-User-Key": "3e312d42-f253-42ff-85f7-7711aae4b633",
      "JsonStub-Project-Key": "b1aed14b-1256-4e19-ae80-72f735e9362a",
    ]
  }

  var basePath: String {
    return "http://jsonstub.com"
  }

  var urlString: String {
    return basePath + path
  }

  var url: URL {
    return urlString.url!
  }
}
