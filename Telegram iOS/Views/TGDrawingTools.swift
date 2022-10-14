//
//  TGDrawingTools.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGDrawingTools: UIView {
    private(set) lazy var baseToolImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 17.0, height: 83).universal())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.contentMode = .right
        view.contentMode = .scaleAspectFill
        view.image = Images.toolBasePen.image

        return view
    }()

    private(set) lazy var tipToolImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 5.3, y: 0.0, width: 6.4, height: 12.5).universal())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.contentMode = .right
        view.image = Images.toolTipPen.image
        view.contentMode = .scaleAspectFill

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
        self.addSubview(baseToolImageView)
        self.addSubview(tipToolImageView)

        self.layoutIfNeeded()
    }
}

