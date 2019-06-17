//
//  main.swift
//  Challenge3
//
//  Created by Paulo Andrade on 17/06/2019.
//  Copyright © 2019 Paulo Andrade. All rights reserved.
//

import Foundation

struct Point: CustomStringConvertible {
    let x: Int
    let y: Int
    
    var distanceToOrigin: Double {
        return sqrt(Double(abs(x)*abs(x) + abs(y)*abs(y)))
    }
    var description: String {
        return "(\(x),\(y))"
    }
}

var points = [Point(x: 4, y: 10), Point(x: 50, y: -20), Point(x: 23, y: 11)]

/*
 * use qsort to sort points by distance to origin
 */


print(points)





/*
 * Can you make an extension on Array without resorting to qsort_b which is not available on Linux?
 * hint: check qsort_r
 */


extension Array where Element: Comparable {
    func quicksorted() -> [Element] {
        // TODO
        return []
    }
    
    mutating func quicksort() {
        self = quicksorted()
    }
    
}

var letters = ["a", "c", "b"]
letters.quicksort()

print(letters)
