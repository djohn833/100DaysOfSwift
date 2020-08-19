//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Dave Johnson on 8/7/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  private var image: UIImage
  private var assetName: String

  init?(selectedImage: String) {
    guard let aImage = UIImage(named: selectedImage) else {
      return nil
    }

    image = aImage
    assetName = selectedImage
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    image = UIImage()
    assetName = ""
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = assetName

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(imageView)

    let margins = view.layoutMarginsGuide

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
    ])
  }

  @objc func shareTapped() {
    let vc = UIActivityViewController(activityItems: ["\(assetName) flag", image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
}
