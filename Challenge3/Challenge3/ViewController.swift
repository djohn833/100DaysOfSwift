//
//  ViewController.swift
//  Challenge3
//
//  Created by Dave Johnson on 8/15/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var promptLabel: UILabel!
  var letterButtons: [UIButton] = []

  let word = "RHYTHM"
  var usedLetters: [String] = [] {
    didSet {
      var promptWord = ""

      for letter in word {
        if usedLetters.contains(String(letter)) {
          promptWord.append(letter)
        } else {
          promptWord.append("?")
        }
      }

      print("promptWord: \(promptWord)")
      promptLabel.text = promptWord
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    promptLabel = UILabel()
    promptLabel.translatesAutoresizingMaskIntoConstraints = false
    promptLabel.font = .systemFont(ofSize: 44)
    view.addSubview(promptLabel)

    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(buttonsView)

    let safeArea = view.safeAreaLayoutGuide

    let width = 60
    let height = 40

    NSLayoutConstraint.activate([
      promptLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
      promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      promptLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonsView.topAnchor),
      buttonsView.widthAnchor.constraint(equalToConstant: CGFloat(5 * width)),
      buttonsView.heightAnchor.constraint(equalToConstant: CGFloat(6 * height)),
      buttonsView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
      buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])

    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXY  Z  "

    for (i, letter) in letters.enumerated() {
      if letter.isWhitespace {
        continue
      }

      let row = i / 5
      let col = i % 5
      let frame = CGRect(x: col * width, y: row * height, width: width, height: height)

      let letterButton = UIButton(type: .system)
      letterButton.frame = frame
      letterButton.titleLabel?.font = .systemFont(ofSize: 36)
      letterButton.setTitle(String(letter), for: .normal)
      letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
      buttonsView.addSubview(letterButton)
      letterButtons.append(letterButton)
    }
  }

  @objc func letterTapped(_ sender: UIButton) {
    guard let text = sender.titleLabel?.text else {
      return
    }

    if word.contains(text) && !usedLetters.contains(text) {
      usedLetters.append(text)
    }
  }
}

