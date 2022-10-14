//
//  InstrumentContentView.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

class InstrumentContentView: UIView{
    lazy var pencilView: TGDrawingTool = {
        let view = TGDrawingTool(type: .pen)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var brushView: TGDrawingTool = {
        let view = TGDrawingTool(type: .brush)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var neonView: TGDrawingTool = {
        let view = TGDrawingTool(type: .neon)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pencil2View: TGDrawingTool = {
        let view = TGDrawingTool(type: .pencil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var lassoView: TGDrawingTool = {
        let view = TGDrawingTool(type: .lasso)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var eraserView: TGDrawingTool = {
        let view = TGDrawingTool(type: .eraser)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            pencilView, brushView, neonView, pencil2View, lassoView, eraserView
        ])
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
