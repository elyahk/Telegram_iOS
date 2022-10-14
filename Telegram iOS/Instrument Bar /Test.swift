//
//  Test.swift
//  Telegram iOS
//
//  Created by User 2 on 14/10/22.
//

import UIKit

class Test: UIViewController{
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "person")
        
        return image
    }()
    
    
    lazy var instrumentView: InstrumentContentView = {
        let view = InstrumentContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    func setupSubviews(){
        view.addSubview(instrumentView)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 128.0),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -196.0),
            
            instrumentView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40.0),
            instrumentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 77.0),
            instrumentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -77.0),
            instrumentView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -70.0),
        ])
    }
}
