//
//  TempViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TempViewController: RootViewController {
    private(set) lazy var tempView: TGCanvasView = {
        let view = TGCanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        view.backgroundColor = .systemGreen
    }

    private func setupSubviews(){
        view.addSubview(tempView)

        NSLayoutConstraint.activate([
            tempView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tempView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tempView.heightAnchor.constraint(equalToConstant: 300.0),
        ])
    }
}
