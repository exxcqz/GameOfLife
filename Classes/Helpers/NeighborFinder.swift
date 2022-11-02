//
//  NeighborFinder.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

final class NeighborFinder {
    
    let grid: Grid
    var x: Int = 0
    var y: Int = 0

    var rows: [Row] {
        return grid.rows
    }

    var rowIndex: Int {
        return y
    }

    var cellIndex: Int {
        return x
    }
        
    var rightIndex: Int {
        return cellIndex + 1
    }

    var leftIndex : Int {
        return  cellIndex - 1
    }

    var topIndex : Int {
        return  rowIndex - 1
    }

    var bottomIndex : Int {
        return  rowIndex + 1
    }

    init(grid: Grid, x: Int, y: Int) {
        self.grid = grid
        self.x = x
        self.y = y
    }

    func getTop() -> Cell? {
        if topIndex >= 0 && topIndex < rows.count {
            return rows[topIndex].cells[cellIndex]
        }
        return nil
    }
    
    func getTopRight() -> Cell? {
        if topIndex >= 0 &&
            topIndex < rows.count &&
            rightIndex >= 0 &&
            rightIndex < rows[rowIndex].cells.count
        {
            return rows[topIndex].cells[rightIndex]
        }
        return nil
    }
    
    func getRight() -> Cell? {
        if rightIndex >= 0 && rightIndex < rows[rowIndex].cells.count {
            return rows[rowIndex].cells[rightIndex]
        }
        return nil
    }
    
    func getBottomRight() -> Cell? {
        if bottomIndex >= 0 &&
            bottomIndex < rows.count &&
            rightIndex >= 0 &&
            rightIndex < rows[rowIndex].cells.count
        {
            return rows[bottomIndex].cells[rightIndex]
        }
        return nil
    }
    
    func getBottom() -> Cell? {
        if bottomIndex >= 0 && bottomIndex < rows.count {
            return rows[bottomIndex].cells[cellIndex]
        }
        return nil
    }
    
    func getBottomLeft() -> Cell? {
        if bottomIndex >= 0 &&
            bottomIndex < rows.count &&
            leftIndex >= 0 &&
            leftIndex < rows[bottomIndex].cells.count
        {
            return rows[bottomIndex].cells[leftIndex]
        }
        return nil
    }
    
    func getLeft() -> Cell? {
        if leftIndex >= 0 && leftIndex < rows[rowIndex].cells.count {
            return rows[rowIndex].cells[leftIndex]
        }
        return nil
    }
    
    func getTopLeft() -> Cell? {
        if topIndex >= 0 &&
            topIndex < rows.count &&
            leftIndex >= 0 &&
            leftIndex < rows[rowIndex].cells.count
        {
            return rows[topIndex].cells[leftIndex]
        }
        return nil
    }
}
