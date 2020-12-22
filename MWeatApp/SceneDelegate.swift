//
//  SceneDelegate.swift
//  MWeatApp
//
//  Created by mahir ekici -- on 16/05/20.
//  .
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()
        let searchRouter = HomeRouter(navigation: navigation)
        navigation.viewControllers = [searchRouter.makeViewController()]
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
 
}
