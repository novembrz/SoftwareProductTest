//
//  NumbersCell.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import UIKit

class NumbersCell: UICollectionViewCell {
    
    static let reuseId = "numberCell"
    
    weak var viewModel: NumbersCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            numberLabel.text = String(viewModel.number)
        }
    }
    
    //MARK: - Create UI
    
    var numberLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .textColor()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cellWhiteColor()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup Constraints
    private func setupConstraints(){
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3)
        ])
    }
    
}
