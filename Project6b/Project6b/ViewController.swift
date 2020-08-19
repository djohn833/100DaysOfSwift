//
//  ViewController.swift
//  Project6b
//
//  Created by Dave Johnson on 8/9/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let labels = [
      makeLabel(text: "THESE", color: .red),
      makeLabel(text: "ARE", color: .cyan),
      makeLabel(text: "SOME", color: .yellow),
      makeLabel(text: "AWESOME", color: .green),
      makeLabel(text: "LABELS", color: .orange)
    ]

    /*
    let metrics = ["labelHeight": 88]

    var views: [String: UILabel] = [:]

    for (i, label) in labels.enumerated() {
      view.addSubview(label)
      let labelName = "label\(i + 1)"
      views[labelName] = label
      view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(labelName)]|", options: [], metrics: metrics, views: views))
    }

    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: views))
    */

    for label in labels {
      view.addSubview(label)
    }

    let safeArea = view.safeAreaLayoutGuide

    var prevLabel: UILabel? = nil

    for label in labels {
      label.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
//      label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//      label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//      label.heightAnchor.constraint(equalTo: labels[0].heightAnchor).isActive = true
      label.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2, constant: -10).isActive = true

      if let prevLabel = prevLabel {
        label.topAnchor.constraint(equalTo: prevLabel.bottomAnchor, constant: 10).isActive = true
      } else {
//        labels[0].heightAnchor.constraint(equalToConstant: 88).withPriority(999).isActive = true
        labels[0].topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
      }

      prevLabel = label
    }

    labels[4].bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -10).isActive = true
  }

  private func makeLabel(text: String, color: UIColor) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.backgroundColor = color
    label.sizeToFit()
    return label
  }
}

extension NSLayoutConstraint {
  func withPriority(_ rawValue: Float) -> NSLayoutConstraint {
    self.priority = UILayoutPriority(rawValue)
    return self
  }
}
