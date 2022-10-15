//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGToolPickerView: UIView {
    lazy var drawingTool: TGDrawingTools = {
        let view = TGDrawingTools()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Draw", "Text"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)

        return view
    }()

    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.cancel.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)

        return view
    }()

    lazy var colorPickerButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.roundTip.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)

        return view
    }()

    lazy var addButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.add.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)
        view.backgroundColor = UIColor.darkGray

        return view
    }()

    lazy var downloadButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.download.image, for: .normal)
        view.layer.cornerRadius = universalWidth(15.0)

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
        addSubview(segmentControl)
        addSubview(cancelButton)
        addSubview(colorPickerButton)
        addSubview(addButton)
        addSubview(downloadButton)

        NSLayoutConstraint.activate([
            drawingTool.topAnchor.constraint(equalTo: topAnchor),
            drawingTool.widthAnchor.constraint(equalToConstant: universalWidth(240.0)),
            drawingTool.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingTool.heightAnchor.constraint(equalToConstant: universalHeight(93.0)),

            segmentControl.topAnchor.constraint(equalTo: drawingTool.bottomAnchor, constant: -25),
            segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: universalHeight(32.0)),

            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            cancelButton.trailingAnchor.constraint(equalTo: segmentControl.leadingAnchor, constant: universalWidth(-16.0)),
            cancelButton.centerYAnchor.constraint(equalTo: segmentControl.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: universalWidth(30.0)),
            cancelButton.widthAnchor.constraint(equalToConstant: universalWidth(30.0)),

            colorPickerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            colorPickerButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: universalHeight(-17.5)),
            colorPickerButton.heightAnchor.constraint(equalToConstant: universalWidth(30.0)),
            colorPickerButton.widthAnchor.constraint(equalToConstant: universalWidth(30.0)),

            downloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            downloadButton.centerYAnchor.constraint(equalTo: segmentControl.centerYAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: universalWidth(30.0)),
            downloadButton.widthAnchor.constraint(equalToConstant: universalWidth(30.0)),
            downloadButton.leadingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: universalWidth(16.0)),

            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            addButton.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: universalHeight(-17.5)),
            addButton.heightAnchor.constraint(equalToConstant: universalWidth(30.0)),
            addButton.widthAnchor.constraint(equalToConstant: universalWidth(30.0)),
        ])
    }

    @objc private func valueChanged(_ segmentControl: UISegmentedControl) {

    }
}

