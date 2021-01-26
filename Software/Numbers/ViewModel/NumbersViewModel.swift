//
//  NumbersViewModel.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import Foundation

class NumbersViewModel: TableViewViewModelType {
    
    var numbersArray: [Int] = []
    
    //MARK: - Fibonacci Numbers Methods
    
    func loadFibonacciData(min:Int, max: Int, completion: @escaping() -> ()) {
        numbersArray = [1, 2]
        for _ in min...max {
            NumbersGenerator.getFibonacci(array: numbersArray) { [weak self] number in
                self?.numbersArray.append(number)
                completion()
            }
        }
    }
    
    func loadMoreDataInFibonacci(completion: @escaping() -> ()){
        let startFib = self.numbersArray.count
        let endFib = startFib + 20
        
        for _ in startFib...endFib where endFib < 100 {
            NumbersGenerator.getFibonacci(array: numbersArray) { [weak self] number in
                self?.numbersArray.append(number)
                completion()
            }
        }
    }
    
    //MARK: - Simple Numbers Methods
    
    func loadSimpleData(min:Int, max: Int, completion: @escaping() -> ()) {
        numbersArray = []
        for el in min...max {
            NumbersGenerator.getSimple(el: el) { [weak self] number in
                self?.numbersArray.append(number)
                completion()
            }
        }
    }
    
    func loadMoreDataInSimple(completion: @escaping() -> ()){
        let startSimple = self.numbersArray[self.numbersArray.count - 1]
        let endSimple = startSimple + 50
        
        for el in startSimple + 1...endSimple {
            NumbersGenerator.getSimple(el: el) { [weak self] number in
                self?.numbersArray.append(number)
                completion()
            }
        }
    }
    
    //MARK: - Cells Methods
    
    func numberOfRows() -> Int {
        return numbersArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NumbersCellViewModelType? {
        let number = numbersArray[indexPath.row]
        return NumbersCellViewModel(number: number)
    }
    
}
