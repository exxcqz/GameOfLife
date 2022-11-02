//
//  GridView.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import UIKit

final class GridView: UIView {
    
    private let grid: Grid

    private var cellSize: CGSize {
        .init(width: frame.width / CGFloat(grid.size), height: frame.height / CGFloat(grid.size))
    }
    
    init(grid: Grid) {
        self.grid = grid
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        for cell in grid.cells {
            let rect = CGRect(x: .init(CGFloat(cell.x) * cellSize.width),
                              y: .init(CGFloat(cell.y) * cellSize.height),
                              width: cellSize.width,
                              height: cellSize.height)
            let color = cell.state == .alive ? UIColor.black.cgColor : UIColor.white.cgColor
            context?.addRect(rect)
            context?.setFillColor(color)
            context?.fill(rect)
        }
        context?.restoreGState()
    }
    
    private func setup() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 6
    }
}