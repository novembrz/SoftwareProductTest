//
//  NumbersGenerator.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import Foundation

struct NumbersGenerator {
    
    static func getFibonacci(array: [Int], completion: (Int) -> ()){
        let preLast = array[array.count - 2]
        let last = array[array.count - 1]
        
        let newNumber = last + preLast
        completion(newNumber)
    }
    
    static func getSimple(el: Int, completion: (Int) -> ()) {
        if isPrime(el) {
            completion(el)
        }
    }
    
    static func isPrime(_ num: Int) -> Bool {
        let max = Int(floor(sqrt(Double(num))))
        guard max >= 2 else { return true }

        for factor in 2...max {
            if num.isMultiple(of: factor) {
                return false
            }
        }
        return true
    }
}
