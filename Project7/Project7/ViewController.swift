//
//  ViewController.swift
//  Project7
//
//  Created by Dave Johnson on 8/11/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var allPetitions: [Petition] = []
  var petitions: [Petition] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterPetitions))

    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
        // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }

    guard
      let url = URL(string: urlString),
      let data = try? Data(contentsOf: url)
      else {
        showError()
        return
    }

    parse(json: data)
  }

  func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      allPetitions = jsonPetitions.results
      petitions = allPetitions
      tableView.reloadData()
    }
  }

  func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  @objc func filterPetitions() {
    let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
    ac.addTextField() { textField in
      textField.placeholder = "Search"
    }
    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] alert in
      guard
        let text = ac?.textFields?[0].text,
        let self = self
        else {
          return
      }

      self.petitions = self.allPetitions.filter { $0.title.contains(text) }
      self.tableView.reloadData()
    })
    present(ac, animated: true)
  }

  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let petition = petitions[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? makeCell()
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }

  fileprivate func makeCell() -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

