//
//  BrushView.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

class BrushView: UIView{
    
    lazy var pencilImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "brush")
        
        return image
    }()
    
    lazy var tipImageView: UIImageView = {
        let view = UIImageView()
        view.image = Images.brush_tip.image
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .link
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        addSubview(pencilImageView)
        addSubview(tipImageView)
        addSubview(baseImageView)
        
        NSLayoutConstraint.activate([
            pencilImageView.topAnchor.constraint(equalTo: topAnchor),
            pencilImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pencilImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pencilImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tipImageView.topAnchor.constraint(equalTo: topAnchor),
            tipImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tipImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            baseImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 11.5),
            baseImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -11.5),
            baseImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -45.0),
            baseImageView.heightAnchor.constraint(equalToConstant: 8.0)
        ])
    }
}
