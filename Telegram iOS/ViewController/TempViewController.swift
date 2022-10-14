//
//  TempViewController.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/13/22.
//

import UIKit

class TempViewController: RootViewController {
    private(set) lazy var tempView: UIView = {
        var view = TGDrawingTool(frame: .init(x: 200, y: 200, width: 17, height: 83))
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
        view.layoutIfNeeded()
    }
}
