//
//  CatsListViewControllerView.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit

final class CatsListViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var catsListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.register(CatsListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CatsListCollectionViewCell.self))
        return collection
    }()
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = AppColors.backgroundColor.value
    }
    
    private func layoutElements() {
        layoutCatsListCollectionView()
    }
    
    private func layoutCatsListCollectionView() {
        addSubview(catsListCollectionView)
        
        NSLayoutConstraint.activate([
            catsListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            catsListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            catsListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            catsListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
