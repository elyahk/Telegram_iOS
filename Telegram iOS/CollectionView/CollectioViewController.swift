//
//  CollectioViewController.swift
//  Telegram iOS
//
//  Created by User 2 on 20/10/22.
//

import UIKit

class ColelctionViewController: UIViewController{
    
    lazy var collcetion: CollectionView = {
        let view = CollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setSubviews()
    }
    
    func setSubviews(){
        view.addSubview(collcetion)
        
        NSLayoutConstraint.activate([
            collcetion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            collcetion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            collcetion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0),
            collcetion.heightAnchor.constraint(equalToConstant: 82.0)
            
        ])
    }
}
