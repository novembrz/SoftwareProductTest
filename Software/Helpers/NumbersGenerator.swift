//
//  NumbersGenerator.swift
//  Software
//
//  Created by Дарья on 26.01.2021.
//

import Foundation
import BigInt

struct NumbersGenerator {
    
    static func getFibonacci(array: [BigInt], completion: (BigInt) -> ()){
        let preLast = array[array.count - 2]
        let last = array[array.count - 1]
        
        let newNumber = last + preLast
        completion(newNumber)
    }
    
    static func getSimple(el: BigInt, completion: (BigInt) -> ()) {
        if isPrime(el) {
            completion(el)
        }
    }
    
    static func isPrime(_ num: BigInt) -> Bool {
        let max = BigInt(floor(sqrt(Double(num))))
        guard max >= 2 else { return true }

        for factor in 2...max {
            if num.isMultiple(of: factor) {
                return false
            }
        }
        return true
    }
}
