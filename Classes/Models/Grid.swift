//
//  Grid.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

class Grid {
    let size: Int
    var cells: [Cell] = []
    
    init(size: Int) {
        self.size = size
    }
    
    func randomizeCells() {
        cells = []
        for x in 0..<size {
            for y in 0..<size {
                let randomState = arc4random_uniform(5)
                let cell = Cell(x: x, y: y, state: randomState == 0 ? .alive : .dead)
                cells.append(cell)
            }
        }
    }
    
    func updateCells() {
        var updatedCells: [Cell] = []
        let liveCells = cells.filter { $0.state == .alive }
        for cell in cells {
            var livingNeighborsCount = 0
            for liveCell in liveCells {
                if livingNeighborsCount > 3 {
                    break
                }
                if liveCell.isNeighbor(to: cell) {
                    livingNeighborsCount += 1
                }
            }

            switch livingNeighborsCount {
            case 2...3 where cell.state == .alive:
                updatedCells.append(cell)
            case 3 where cell.state == .dead:
                let liveCell = Cell(x: cell.x, y: cell.y, state: .alive)
                updatedCells.append(liveCell)
            default:
                let deadCell = Cell(x: cell.x, y: cell.y, state: .dead)
                updatedCells.append(deadCell)
            }
        }
        cells = updatedCells
    }
}
