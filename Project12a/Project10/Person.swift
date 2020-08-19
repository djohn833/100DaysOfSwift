//
//  Person.swift
//  Project10
//
//  Created by Dave Johnson on 8/16/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
  var name: String
  var image: String

  init(name: String, image: String) {
    self.name = name
    self.image = image
  }

  required init?(coder: NSCoder) {
    name = coder.decodeObject(forKey: "name") as? String ?? ""
    image = coder.decodeObject(forKey: "image") as? String ?? ""
  }

  func encode(with coder: NSCoder) {
    coder.encode(name, forKey: "name")
    coder.encode(image, forKey: "image")
  }
}
