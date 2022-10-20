//
//  ColectionView.swift
//  Telegram iOS
//
//  Created by User 2 on 20/10/22.
//

import UIKit

class CollectionView: UIView{
    
    lazy var mainColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .green
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLayout() -> UICollectionViewLayout{

        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 15
                item.contentInsets.bottom = 10

                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/5), heightDimension: .fractionalHeight(1)), subitem: item, count: 2)
            group.contentInsets = .init(top: 3.0, leading: 3.0, bottom: 3.0, trailing: 3.0)

                let section = NSCollectionLayoutSection(group: group)

            section.orthogonalScrollingBehavior = .paging

                return section
            }
        layout.accessibilityScroll(.right)
            return layout
        }
    
    func setupSubviews(){
        addSubview(mainColorView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            mainColorView.topAnchor.constraint(equalTo: topAnchor),
            mainColorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainColorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainColorView.heightAnchor.constraint(equalToConstant: 82.0),
            mainColorView.widthAnchor.constraint(equalToConstant: 82.0),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: mainColorView.trailingAnchor,constant: 36.0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}



extension CollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else{
            return UICollectionViewCell()

        }
        cell.layer.cornerRadius = 14.0
        cell.backgroundColor = .gray
        return cell
    }


}
