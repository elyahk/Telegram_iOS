//
//  TGCanvasView.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/21/22.
//

import UIKit

class TGCanvasView: UIView {
    private var lines = [[CGPoint]]()
    private var lastLine: [CGPoint] = []

    private lazy var panGesture: UIPanGestureRecognizer = {
        let view = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addGestureRecognizer(panGesture)
    }

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        ctx.beginPath()
        
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(10)
        ctx.setLineCap(.butt)

        for (i, p) in lastLine.enumerated() {
            if i == 0 {
                ctx.move(to: p)
            } else {
                ctx.addLine(to: p)
            }
        }
        ctx.strokePath()

    }

//    override func draw(_ rect: CGRect) {
//        // custom drawing
//        super.draw(rect)
//
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        // here are my lines
//        // dummy data
//        //        let startPoint = CGPoint(x: 0, y: 0)
//        //        let endPoint = CGPoint(x: 100, y: 100)
//        //
//        //        context.move(to: startPoint)
//        //        context.addLine(to: endPoint)
//
//        context.saveGState()
//        context.setStrokeColor(UIColor.red.cgColor)
//        context.setLineWidth(10)
//        context.setLineCap(.butt)
//
//        for (i, p) in lastLine.enumerated() {
//            if i == 0 {
//                context.move(to: p)
//            } else {
//                context.addLine(to: p)
//            }
//        }
//        //        lines.forEach { (line) in
//        //            for (i, p) in line.enumerated() {
//        //                if i == 0 {
//        //                    context.move(to: p)
////                } else {
////                    context.addLine(to: p)
////                }
////            }
////        }
//
//
//    }

    // let's ditch this line
    //    var line = [CGPoint]()
//
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        lines.append([CGPoint]())
//    }
//
//    // track the finger as we move across screen
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: nil) else { return }
//        //        print(point)
//
//        guard var lastLine = lines.popLast() else { return }
//        lastLine.append(point)
//        lines.append(lastLine)
//
//        //        var lastLine = lines.last
//        //        lastLine?.append(point)
//
//        //        line.append(point)
//
//        setNeedsDisplay()
//    }

    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        // get translation
        let point = sender.location(in: self)

        if panGesture.state == UIGestureRecognizer.State.began {
            lastLine = [point]
        }

        if panGesture.state == UIGestureRecognizer.State.ended {
            lastLine.append(point)
            setNeedsDisplay()
        }

        if panGesture.state == UIGestureRecognizer.State.changed {
            // add something you want to happen when the Label Panning has been change ( during the moving/panning )
            lastLine.append(point)
            setNeedsDisplay()
        } else {
            // or something when its not moving
            print("or something when its not moving")
        }
    }
}
