//
//  ImageViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/12/22.
//

import UIKit
import PencilKit
import Photos

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
}

class ImageViewController: RootViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    public var asset: PHAsset = PHAsset() {
        didSet { getPhoto() }
    }

    private lazy var topToolbar: TopToolbar = {
        let view = TopToolbar(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

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
        view.addSubview(topToolbar)
        view.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(pkCanvasView)


        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topToolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
            topToolbar.rightAnchor.constraint(equalTo: view.rightAnchor),
            topToolbar.heightAnchor.constraint(equalToConstant: 44.0),
            topToolbar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -31.0),

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
