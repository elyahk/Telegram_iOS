//
//  TempViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TempViewController: RootViewController {
    private(set) lazy var tempView: TGToolSlider = {
        let view = TGToolSlider()
        view.translatesAutoresizingMaskIntoConstraints = false

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
            tempView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            tempView.heightAnchor.constraint(equalToConstant: 60.0),
        ])
    }
}
