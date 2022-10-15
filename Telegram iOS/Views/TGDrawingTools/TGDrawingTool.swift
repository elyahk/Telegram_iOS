//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TGDrawingTool: UIView {
    public var colorRectangleHeight: CGFloat = 1.0 {
        didSet {
            colorRectangleleViewHeightAnchor.constant = colorRectangleHeight
            colorRectangleleViewHeightAnchor.isActive = true
        }
    }

    private lazy var colorRectangleleViewHeightAnchor = colorRectangleleView.heightAnchor.constraint(equalToConstant: universalHeight(1.0))

    public var tipType: TGDrawingTipToolType {
        didSet { updateType() }
    }

    public var type: TGDrawingToolType {
        didSet { updateType() }
    }

    lazy var baseImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = type.baseImage

        return image
    }()

    lazy var tipImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = type.tipImage
        view.contentMode = .scaleAspectFill

        return view
    }()

    lazy var colorRectangleleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 1.0
        view.clipsToBounds = true

        return view
    }()

    convenience init(type: TGDrawingToolType, tipType: TGDrawingTipToolType = .none) {
        self.init(frame: .zero)

        self.type = type
        self.tipType = tipType
        setupSubviews()
        updateType()
    }

    override init(frame: CGRect) {
        type = .pen
        tipType = .none
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateType() {
        baseImageView.image = type.baseImage
        tipImageView.image = type.tipImage
        colorRectangleHeight = tipType.height
        colorRectangleleView.backgroundColor = tipType.color
    }

    private func setupSubviews(){
        addSubview(baseImageView)
        addSubview(tipImageView)
        addSubview(colorRectangleleView)

        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tipImageView.topAnchor.constraint(equalTo: topAnchor),
            tipImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            colorRectangleleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: universalWidth(1.5)),
            colorRectangleleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -universalWidth(1.5)),
            colorRectangleleView.topAnchor.constraint(equalTo: topAnchor,constant: universalHeight(38.0)),
            colorRectangleleViewHeightAnchor
        ])
    }
}

