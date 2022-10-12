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

    lazy var shimmerView: ShimmeringView = {
        let view = ShimmeringView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentView = allowButton
        view.isShimmering = false
        view.shimmerSpeed = 500
        view.shimmerPauseDuration = 1.0
        view.shimmerAnimationOpacity = 0.8
        view.shimmerHighlightLength = 0.7

        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shimmerView.isShimmering = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shimmerView.isShimmering = false
        }
    }
    
    func setupSubviews(){
        view.addSubview(contentView)
        contentView.addSubview(duckAnimationView)
        contentView.addSubview(label)
        contentView.addSubview(shimmerView)
        
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
            
            shimmerView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 28),
            shimmerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            shimmerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            shimmerView.heightAnchor.constraint(equalToConstant: 50),
            shimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        view.layoutIfNeeded()
    }
}
