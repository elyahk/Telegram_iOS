//
//  InstrumentContentView.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

class InstrumentContentView: UIView{
    
    lazy var pencilView: PencilView = {
        let view = PencilView(type: .pen)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var brushView: PencilView = {
        let view = PencilView(type: .brush)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var neonView: PencilView = {
        let view = PencilView(type: .neon)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pencil2View: PencilView = {
        let view = PencilView(type: .pencil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var lassoView: PencilView = {
        let view = PencilView(type: .lasso)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var eraserView: PencilView = {
        let view = PencilView(type: .eraser)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pencilView,brushView,neonView,pencil2View,lassoView,eraserView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 27
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
