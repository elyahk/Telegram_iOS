//
//  MainCompositionController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit
import Photos

class MainCompositionController {
    internal func getTopViewController() -> UIViewController {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            return ImagesCollectionViewController()
        }

        let controller = AllowScreenViewController()

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

        return controller
    }
}
