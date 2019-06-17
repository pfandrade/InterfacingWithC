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

qsort(&points, points.count, MemoryLayout<Point>.stride) { (ptr1, ptr2) -> Int32 in
    let p1 = ptr1!.load(as: Point.self)
    let p2 = ptr2!.load(as: Point.self)
    return Int32(p1.distanceToOrigin) - Int32(p2.distanceToOrigin)
}

print(points)





/*
 * Can you make an extension on Array without resorting to qsort_b which is not available on Linux?
 * hint: check qsort_r
 */

extension Comparable {
    static func compareRawPointers(l: UnsafeRawPointer, _ r: UnsafeRawPointer) -> Int32 {
        let left: Self = l.load(as: Self.self)
        let right: Self = r.load(as: Self.self)
        if left < right { return -1 }
        if left == right { return 0 }
        return 1
    }
    
}

typealias CompareFunction = (UnsafeRawPointer, UnsafeRawPointer) -> Int32

func globalCompare(thunk: UnsafeMutableRawPointer?, l: UnsafeRawPointer?, r: UnsafeRawPointer?) -> Int32 {
    let compare = thunk!.load(as: CompareFunction.self)
    return compare(l!,r!)
}

extension Array where Element: Comparable {
    func quicksorted() -> [Element] {
        var array = self
        var compare = Element.compareRawPointers
        qsort_r(&array, array.count, MemoryLayout<Element>.stride, &compare, globalCompare)
        return array
    }
    
    mutating func quicksort() {
        self = quicksorted()
    }
    
}

var letters = ["a", "c", "b"]
letters.quicksort()

print(letters)
