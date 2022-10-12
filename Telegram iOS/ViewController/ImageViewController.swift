//
//  ImageViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit
import PencilKit
import Photos

class ImageViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    public var asset: PHAsset = PHAsset() {
        didSet { getPhoto() }
    }

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray

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

    override func viewDidLoad() {
        super.viewDidLoad()


        setupSubviews()
        getPhoto()

        if let window = UIApplication.shared.delegate?.window, let toolPicker = PKToolPicker.shared(for: window!) {
            toolPicker.setVisible(true, forFirstResponder: pkCanvasView)
            toolPicker.addObserver(pkCanvasView)

            pkCanvasView.becomeFirstResponder()
        }
    }

    func getPhoto() {
        imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
    }

    private func setupSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(pkCanvasView)


        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            pkCanvasView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pkCanvasView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pkCanvasView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pkCanvasView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        view.layoutIfNeeded()
    }
}
