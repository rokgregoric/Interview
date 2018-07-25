//
//  Extensions.swift
//  Interview
//
//  Created by Rok Gregoric on 25/07/2018.
//  Copyright © 2018 Py. All rights reserved.
//

import Foundation
import AlamofireImage

extension String {
  var url: URL? {
    return URL(string: self)
  }

  var nilIfEmpty: String? {
    return isEmpty ? nil : self
  }
}

extension Data {
  var utf8string: String? {
    return String(data: self, encoding: .utf8)
  }
}

extension UIImageView {
  func set(imageURL url: URL?) {
    image = nil
    let filter = AspectScaledToFillSizeFilter(size: self.frame.size)
    af_setImage(withURL: url ?? "http://".url!, filter: filter)
  }
}

extension Defaults.Key {
  static let landscapes = Defaults.Key("landscapes")
}

