//
//  SceneDelegate.swift
//  Project2
//
//  Created by Dave Johnson on 8/6/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let vc = ViewController()
    let nav = UINavigationController(rootViewController: vc)
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
  }
}

