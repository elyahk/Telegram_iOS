//
//  UIWindow + Size.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

public let windowHeight = UIScreen.main.bounds.height
public let windowWidth = UIScreen.main.bounds.width

public func universalWidth(_ width: CGFloat) -> CGFloat {
    return width / 375 * windowWidth
}

public func universalHeight(_ height: CGFloat) -> CGFloat {
    return height / 812 * windowHeight
}

public extension CGRect {
    func universal() -> CGRect {
        CGRect(x: universalWidth(minX), y: universalHeight(minY), width: universalWidth(width), height: universalHeight(height))
    }
}
