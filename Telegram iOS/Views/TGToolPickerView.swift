//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGToolPickerView: UIView {
    public var events: Events = .init()

    lazy var drawingTool: TGDrawingTools = {
        let view = TGDrawingTools()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.events.changedType = { [weak self] type in
            self?.events.toolTypeChanged(type)
        }

        return view
    }()

    lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Draw", "Text"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        view.backgroundColor = UIColor.black
        view.selectedSegmentTintColor = UIColor.gray
        view.clipsToBounds = true
        view.layer.cornerRadius = 14.0
        view.selectedSegmentIndex = 0

        return view
    }()

    lazy var sliderToolbar: TGSliderToolbar = {
        let view = TGSliderToolbar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.cancel.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)
        view.makeRectangle()

        return view
    }()

    lazy var colorPickerButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.roundTip.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)
        view.makeRectangle()

        return view
    }()

    lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cancelButton, segmentControl, sliderToolbar, downloadButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16.0

        return view
    }()

    lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [colorPickerButton, drawingTool, addButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16.0

        return view
    }()

    lazy var addButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.add.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)
        view.backgroundColor = UIColor.darkGray
        view.makeRectangle()

        return view
    }()

    lazy var downloadButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.download.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)
        view.makeRectangle()

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
        addSubview(drawingTool)
        addSubview(colorPickerButton)
        addSubview(addButton)
        addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: universalWidth(33.0)),

            colorPickerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            colorPickerButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: universalHeight(-17.5)),

            drawingTool.widthAnchor.constraint(equalToConstant: universalWidth(240.0)),
            drawingTool.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingTool.heightAnchor.constraint(equalToConstant: universalHeight(93.0)),
            drawingTool.bottomAnchor.constraint(equalTo: bottomStackView.bottomAnchor),

            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            addButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: universalHeight(-17.5))
        ])
    }

    @objc private func valueChanged(_ segmentControl: UISegmentedControl) {

    }
}

// MARK: - Events

extension TGToolPickerView {
    public struct Events {
        var toolTypeChanged: ((TGDrawingToolType) -> Void) = { _ in }
    }
}

// MARK: - UIButton + width and height

private extension UIButton {
    func makeRectangle(width: CGFloat = universalWidth(33.0), height: CGFloat = universalWidth(33.0)) {
        self.heightAnchor.constraint(equalToConstant: width).isActive = true
        self.widthAnchor.constraint(equalToConstant: height).isActive = true
    }
}
