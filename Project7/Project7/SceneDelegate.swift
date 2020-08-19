//
//  SceneDelegate.swift
//  Project7
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

    let vc1 = ViewController()
    let nav1 = UINavigationController(rootViewController: vc1)
    let vc2 = ViewController()
    let nav2 = UINavigationController(rootViewController: vc2)

    let tabBarVC = UITabBarController()
    nav1.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
    nav2.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarVC.viewControllers = [nav1, nav2]

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = tabBarVC
    window?.makeKeyAndVisible()
  }


}

