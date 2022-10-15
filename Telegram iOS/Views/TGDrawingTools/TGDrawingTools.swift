//
//  TGDrawingTools.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGDrawingTools: UIView {
    public var events: Events = .init()
    public var selectedType: TGDrawingToolType = .pen

    lazy var pencilView: TGDrawingTool = {
        let view = TGDrawingTool(type: .pen, tipType: .colorAndHeight(color: UIColor.yellow, height: 5.0))
        view.colorRectangleHeight = 3.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var brushView: TGDrawingTool = {
        let view = TGDrawingTool(type: .brush)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var neonView: TGDrawingTool = {
        let view = TGDrawingTool(type: .neon)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var pencil2View: TGDrawingTool = {
        let view = TGDrawingTool(type: .pencil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var lassoView: TGDrawingTool = {
        let view = TGDrawingTool(type: .lasso)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var eraserView: TGDrawingTool = {
        let view = TGDrawingTool(type: .eraser)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selected = selected(selected:)

        return view
    }()

    lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            pencilView, brushView, neonView, pencil2View, lassoView, eraserView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 27

        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews(){
        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func selected(selected type: TGDrawingToolType) {
        events.changedType(type)
    }
}

extension TGDrawingTools {
    public struct Events {
        var changedType: ((TGDrawingToolType) -> Void) = { _ in }

    }
}

