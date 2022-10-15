//
//  ImageViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit
import PencilKit
import Photos

class ImageViewController: RootViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    public var asset: PHAsset = PHAsset() {
        didSet { getPhoto() }
    }

    private lazy var topToolbar: TopToolbar = {
        let view = TopToolbar(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftButton.addTarget(self, action: #selector(touchUpInside(back:)), for: .touchUpInside)

        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear

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
        view.tool = PKInkingTool(PKInkingTool.InkType.pen, color: UIColor.red, width: 20.0)

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
        view.events.toolTypeChanged = { [weak self] type in
            self?.changed(tool: type)
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        getPhoto()
    }

    func getPhoto() {
        imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
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
            tgToolPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.layoutIfNeeded()
    }

    @objc private func touchUpInside(back button: UIButton) {
        self.dismiss(animated: true)
    }

    private func changed(tool type: TGDrawingToolType) {
        switch type {
        case .pen:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: UIColor.red, width: 5.0)
        case .brush:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.marker, color: UIColor.red, width: 5.0)
        case .neon:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.marker, color: UIColor.red, width: 5.0)
        case .pencil:
            pkCanvasView.tool = PKInkingTool(PKInkingTool.InkType.pencil, color: UIColor.red, width: 5.0)
        case .lasso:
            pkCanvasView.tool = PKLassoTool()
        case .eraser:
            pkCanvasView.tool = PKEraserTool(.vector)
        }
    }
}
