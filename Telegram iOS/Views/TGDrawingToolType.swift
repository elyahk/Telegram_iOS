//
//  ToolType.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

enum TGDrawingToolType {
    case pen
    case brush
    case neon
    case pencil
    case lasso
    case eraser

    var baseImage: UIImage {
        switch self {
        case .pen:
            return Images.toolBasePen.image
        case .brush:
            return Images.brush.image
        case .neon:
            return Images.neon.image
        case .pencil:
            return Images.pencil.image
        case .lasso:
            return Images.lasso.image
        case .eraser:
            return Images.eraser.image
        }
    }

    var tipImage: UIImage {
        switch self {
        case .pen:
            return Images.toolTipPen.image
        case .brush:
            return Images.brush_tip.image
        case .neon:
            return Images.neon_tip.image
        case .pencil:
            return Images.pencil_tip.image
        case .lasso:
            return Images.neon.image
        case .eraser:
            return Images.none.image
        }
    }
}
