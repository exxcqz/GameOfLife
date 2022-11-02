//
//  Cell.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

struct Cell {

    enum State {
        case alive
        case dead
    }
    
    let x: Int
    let y: Int
    var state: State
    
    init(x: Int, y: Int, state: State) {
        self.x = x
        self.y = y
        self.state = state
    }
    
    func isNeighbor(to cell: Cell) -> Bool {
        let xDifference = abs(self.x - cell.x)
        let yDifference = abs(self.y - cell.y)
        switch (xDifference, yDifference) {
        case (1, 1), (0, 1), (1, 0):
            return true
        default:
            return false
        }
    }
}
