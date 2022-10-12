//
//  AppDelegate.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        let controller = AllowScreenViewController()
        window?.rootViewController = controller

        controller.events.assertPhotosAccess = { [weak controller] success in
            if success {
                DispatchQueue.main.async {
                    let imagesController = ImagesCollectionViewController()
                    imagesController.modalPresentationStyle = .fullScreen
                    imagesController.modalTransitionStyle = .flipHorizontal

                    controller?.present(imagesController, animated: true)
                }
            }
        }

        return true
    }
}
