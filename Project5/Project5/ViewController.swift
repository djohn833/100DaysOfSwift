//
//  ViewController.swift
//  Project5
//
//  Created by Dave Johnson on 8/8/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  let wordCellIdentifier = "Word"

  var allWords: [String] = []
  var usedWords: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: wordCellIdentifier)

    if
      let url = Bundle.main.url(forResource: "start", withExtension: "txt"),
      let startWords = try? String(contentsOf: url) {
        allWords = startWords.components(separatedBy: "\n")
    }

    startGame()
  }

  @objc func startGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }

  func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()

    guard isPossible(word: lowerAnswer) else {
      guard let title = title?.lowercased() else {
        return
      }
      showError(title: "Word not possible", message: "You can't spell that word from \(title)")
      return
    }

    guard isOriginal(word: lowerAnswer) else {
      showError(title: "Word used already", message: "Be more original!")
      return
    }

    guard isReal(word: lowerAnswer) else {
      showError(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }

    usedWords.insert(lowerAnswer, at: 0)

    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  private func showError(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  private func isPossible(word: String) -> Bool {
    guard var targetWord = title?.lowercased() else {
      return false
    }

    for letter in word {
      if let position = targetWord.firstIndex(of: letter) {
        targetWord.remove(at: position)
      } else {
        return false
      }
    }

    return true
  }

  private func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
  }

  private func isReal(word: String) -> Bool {
    guard
      word.count >= 3,
      let targetWord = title?.lowercased(),
      word != targetWord else {
        return false
    }

    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
  }

  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
      guard let answer = ac?.textFields?[0].text else {
        return
      }
      self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
  }

  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: wordCellIdentifier, for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
}
