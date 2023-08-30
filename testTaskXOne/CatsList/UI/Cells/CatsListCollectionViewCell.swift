//
//  CatsListCollectionViewCell.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 30.08.23.
//

import UIKit
import SDWebImage

final class CatsListCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppImages.defaultCatImage.value
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var catTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = AppColors.mainTextColor.value
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var selectedCat: Cat?
    
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
    // MARK: - PublicMethods
    
    func set(for selectedCat: Cat) {
        guard let imageUrlString = selectedCat.catImageURLString else { return }
        catTitle.text = selectedCat.breed
        setupImageView(with: URL(string: imageUrlString))
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupImageView(with url: URL?) {
        self.catImageView.sd_setImage(with: url, placeholderImage: AppImages.defaultCatImage.value)
    }
    
    private func setupUI() {
        mainView.backgroundColor = .red
    }
    
    private func layoutElements() {
        layoutMainView()
        layoutCatImageView()
        layoutCatTitle()
    }
    
    private func layoutMainView() {
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.CatsList.collectionPadding),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.CatsList.collectionPadding),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.CatsList.collectionPadding),
            mainView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.CatsList.collectionPadding)
        ])
    }
    
    private func layoutCatImageView() {
        mainView.addSubview(catImageView)
        
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            catImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            catImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            catImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30)
        ])
    }
    
    private func layoutCatTitle() {
        mainView.addSubview(catTitle)
        
        NSLayoutConstraint.activate([
            catTitle.topAnchor.constraint(equalTo: catImageView.bottomAnchor),
            catTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            catTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            catTitle.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
