//
//  TGDrawingTools.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGDrawingTools: UIView {
    private(set) lazy var penTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var brushTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var neonTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var pencilTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var lassoTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var eraserTool: TGDrawingTool = {
        let view = TGDrawingTool(frame: .init(x: 0.0, y: 0.0, width: universalWidth(17.0), height: universalHeight(93.0)))

        view.baseToolImageView.image = Images.toolBasePen.image
        view.tipToolImageView.image = Images.toolTipPen.image

        return view
    }()

    private(set) lazy var toolsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [penTool, brushTool, neonTool, pencilTool, lassoTool, eraserTool])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = universalWidth(27.0)

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addSubview(toolsStackView)

        NSLayoutConstraint.activate([
            toolsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            toolsStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            toolsStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            toolsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.layoutIfNeeded()
    }
}

