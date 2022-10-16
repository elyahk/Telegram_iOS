//
//  TGToolSlider.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/15/22.
//

import UIKit

final class TGToolSlider: UISlider {

    private let baseLayer = CAShapeLayer() // Step 3

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 2.5, y: frame.height * 0.5 - 2.5))
        ctx.addArc(
            center: CGPoint(x: 2.5, y: frame.height * 0.5),
            radius: 2.5,
            startAngle: CGFloat(.pi * 1.5),
            endAngle: CGFloat(.pi * 0.5),
            clockwise: true
        )
        ctx.addLine(to: CGPoint(x: frame.width - frame.height / 4, y: frame.height * 0.75))
        ctx.addArc(
            center: CGPoint(x: frame.width - frame.height / 4, y: frame.height * 0.5),
            radius: frame.height / 4,
            startAngle: 0.5 * CGFloat.pi,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )
        ctx.addLine(to: CGPoint(x: 2.5, y: frame.height / 2 - 2.5))
        ctx.setFillColor(UIColor.systemYellow.cgColor)
        ctx.drawPath(using: .fill)
    }

    private func setup() {
        clear()
        layoutIfNeeded()
    }

    private func clear() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
    }
}
