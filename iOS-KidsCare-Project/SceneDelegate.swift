//
//  SceneDelegate.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // if user is logged in before
        let loggedEmail = UserDefaults.standard.string(forKey: "email")
        let loggedType = UserDefaults.standard.string(forKey: "type")
        let loggedUid = UserDefaults.standard.string(forKey: "userid")
        
        //print("==============", loggedUid!)
        if loggedUid != nil {
            DefaultData.user.ditinit(id: loggedUid!, completion: { print("getting the user")})
        }
        
        if  (loggedEmail != nil) && loggedType=="teacher"{
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTeachTabBarController")
            window?.rootViewController = mainTabBarController
            
        } else if (loggedEmail != nil) && loggedType=="parent" {
            
            let mainParentTabBarController = storyboard.instantiateViewController(identifier: "MainParentTabBarController")
            window?.rootViewController = mainParentTabBarController
            
        } else {
            // if user isn't logged in
            // instantiate the navigation controller and set it as root view controller
            // using the storyboard identifier we set earlier
            let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            window?.rootViewController = loginNavController
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }


}
