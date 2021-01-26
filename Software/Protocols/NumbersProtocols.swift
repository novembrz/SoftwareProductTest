//
//  NumbersProtocols.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import UIKit

protocol TableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NumbersCellViewModelType?
}

protocol NumbersCellViewModelType: class {
    var number: Int { get }
}
