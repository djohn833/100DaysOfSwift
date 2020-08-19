//
//  DetailViewController.swift
//  Project1
//
//  Created by Dave Johnson on 8/5/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var imageView: UIImageView!
  var selectedImage: String?
  var pictureNumber: Int?
  var totalPictures: Int?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = selectedImage

    if
      let pictureNumber = pictureNumber,
      let totalPictures = totalPictures {
        title = "Picture \(pictureNumber) of \(totalPictures)"
    }

    if let selectedImage = selectedImage {
      let image = UIImage(named: selectedImage)
      imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(imageView)

      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
        imageView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor)
      ])
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
}
