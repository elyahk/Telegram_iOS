//
//  WhitePen.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

enum ToolType {
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

class PencilView: UIView {
    public var type: ToolType {
        didSet { updateType() }
    }

    lazy var pencilImageView: UIImageView = {
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
    
    lazy var whiteRectangleleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 1.0
        view.clipsToBounds = true
        
        return view
    }()

    convenience init(type: ToolType) {
        self.init(frame: .zero)

        self.type = type
        setupSubviews()
        updateType()
    }

    override init(frame: CGRect) {
        type = .pen

        super.init(frame: frame)

        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateType() {
        pencilImageView.image = type.baseImage
        tipImageView.image = type.tipImage
    }

    private func setupSubviews(){
        addSubview(pencilImageView)
        addSubview(tipImageView)
        addSubview(whiteRectangleleView)
        
        
        NSLayoutConstraint.activate([
            pencilImageView.topAnchor.constraint(equalTo: topAnchor),
            pencilImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pencilImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pencilImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tipImageView.topAnchor.constraint(equalTo: topAnchor),
            tipImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            whiteRectangleleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: universalWidth(1.5)),
            whiteRectangleleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -universalWidth(1.5)),
            whiteRectangleleView.topAnchor.constraint(equalTo: topAnchor,constant: universalHeight(35.0)),
            whiteRectangleleView.heightAnchor.constraint(equalToConstant: universalHeight(3.0))
            
        ])
    }
}
