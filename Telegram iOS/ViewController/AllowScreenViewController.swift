//
//  AllowScreenViewController.swift
//  Telegram iOS
//
//  Created by User 2 on 12/10/22.
//
import Lottie
import UIKit

class AllowScreenViewController: UIViewController{
    
    lazy var duckAnimationView: LottieAnimationView = {
        var view = LottieAnimationView()
        view = .init(name: "duck")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.play()
        
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Access Your Photos and Videos"
        view.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        view.attributedText = NSMutableAttributedString(string: "Access Your Photos and Videos", attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var allowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Allow Access", for: .normal)
        button.backgroundColor = .link
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        
        return button
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    func setupSubviews(){
        view.addSubview(contentView)
        contentView.addSubview(duckAnimationView)
        contentView.addSubview(label)
        contentView.addSubview(allowButton)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            duckAnimationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            duckAnimationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            duckAnimationView.heightAnchor.constraint(equalToConstant: 144),
            duckAnimationView.widthAnchor.constraint(equalToConstant: 144),
            
            label.topAnchor.constraint(equalTo: duckAnimationView.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            
            allowButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 28),
            allowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            allowButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            allowButton.heightAnchor.constraint(equalToConstant: 50),
            allowButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
