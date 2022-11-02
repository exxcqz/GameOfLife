//
//  Grid.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

class Grid {
    let size: Int
    var rows: [Row] = []
    
    init(size: Int) {
        self.size = size
    }
    
    func randomizeCells() {
        rows = []
        for y in 0..<size {
            var row = Row(size: size, index: y)
            for x in 0..<size {
                let randomState = arc4random_uniform(5)
                let cell = Cell(x: x, y: y, state: randomState == 0 ? .alive : .dead)
                row.cells.append(cell)
            }
            rows.append(row)
        }
    }
    
    func updateCells() {
        let updatedRows = rows.map { row in
            let cells = row.cells.map { cell in
                let livingNeighborsCount = numberOfNeighbors(x: cell.x, y: cell.y)
                switch livingNeighborsCount {
                case 2...3 where cell.state == .alive:
                    return cell
                case 3 where cell.state == .dead:
                    return Cell(x: cell.x, y: cell.y, state: .alive)
                default:
                    return Cell(x: cell.x, y: cell.y, state: .dead)
                }
            }
            var newRow = Row(size: row.size, index: row.index)
            newRow.cells = cells
            return newRow
        }
        rows = updatedRows
    }
    
    func numberOfNeighbors(x: Int, y: Int) -> Int {
        let neighborFinder: NeighborFinder = .init(grid: self, x: x, y: y)
        var count = 0

        // Top
        if let top = neighborFinder.getTop(), top.isAlive {
            count += 1
        }
        // Top Right
        if let topRight = neighborFinder.getTopRight(), topRight.isAlive {
            count += 1
        }
        // Right
        if let right = neighborFinder.getRight(), right.isAlive {
            count += 1
        }
        // Bottom Right
        if let bottomRight = neighborFinder.getBottomRight(), bottomRight.isAlive {
            count += 1
        }
        // Bottom
        if let bottom = neighborFinder.getBottom(), bottom.isAlive {
            count += 1
        }
        // Bottom Left
        if let bottomLeft = neighborFinder.getBottomLeft(), bottomLeft.isAlive {
            count += 1
        }
        // Left
        if let left = neighborFinder.getLeft(), left.isAlive {
            count += 1
        }
        // Top Left
        if let topLeft = neighborFinder.getTopLeft(), topLeft.isAlive {
            count += 1
        }
        return count
    }
}
