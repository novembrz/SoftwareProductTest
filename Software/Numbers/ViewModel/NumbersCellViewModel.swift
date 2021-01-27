//
//  NumbersCellViewModel.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import UIKit
import BigInt

class NumbersCellViewModel: NumbersCellViewModelType {
    var number: BigInt
    
    init(number: BigInt) {
        self.number = number
    }
}
