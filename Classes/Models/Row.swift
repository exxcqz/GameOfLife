//
//  Row.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

struct Row {
    let size: Int
    var index: Int
    var cells: [Cell] = []
    
    init(size: Int, index: Int) {
        self.size = size
        self.index = index
    }
}
