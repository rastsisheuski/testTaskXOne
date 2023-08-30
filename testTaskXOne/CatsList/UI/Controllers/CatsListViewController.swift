//
//  CatsListViewController.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import UIKit
import Combine
import SafariServices

final class CatsListViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private methods
    
    private var contentView: CatsListViewControllerView {
        view as! CatsListViewControllerView
    }
    
    private let viewModel: CatsListViewModel
    private let errorPresenter: ErrorPresenter
    private let safariPresenter: SafariPresenter
    private let spinnerNavigationResponder: SpinnerNavigationResponder
    private let descriptionNavigationResponder: DescriptionNavigationResponder
    private var cancellable = Set<AnyCancellable>()
    private var currentPaginationPage: Int = 0
    
    init(viewModel: CatsListViewModel,
         errorPresenter: ErrorPresenter,
         safariPresenter: SafariPresenter,
         spinnerNavigationResponder: SpinnerNavigationResponder,
         descriptionNavigationResponder: DescriptionNavigationResponder) {
        self.viewModel = viewModel
        self.errorPresenter = errorPresenter
        self.safariPresenter = safariPresenter
        self.spinnerNavigationResponder = spinnerNavigationResponder
        self.descriptionNavigationResponder = descriptionNavigationResponder
        super.init()
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = CatsListViewControllerView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        bindViewModel()
        viewModel.getCats(page: currentPaginationPage)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupDelegates() {
        contentView.catsListCollectionView.delegate = self
        contentView.catsListCollectionView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.getCatsListSuccess.receive(on: DispatchQueue.main).sink { [weak self] isGetCatsListSuccess in
            guard let self else { return }
            
            if isGetCatsListSuccess {
                self.contentView.catsListCollectionView.reloadData()
            }
        }.store(in: &cancellable)
        
        viewModel.isLoading.receive(on: DispatchQueue.main).sink { [weak self] isLoading in
            if isLoading {
                self?.spinnerNavigationResponder.showSpinner()
            } else {
                self?.spinnerNavigationResponder.hideSpinner()
            }
        }.store(in: &cancellable)
        
        viewModel.currentPaginationPage.receive(on: DispatchQueue.main).sink { [weak self] paginationPage in
            self?.currentPaginationPage = paginationPage
        }.store(in: &cancellable)
    }
    
    private func calculateDishCollectionViewCellSize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2)
        let cellHeight = cellWidth * Constants.CatsList.collectionViewCellHeightMultiplier
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func openSafariViewController(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        
    }
}
// MARK: -
// MARK: - Extension CatsListViewController + UICollectionViewDataSource

extension CatsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.catsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CatsListCollectionViewCell.self), for: indexPath)
        guard let catsListCell = cell as? CatsListCollectionViewCell else { return cell }
        
        guard let currentCat = viewModel.catsList?[indexPath.row] else { return cell }
        
        catsListCell.set(for: currentCat)
        return catsListCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cats = viewModel.catsList {
            if indexPath.row == cats.count - 2 {
                viewModel.getCats(page: currentPaginationPage)
            }
        }
    }
}

// MARK: -
// MARK: - Extension CatsListViewController + UICollectionViewDelegateFlowLayout

extension CatsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateDishCollectionViewCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        if let cats = viewModel.catsList {
            let selectedCat = cats[selectedIndex]
            guard let urlString = selectedCat.wikipediaURLString else { return }
            
            safariPresenter.showSafari(on: self, urlString: urlString)
        }
    }
}

// MARK: -
// MARK: - Extension CatsListViewController + SFSafariViewControllerDelegate

extension CatsListViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        safariPresenter.dismissSafari(on: self)
    }
}
