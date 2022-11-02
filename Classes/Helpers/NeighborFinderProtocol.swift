//
//  NeighborFinderProtocol.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import Foundation

protocol NeighborFinderProtocol {
    func getTop() -> Cell?
    func getTopRight() -> Cell?
    func getRight() -> Cell?
    func getBottomRight() -> Cell?
    func getBottom() -> Cell?
    func getBottomLeft() -> Cell?
    func getLeft() -> Cell?
    func getTopLeft() -> Cell?
}
