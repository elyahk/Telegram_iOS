//
//  AllowScreenViewController.swift
//  Telegram iOS
//
//  Created by User 2 on 12/10/22.
//
import Lottie
import UIKit

class AllowScreenViewController: RootViewController {
    private let assertPhotosAccessManager = AssertPhotosAccessManager.shared

    public var events: Events = .init()

    private(set) lazy var duckAnimationView: LottieAnimationView = {
        var view = LottieAnimationView()
        view = .init(name: "duck")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.play()
        
        return view
    }()
    
    private(set) lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Access Your Photos and Videos"
        view.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        view.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.textAlignment = .center
        
        return view
    }()
    
    private(set) lazy var allowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Allow Access", for: .normal)
        button.backgroundColor = .link
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(touchUpInside(allow:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchUpInside(allow:)), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var shimmer: ShimmeringView = {
        let shimmer = ShimmeringView()
        shimmer.translatesAutoresizingMaskIntoConstraints = false
        shimmer.contentView = allowButton
        shimmer.backgroundColor = .white
        shimmer.layer.cornerRadius = 10.0
        shimmer.isShimmering = true
        shimmer.shimmerPauseDuration = 3.0
        shimmer.shimmerSpeed = 450

        return shimmer
    }()
    

    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews(){
        view.addSubview(contentView)
        contentView.addSubview(duckAnimationView)
        contentView.addSubview(label)
        contentView.addSubview(shimmer)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),

            duckAnimationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            duckAnimationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            duckAnimationView.heightAnchor.constraint(equalToConstant: 144),
            duckAnimationView.widthAnchor.constraint(equalToConstant: 144),
            
            label.topAnchor.constraint(equalTo: duckAnimationView.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            
            shimmer.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 28),
            shimmer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            shimmer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            shimmer.heightAnchor.constraint(equalToConstant: 50),
            shimmer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        view.layoutIfNeeded()
    }

    @objc func touchUpInside(allow button: UIButton) {
        assertPhotosAccessManager.getPermissionIfNecessary { [weak self] success in
            self?.events.assertPhotosAccess?(success)
        }
    }
}

extension AllowScreenViewController {
    public struct Events {
        var assertPhotosAccess: ((Bool) -> Void)?
    }
}
