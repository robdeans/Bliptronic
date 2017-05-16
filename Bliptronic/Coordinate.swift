//
//  Coordinate.swift
//  TTP TicTacToe
//
//  Created by Robert Deans on 4/24/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class Coordinate: Hashable {
    
    var coordinate: (column: Int, row: Int)
    
    init(column: Int, row: Int) {
        self.coordinate = (column, row)
    }
    
    static func == (lhs:Coordinate, rhs: Coordinate) -> Bool {
        return lhs.coordinate == rhs.coordinate    }
    
    // TODO: Is this accurate?
    public var hashValue: Int {
        return self.coordinate.column.hashValue << MemoryLayout<Coordinate>.size ^ self.coordinate.row.hashValue
    }
}
