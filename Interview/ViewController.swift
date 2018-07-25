//
//  ViewController.swift
//  Interview
//
//  Created by Rok Gregoric on 25/07/2018.
//  Copyright © 2018 Py. All rights reserved.
//

import UIKit
import SwifterJSON
import AlamofireImage

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  var landscapes = [JSON]()

  override func viewDidLoad() {
    super.viewDidLoad()
    loadLandscapes()
    fetchData()
  }

  func fetchData() {
    APIClient.perform(.landscapes) {
      self.landscapes = $0?.array ?? []
      self.persistLandscapes()
      self.tableView.reloadData()
    }
  }

  func loadLandscapes() {
    guard let objs: [[String: Any]] = Defaults.object(for: .landscapes) else { return }
    landscapes = objs.map { JSON($0) }
    tableView.reloadData()
  }

  func persistLandscapes() {
    let objs = landscapes.compactMap { $0.dictionaryObject }
    Defaults.set(object: objs, for: .landscapes)
  }

  @IBAction func newLandscape() {
    let title = "New Landscape"
    let subtitle = "Description of a new landscape"
    let url = "http://republika24.info/wp-content/uploads/2017/05/4573432-green-tree-wallpapers.jpg"

    APIClient.perform(.createLandscape(title, subtitle, url)) {
      if $0 == nil { return }
      self.landscapes.insert(JSON([
        "title": title,
        "subtitle": subtitle,
        "image_url": url,
      ]), at: 0)
      self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
  }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return landscapes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = Cell.dequeueReusableCell(for: indexPath, in: tableView)
    let json = landscapes[indexPath.row]
    cell.titleLabel.text = json["title"].string
    cell.subtitleLabel.text = json["subtitle"].string
    cell.imgView.set(imageURL: json["image_url"].url)
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if UIScreen.main.bounds.width < 350 { return 80 }
    if UIScreen.main.bounds.width < 500 { return 100 }
    return 150
  }
}

