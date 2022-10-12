//
//  AssertPhotosAccessManager.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import Photos

class AssertPhotosAccessManager {
    static let shared = AssertPhotosAccessManager()

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
