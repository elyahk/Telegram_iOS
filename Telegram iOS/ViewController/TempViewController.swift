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

    private(set) lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("change", for: .normal)
        view.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
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
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tempView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tempView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tempView.heightAnchor.constraint(equalToConstant: 300.0),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func touchUpInside() {
    }
}
