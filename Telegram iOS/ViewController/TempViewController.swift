//
//  TempViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TempViewController: RootViewController {
    private(set) lazy var tempView: UIView = {
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        view.backgroundColor = .yellow
    }

    private func setupSubviews(){
        view.addSubview(tempView)

        NSLayoutConstraint.activate([
            tempView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
