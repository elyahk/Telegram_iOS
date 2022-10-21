//
//  CustomCanvasView.swift
//  Telegram iOS
//
//  Created by Eldorbek Nusratov on 21/10/22.
//

import UIKit

// Draw GPU
class TGCanvasView: UIView, Drawable {
    var lineWidth: CGFloat = 5.0
    var lineColor: UIColor = .white
    var drawingLayer: CAShapeLayer?
    
    var line = [CGPoint]() {
        didSet { checkIfTooManyPoints() }
    }
    
    var sublayers: [CALayer] {
        return self.layer.sublayers ?? [CALayer]()
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let newTouchPoint = touches.first?.location(in: self) else { return }
        line.append(newTouchPoint)
        let lastTouchPoint: CGPoint = line.last ?? .zero
        let rect = calculateRectBetween(lastPoint: lastTouchPoint, newPoint: newTouchPoint, lineWidth: lineWidth)
        layer.setNeedsDisplay(rect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flattenImage()
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        let drawingLayer = self.drawingLayer ?? CAShapeLayer()
        let linePath = UIBezierPath()
        drawingLayer.contentsScale = Display.scale
        line = douglasPeucker(points: line, epsilon: 2.0)
        
        for (index, point) in line.enumerated() {
            if index == 0 {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
        }
        
        drawingLayer.path = linePath.cgPath
        drawingLayer.opacity = 1
        drawingLayer.lineWidth = lineWidth
        drawingLayer.lineCap = .round
        drawingLayer.lineJoin = .round
        drawingLayer.fillColor = UIColor.clear.cgColor
        drawingLayer.strokeColor = lineColor.cgColor
        
        if self.drawingLayer == nil {
            self.drawingLayer = drawingLayer
            layer.addSublayer(drawingLayer)
        }
    }
    
    func checkIfTooManyPoints(maxPoints: Int = 25) {
        if line.count > maxPoints {
            updateFlattenedLayer()
            // we leave two points to ensure no gaps or sharp angles
            line.removeFirst(maxPoints - 2)
        }
    }
    
    func flattenImage() {
        updateFlattenedLayer()
        line.removeAll()
    }
    
    func updateFlattenedLayer() {
        // 1
        guard let drawingLayer = drawingLayer,
            // 2
            let optionalDrawing = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                NSKeyedArchiver.archivedData(withRootObject: drawingLayer, requiringSecureCoding: false))
                as? CAShapeLayer
            // 3
             else { return }
        
        let newDrawing = optionalDrawing
        layer.addSublayer(newDrawing)
    }
            
    func clear() {
        emptyFlattenedLayers()
        drawingLayer?.removeFromSuperlayer()
        drawingLayer = nil
        line.removeAll()
        layer.setNeedsDisplay()
    }
    
    func emptyFlattenedLayers() {
        for case let layer as CAShapeLayer in sublayers {
            layer.removeFromSuperlayer()
        }
    }
}
