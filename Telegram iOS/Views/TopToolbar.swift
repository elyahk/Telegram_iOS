//
//  TopToolbar.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit

class TopToolbar: UIView {
    public var rightButtonTitle: String = "Clear All" {
        didSet {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
    }

    public var rightButtonImage: UIImage = Images.none.image {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
        }
    }

    public var centerButtonTitle: String = "" {
        didSet {
            centerButton.setTitle(centerButtonTitle, for: .normal)
        }
    }

    public var centerButtonImage: UIImage = Images.none.image {
        didSet {
            centerButton.setImage(centerButtonImage, for: .normal)
        }
    }

    public var leftButtonTitle: String = "" {
        didSet {
            leftButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            leftButton.setTitle(leftButtonTitle, for: .normal)
        }
    }

    public var leftButtonImage: UIImage = Images.undo.image {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
    }

    private(set) lazy var rightButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.contentMode = .right
        view.setTitle(rightButtonTitle, for: .normal)
        view.setImage(rightButtonImage, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)
        view.setTitleColor(.white, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit

        return view
    }()

    private(set) lazy var leftButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setTitle(leftButtonTitle, for: .normal)
        view.setImage(leftButtonImage, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)
        view.setTitleColor(.white, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit

        return view
    }()

    private(set) lazy var centerButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setTitle(centerButtonTitle, for: .normal)
        view.setImage(centerButtonImage, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)
        view.imageView?.contentMode = .scaleAspectFit

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
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(centerButton)

        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 24.0),
            leftButton.widthAnchor.constraint(equalToConstant: 24.0),
            leftButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            centerButton.heightAnchor.constraint(equalToConstant: 24.0),
            centerButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            centerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            rightButton.heightAnchor.constraint(equalToConstant: 24.0),
            rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0)
        ])

        self.layoutIfNeeded()
    }

    public func makeButtons(enable: Bool) {
        leftButton.isEnabled = enable
        rightButton.isEnabled = enable
    }
}
