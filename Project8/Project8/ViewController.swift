//
//  ViewController.swift
//  Project8
//
//  Created by Dave Johnson on 8/11/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var cluesLabel: UILabel!
  var answersLabel: UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons: [UIButton] = []

  var activatedButtons: [UIButton] = []
  var solutions: [String] = []
  var solutionsFound = 0
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  var level = 1

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
    view.addSubview(scoreLabel)

    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    cluesLabel.font = .systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    view.addSubview(cluesLabel)

    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    answersLabel.font = .systemFont(ofSize: 24)
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    answersLabel.textAlignment = .right
    view.addSubview(answersLabel)

    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Click letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = .systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
    view.addSubview(currentAnswer)

    let submit = UIButton(type: .system)
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
    submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    view.addSubview(submit)

    let clear = UIButton(type: .system)
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
    clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    view.addSubview(clear)

    let buttons = UIView()
    buttons.translatesAutoresizingMaskIntoConstraints = false
    buttons.layer.borderColor = UIColor.lightGray.cgColor
    buttons.layer.borderWidth = 1
    view.addSubview(buttons)

    let marginsGuide = view.layoutMarginsGuide
    let cluesIndent = CGFloat(100)
    let answersIndent = CGFloat(100)

    NSLayoutConstraint.activate([
      scoreLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      cluesLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: cluesIndent),
      cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -cluesIndent),
      cluesLabel.heightAnchor.constraint(equalTo: answersLabel.heightAnchor),
      answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      answersLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -answersIndent),
      answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -answersIndent),
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
      submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
      submit.heightAnchor.constraint(equalToConstant: 44),
      clear.topAnchor.constraint(equalTo: submit.topAnchor),
      clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
      clear.heightAnchor.constraint(equalToConstant: 44),
      buttons.widthAnchor.constraint(equalToConstant: 750),
      buttons.heightAnchor.constraint(equalToConstant: 320),
      buttons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttons.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
      buttons.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -20)
    ])

//    cluesLabel.backgroundColor = .red
//    answersLabel.backgroundColor = .blue
//    buttons.backgroundColor = .green

    let width = 150
    let height = 80

    for row in 0..<4 {
      for col in 0..<5 {
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)

        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = .systemFont(ofSize: 36)
        letterButton.setTitle("WWW", for: .normal)
        letterButton.frame = frame
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        buttons.addSubview(letterButton)
        letterButtons.append(letterButton)
      }
    }

    loadLevel()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func loadLevel() {
    DispatchQueue.global(qos: .userInitiated).async {
      var clueString = ""
      var solutionString = ""
      var letterBits: [String] = []

      guard
        let levelFileURL = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt"),
        let levelContents = try? String(contentsOf: levelFileURL)
        else {
          return
      }

      var lines = levelContents.components(separatedBy: "\n")
      lines.shuffle()

      for (i, line) in lines.enumerated() {
        let parts = line.components(separatedBy: ": ")
        if parts.count < 2 {
          continue
        }

        let answer = parts[0]
        let clue = parts[1]

        clueString += "\(i + 1). \(clue)\n"

        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
        solutionString += "\(solutionWord.count) letters\n"
        self.solutions.append(solutionWord)

        let bits = answer.components(separatedBy: "|")
        letterBits += bits
      }

      letterBits.shuffle()

      DispatchQueue.main.async {
        self.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        self.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        if letterBits.count == self.letterButtons.count {
          for i in 0..<self.letterButtons.count {
            UIView.performWithoutAnimation {
              self.letterButtons[i].setTitle(letterBits[i], for: .normal)
              self.letterButtons[i].isHidden = false
              self.letterButtons[i].layoutIfNeeded()
            }
          }
        }
      }
    }
  }

  func levelUp(_ action: UIAlertAction) {
    solutionsFound = 0
    solutions.removeAll(keepingCapacity: true)

    level += 1
    loadLevel()
  }

  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else {
      return
    }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
  }

  @objc func submitTapped(_ sender: UIButton) {
    defer {
      currentAnswer.text = ""
      activatedButtons.removeAll()
    }

    guard
      let answerText = currentAnswer.text,
      let solutionPosition = solutions.firstIndex(of: answerText)
      else {
        score -= 1
        activatedButtons.forEach { $0.isHidden = false }

        let ac = UIAlertController(title: "Wrong!", message: "Try again!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        return
    }

    var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
    splitAnswers?[solutionPosition] = answerText
    answersLabel.text = splitAnswers?.joined(separator: "\n")

    score += 1
    solutionsFound += 1

    if solutionsFound == 7 {
      let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
      present(ac, animated: true)
    }
  }

  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    activatedButtons.forEach { $0.isHidden = false }
    activatedButtons.removeAll()
  }
}

