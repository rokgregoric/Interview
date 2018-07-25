//
//  Cell.swift
//  Interview
//
//  Created by Rok Gregoric on 25/07/2018.
//  Copyright © 2018 Py. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var separator1: UIView!
  @IBOutlet weak var separator2: UIView!

  class var identifier: String {
    return String(describing: self)
  }

  class func dequeueReusableCell(for indexPath: IndexPath, in tableView: UITableView) -> Cell {
    return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
  }
}
