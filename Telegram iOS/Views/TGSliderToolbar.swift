//
//  TGSliderToolbar.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/16/22.
//


import UIKit

class TGSliderToolbar: UIView {
    public var events: Events = .init()

    lazy var toolSlider: TGToolSlider = {
        let view = TGToolSlider(color: .red)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.minimumValue = 1.0
        view.maximumValue = 25.0
        view.isContinuous = false

        return view
    }()

    lazy var shapeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .right
        view.setTitle("Round", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17.0)
        view.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        view.imageView?.tintColor = .white
        view.imageView?.contentMode = .scaleAspectFit
        view.semanticContentAttribute = .forceRightToLeft
//        view.imageEdgeInsets = .init(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        view.contentEdgeInsets = .init(top: 0.0, left: 26.0, bottom: 0.0, right: 0.0)

        return view
    }()

    lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [toolSlider, shapeButton])
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
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
            contentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        layoutIfNeeded()
    }

    public func change(color: UIColor) {
        toolSlider.color = color
    }
}

// MARK: - Events

extension TGSliderToolbar {
    public struct Events {
        var sliderValueChanged: ((CGFloat) -> Void) = { _ in }
    }

    @objc private func sliderValueChanged(_ slider: UISlider) {
        events.sliderValueChanged(CGFloat(slider.value))
    }
}
