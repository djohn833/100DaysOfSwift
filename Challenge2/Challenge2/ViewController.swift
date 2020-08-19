//
//  ViewController.swift
//  Challenge2
//
//  Created by Dave Johnson on 8/11/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  let shoppingItemIdentifier = "ShoppingItem"
  var shoppingList: [String] = []

  var shareButton: UIBarButtonItem!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))

    shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))

    toolbarItems = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      shareButton
    ]
    navigationController?.isToolbarHidden = false

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: shoppingItemIdentifier)
  }

  @objc private func clearList() {
    shoppingList.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }

  @objc private func addItem() {
    let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
    ac.addTextField()
    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
      guard
        let itemName = ac?.textFields?[0].text,
        let self = self
        else {
          return
      }

      let indexPath = IndexPath(row: self.shoppingList.endIndex, section: 0)
      self.shoppingList.append(itemName)
      self.tableView.insertRows(at: [indexPath], with: .automatic)
    })
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }

  @objc func shareList() {
    let list = shoppingList.joined(separator: "\n")
    let vc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
    vc.popoverPresentationController?.barButtonItem = shareButton
    present(vc, animated: true)
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: shoppingItemIdentifier, for: indexPath)
    cell.textLabel?.text = shoppingList[indexPath.row]
    return cell
  }
}

