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
    case toolBasePen = "pen_base"
    case toolTipPen = "pen_tip"
    case arrowTip
    case blurTip
    case roundTip
    case shapeArrow
    case shapeBubble
    case shapeEllipse
    case shapeRectangle
    case shapeStar
    case xmarkTip
    case zoomOut
    case defaultA = "default"
    case semi
    case stroke
    case textCenter
    case textLeft
    case textRight
    case add
    case back
    case backToCancel
    case cancel
    case download
    case shapeFill
    case shapeFlip
    case shapeStroke
    case blurEraser
    case brush
    case eraser
    case lasso
    case neon
    case objectEraser
    case pencil
    case colorPicker
    case brush_tip
    case neon_tip
    case pencil_tip
    
    case none

    var image: UIImage {
        guard let image = UIImage(named: self.rawValue) else { return UIImage() }

        return image
    }
}
