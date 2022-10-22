//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import UIKit

class TGToolPickerView: UIView {
    public var events: Events = .init()

    private var currentToolState: TGToolState {
        TGToolState(type: currentType, color: currentColor, width: currentWidth)
    }

    private lazy var currentColor: UIColor = .white
    private lazy var currentWidth: CGFloat = 1.0
    private lazy var currentType: TGDrawingToolType = .pen

    lazy var colorPickerButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(Images.roundTip.image, for: .normal)
        view.addTarget(self, action: #selector(coloPickerPresent), for: .touchUpInside)
        view.layer.cornerRadius = universalWidth(15.0)
        view.makeRectangle()

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

    lazy var drawingTool: TGDrawingTools = {
        let view = TGDrawingTools()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.events.changedType = { [weak self] type in
            guard let self = self else { return }
            self.currentType = type
            self.events.toolTypeChanged(TGToolState(type: type, color: self.currentColor, width: self.currentWidth))
        }
        view.events.showToolSlider = { [weak self] type in
            self?.setToolSlider(for: type, isHidden: false)
        }

        return view
    }()

    lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [segmentControl, downloadButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16.0

        return view
    }()

    lazy var bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black

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
        view.events.sliderValueChanged = { [weak self] value in
            guard let self = self else { return }
            self.currentWidth = value
            self.events.sliderValueChanged(self.currentToolState)
        }

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
        bottomContentView.addSubview(sliderToolbar)
        bottomContentView.addSubview(bottomStackView)
        addSubview(drawingTool)
        addSubview(colorPickerButton)
        addSubview(addButton)
        addSubview(cancelButton)
        addSubview(bottomContentView)

        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: bottomContentView.topAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor),

            sliderToolbar.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor),
            sliderToolbar.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor),
            sliderToolbar.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor),
            sliderToolbar.heightAnchor.constraint(equalToConstant: universalHeight(28.0)),
            sliderToolbar.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor),

            bottomContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomContentView.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 16.0),
            bottomContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            bottomContentView.heightAnchor.constraint(equalToConstant: universalWidth(33.0)),

            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),

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


    func setToolSlider(for type: TGDrawingToolType, isHidden: Bool) {
        sliderToolbar.isHidden = isHidden
        bottomStackView.isHidden = !isHidden
    }
}

// MARK: - Events

extension TGToolPickerView {
    public struct Events {
        var toolTypeChanged: ((TGToolState) -> Void) = { _ in }
        var showToolSlider: ((TGDrawingToolType) -> Void) = { _ in }
        var sliderValueChanged: ((TGToolState) -> Void) = { _ in }
    }
}

// MARK: - UIButton + width and height

private extension UIButton {
    func makeRectangle(width: CGFloat = universalWidth(33.0), height: CGFloat = universalWidth(33.0)) {
        self.heightAnchor.constraint(equalToConstant: width).isActive = true
        self.widthAnchor.constraint(equalToConstant: height).isActive = true
    }
}

extension TGToolPickerView: UIColorPickerViewControllerDelegate{
    
    @objc private func coloPickerPresent(){
        if #available(iOS 14.0, *) {
            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.delegate = self

            
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPickerButton.tintColor = color
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPickerButton.tintColor = color
    }
}
