//
//  NeonView.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

class NeonView: UIView{
    
    lazy var pencilImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "neon")
        
        return image
    }()
    
    lazy var tipImageView: UIImageView = {
        let view = UIImageView()
        view.image = Images.neon_tip.image
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//        view.backgroundColor = UIColor.green
//        view.layer.shadowColor = UIColor.green.cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize.zero
//        view.layer.shadowRadius = 5
//        view.layer.cornerRadius = 3.0
//        view.backgroundColor = .green
        
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
            
//            tipImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15.5),
//            tipImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15.5),
//            tipImageView.topAnchor.constraint(equalTo: topAnchor,constant: 5.0),
//            tipImageView.heightAnchor.constraint(equalToConstant: 9.0),
            
            baseImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 11.5),
            baseImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -11.5),
            baseImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -38.0),
            baseImageView.heightAnchor.constraint(equalToConstant: 15.0)
        ])
    }
}
