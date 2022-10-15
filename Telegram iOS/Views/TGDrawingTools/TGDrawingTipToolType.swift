//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/15/22.
//

import UIKit

enum TGDrawingTipToolType {
    case none
    case colorAndHeight(color: UIColor, height: CGFloat)
    case color(color: UIColor)

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case let .colorAndHeight(color, _):
            return color
        case let .color(color):
            return color
        }
    }

    var height: CGFloat {
        switch self {
        case .colorAndHeight(_, let height):
            return height
        case .none, .color:
            return 0.0
        }
    }
}
