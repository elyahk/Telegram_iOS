//
//  CustomViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/11/22.
//

import UIKit
import Photos


class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        getPermissionIfNecessary { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    let controller = ImagesCollectionViewController()
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal

                    self?.present(controller, animated: true)
                }
            }
        }
    }

    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        // 1
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        // 2
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
}
