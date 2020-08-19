//
//  ViewController.swift
//  Project1
//
//  Created by Dave Johnson on 8/5/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")

    title = "Storm Viewer"

    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }

    pictures.sort()
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    guard let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController else {
//      return
//    }

    let vc = DetailViewController()
    vc.selectedImage = pictures[indexPath.row]
    vc.pictureNumber = indexPath.row + 1
    vc.totalPictures = pictures.count
    navigationController?.pushViewController(vc, animated: true)
  }
}

