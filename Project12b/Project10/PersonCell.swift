//
//  PersonCell.swift
//  Project10
//
//  Created by Dave Johnson on 8/16/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
  let imageView: UIImageView
  let name: UILabel

  override init(frame: CGRect) {
    imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 120, height: 120))
    imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    imageView.layer.borderWidth = 2
    imageView.layer.cornerRadius = 3

    name = UILabel(frame: CGRect(x: 10, y: 134, width: 120, height: 40))
    name.font = .systemFont(ofSize: 16, weight: .thin)
    name.textAlignment = .center
    name.numberOfLines = 2

    super.init(frame: frame)

    layer.cornerRadius = 7
    contentView.backgroundColor = .white
    contentView.addSubview(imageView)
    contentView.addSubview(name)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
