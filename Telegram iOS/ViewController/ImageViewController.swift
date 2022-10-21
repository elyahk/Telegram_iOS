//
//  ImageViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit
import PencilKit
import Photos

struct TGToolState {
    let type: TGDrawingToolType
    let color: UIColor
    let width: CGFloat
}

class ImageViewController: RootViewController, PKToolPickerObserver {
    public var asset: PHAsset = PHAsset()

    public var image: UIImage = Images.sample_image.image

    private lazy var tgToolState: TGToolState = TGToolState(type: .pen, color: .white, width: 1.0)

    private lazy var drawingStackManager: DrawingStackManager = {
        let drawingStackManager = DrawingStackManager(pkCanvasView)

        return drawingStackManager
    }()

    private lazy var topToolbar: TopToolbar = {
        let view = TopToolbar(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftButton.addTarget(self, action: #selector(touchUpInside(back:)), for: .touchUpInside)
        view.rightButton.addTarget(self, action: #selector(touchUpInside(clearAll:)), for: .touchUpInside)
        view.makeButtons(enable: false)

        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.image = image

        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    private lazy var pkDrawing: PKDrawing = {
        let drawing = PKDrawing()

        return drawing
    }()

    private lazy var pkCanvasView: PKCanvasView = {
        let view = PKCanvasView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.contentSize = view.frame.size
        view.delegate = self
        view.alwaysBounceVertical = true
        view.drawing = pkDrawing

        if #available(iOS 14.0, *) {
            view.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        } else {
            view.allowsFingerDrawing = true
        }

        return view
    }()

    lazy var tgToolPickerView: TGToolPickerView = {
        let view = TGToolPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.events.toolTypeChanged = { [weak self] state in
            self?.changedTool(state: state)
        }

        view.events.showToolSlider = { [weak self] state in
//            self?.changed(tool: type)
        }

        view.events.sliderValueChanged = { [weak self] state in
            self?.changedTool(state: state)
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(topToolbar)
        view.addSubview(contentView)
        view.addSubview(tgToolPickerView)
        contentView.addSubview(imageView)
        contentView.addSubview(pkCanvasView)

        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topToolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
            topToolbar.rightAnchor.constraint(equalTo: view.rightAnchor),
            topToolbar.heightAnchor.constraint(equalToConstant: universalHeight(44.0)),
            topToolbar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -universalHeight(31.0)),

            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -universalHeight(196.0)),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            pkCanvasView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pkCanvasView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pkCanvasView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pkCanvasView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            tgToolPickerView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: universalHeight(53.0)),
            tgToolPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tgToolPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tgToolPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -universalHeight(31.0))
        ])

        view.layoutIfNeeded()
    }
}

// MARK: - Actions

extension ImageViewController {
    @objc private func touchUpInside(back button: UIButton) {
        drawingStackManager.undo()
        topToolbar.makeButtons(enable: !drawingStackManager.mementos.isEmpty)
    }

    @objc private func touchUpInside(clearAll button: UIButton) {
        drawingStackManager.clear()
        topToolbar.makeButtons(enable: false)
    }

    private func showToolSlider(tool type: TGDrawingToolType) {

    }
}

// MARK: - Functions

extension ImageViewController {
    private func changedTool(state: TGToolState) {
        let type = state.type
        let color = state.color
        let width = state.width

        switch type {
        case .pen:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: color, width: width)
        case .brush:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.marker, color: color, width: width)
        case .neon:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.marker, color: color, width: width)
        case .pencil:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.pencil, color: color, width: width)
        case .lasso:
            pkCanvasView.tool = PKLassoTool()
        case .eraser:
            pkCanvasView.tool = PKEraserTool(.vector)

        }
    }
}

// MARK: - PKCanvasViewDelegate

extension ImageViewController: PKCanvasViewDelegate {
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        drawingStackManager.save()
        topToolbar.makeButtons(enable: !drawingStackManager.mementos.isEmpty)
    }
}

class PKBrushTool: PKTool {
    
}
