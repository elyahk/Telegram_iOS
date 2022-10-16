//
//  TGToolSlider.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/15/22.
//

import UIKit

final class TGToolSlider: UISlider {
    lazy var color: UIColor = .white {
        didSet {
            changeColor()
        }
    }

    private var ctx: CGContext?

    convenience init(color: UIColor) {
        self.init(frame: .zero)
    }

    private let minX: CGFloat = 5.0
    private let baseLayer = CAShapeLayer() // Step 3

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        ctx.beginPath()
        ctx.move(to: CGPoint(x: minX + 2.5, y: frame.height * 0.5 - 2.5))
        ctx.addArc(
            center: CGPoint(x: minX + 2.5, y: frame.height * 0.5),
            radius: 2.5,
            startAngle: CGFloat(.pi * 1.5),
            endAngle: CGFloat(.pi * 0.5),
            clockwise: true
        )
        ctx.addLine(to: CGPoint(x: frame.width - minX - frame.height / 4, y: frame.height * 0.75))
        ctx.addArc(
            center: CGPoint(x: frame.width - minX - frame.height / 4, y: frame.height * 0.5),
            radius: frame.height / 4,
            startAngle: 0.5 * CGFloat.pi,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )
        ctx.addLine(to: CGPoint(x: minX + 2.5, y: frame.height / 2 - 2.5))
        ctx.setFillColor(color.cgColor)
        ctx.drawPath(using: .fill)
        self.ctx = ctx
    }

    private func changeColor() {
        self.ctx?.setFillColor(color.cgColor)
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
