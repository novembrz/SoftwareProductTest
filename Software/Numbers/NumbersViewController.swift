//
//  ViewController.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import UIKit

class NumbersViewController: UIViewController {
    
    var viewModel: NumbersViewModel?
    var isLoading = false

    var collectionView: UICollectionView!
    var segmented = UISegmentedControl(items: ["Фибоначчи", "Простые числа"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cellWhiteColor()
        viewModel = NumbersViewModel()
        setupCollectionView()
        setupNavigationBar()
        loadFibonacciData()
    }
}

// MARK: - Load Fibonacci, Simple Data

extension NumbersViewController {
    
    private func loadFibonacciData(){
        isLoading = false
        viewModel?.loadFibonacciData(min: 0, max: 20) { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.collectionViewLayout.invalidateLayout()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func loadSimpleData(){
        isLoading = false
        viewModel?.loadSimpleData(min: 0, max: 80){ [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.collectionViewLayout.invalidateLayout()
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Create Collection View

extension NumbersViewController {
     
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .cellWhiteColor()

        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NumbersCell.self, forCellWithReuseIdentifier: NumbersCell.reuseId)
    }
}

// MARK: - UICollectionViewDelegate UICollectionViewDataSource

extension NumbersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumbersCell.reuseId, for: indexPath) as? NumbersCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        
        if indexPath.item % 4 == 1 || indexPath.item % 4 == 2 {
            cell!.backgroundColor = .cellWhiteColor()
        } else {
            cell!.backgroundColor = .cellGrayColor()
        }

        return tableViewCell
    }
    
    // MARK: - Loading Process
    
    // Устанавливаем время, когда мы хотим, чтобы при прокрутке загружалось больше данных => загрузит больше данных, когда пользователь увидит 20ю ячейку снизу.
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (viewModel?.numberOfRows())! - 20 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            
            DispatchQueue.main.async {
                if self.segmented.selectedSegmentIndex == 0 {
                    self.viewModel?.loadMoreDataInFibonacci() { [weak self] in
                        self?.collectionView.reloadData()
                    }
                } else if self.segmented.selectedSegmentIndex == 1 {
                    self.viewModel?.loadMoreDataInSimple() { [weak self] in
                        self?.collectionView.reloadData()
                    }
                }
                self.isLoading = false
            }
        }
    }
}

// MARK: - Search Bar & Segmented

extension NumbersViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .cellWhiteColor()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .textColor()
        
        navigationController?.navigationBar.addSubview(segmented)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        
        setupConstraints()
    }

    private func setupConstraints(){
        segmented.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmented.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!),
            segmented.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!)
        ])
    }
}

// MARK: - Segment target


extension NumbersViewController {
    @objc private func segmentAction() {
        if segmented.selectedSegmentIndex == 0 {
            loadFibonacciData()
        } else if segmented.selectedSegmentIndex == 1 {
            loadSimpleData()
        }
    }
}

