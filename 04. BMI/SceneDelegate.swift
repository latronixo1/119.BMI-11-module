//
// SceneDelegate.swift
// 1. Констрейнты на прим. BMI
//
// Created by MacBook on 08.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }  //создаем нашу сцену
        window = UIWindow(windowScene: windowScene) //инициализуем наш window с помощью windowScene
        window?.rootViewController = CalculateViewController()  //ставим ему рут наш ViewController
        window?.makeKeyAndVisible() // и делаем его видимым
    }
}
