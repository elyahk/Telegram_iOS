//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TGDrawingTool: UIView {
    private(set) lazy var baseToolImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 17.0, height: 93).universal())
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        view.image = Images.toolBasePen.image

        return view
    }()

    private(set) lazy var tipToolImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 17.0, height: 12.5).universal())
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        view.image = Images.undo.image

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

