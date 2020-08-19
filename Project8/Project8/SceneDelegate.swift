//
//  SceneDelegate.swift
//  Project8
//
//  Created by Dave Johnson on 8/11/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else {
      return
    }

    let rootVC = ViewController()

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = rootVC
    window?.makeKeyAndVisible()
  }


}

