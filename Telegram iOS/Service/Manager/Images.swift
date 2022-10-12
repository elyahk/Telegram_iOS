//
//  ImagesManager.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import Foundation
import UIKit

enum Images: String {
    case undo = "undo"
    case none

    var image: UIImage {
        guard let image = UIImage(named: self.rawValue) else { return UIImage() }

        return image
    }
}
