//
//  SceneDelegate.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = PokedexViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}
