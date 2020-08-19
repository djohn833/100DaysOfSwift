//
//  ViewController.swift
//  Challenge1
//
//  Created by Dave Johnson on 8/7/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Flags"

//    tableView.separatorStyle = .none
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Flag")
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
    cell.textLabel?.text = countries[indexPath.row]
    cell.imageView?.image = UIImage(named: countries[indexPath.row])
//    cell.contentView.layoutMargins.top = 10.0
//    cell.contentView.layoutMargins.bottom = 10.0
    return cell
  }

  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = DetailViewController(selectedImage: countries[indexPath.row]) else {
      return
    }
    navigationController?.pushViewController(vc, animated: true)
  }
}

