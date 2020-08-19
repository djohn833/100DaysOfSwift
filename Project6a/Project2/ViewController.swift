//
//  ViewController.swift
//  Project2
//
//  Created by Dave Johnson on 8/6/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var button1: UIButton!
  var button2: UIButton!
  var button3: UIButton!

  var countries: [String] = []
  var score = 0
  var correctAnswer = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    button1 = makeFlagButton(tag: 0)
    button2 = makeFlagButton(tag: 1)
    button3 = makeFlagButton(tag: 2)

    view.addSubview(button1)
    view.addSubview(button2)
    view.addSubview(button3)

    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      // Positioning
      button1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
      button1.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

      button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 30),
      button2.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

      button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 30),
      button3.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
      button3.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20),

      // Aspect ratio
      button1.widthAnchor.constraint(equalTo: button1.heightAnchor, multiplier: 2),
      button2.widthAnchor.constraint(equalTo: button2.heightAnchor, multiplier: 2),
      button3.widthAnchor.constraint(equalTo: button3.heightAnchor, multiplier: 2),

      // Same height
      button1.heightAnchor.constraint(equalTo: button2.heightAnchor),
      button2.heightAnchor.constraint(equalTo: button3.heightAnchor)
    ])

    countries.append("estonia")
    countries.append("france")
    countries.append("germany")
    countries.append("ireland")
    countries.append("italy")
    countries.append("monaco")
    countries.append("nigeria")
    countries.append("poland")
    countries.append("russia")
    countries.append("spain")
    countries.append("uk")
    countries.append("us")

    askQuestion()
  }

  func askQuestion() {
    countries.shuffle()
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    correctAnswer = Int.random(in: 0...2)
    title = "\(countries[correctAnswer].uppercased()) (\(score))"
  }

  func makeFlagButton(tag: Int) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.contentMode = .scaleAspectFit
//    button.setTitle("Button", for: .normal)
//    button.setTitleColor(.systemBlue, for: .normal)
    button.tag = tag
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    return button
  }

  @objc func buttonTapped(_ sender: UIButton) {
    var title: String

    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong! That's \(countries[sender.tag].uppercased())"
      score -= 1
    }

    let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default) { _ in
      self.askQuestion()
    })
    present(ac, animated: true)
  }
}

