//
//  Heuristic.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 29/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

/// http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
enum Heuristic {

    case Manhattan
    case Euclidean
    case Chebyshev

    func costOfMove(from cell: Cell, toNeighbour neighbour: Cell) -> Double
    {
        // Diagonal moves cost 14, horizontal/vertical moves cost 10
        return ((abs(cell.coordinates.x - neighbour.coordinates.x) > 0 && abs(cell.coordinates.y - neighbour.coordinates.y) > 0) ? 14 : 10)
    }

    func approximateCostOfMoving(from cell: Cell, toEnd end: Cell) -> Double
    {
        switch self {
        case .Manhattan:
            return Double(abs(cell.coordinates.x - end.coordinates.x) + abs(cell.coordinates.y - end.coordinates.y)) * 40
        case .Euclidean:
            return sqrt(pow(Double(cell.coordinates.x - end.coordinates.x), 2) + pow(Double(end.coordinates.y - end.coordinates.y), 2))
        case .Chebyshev:
            let dx = abs(cell.coordinates.x - end.coordinates.x)
            let dy = abs(cell.coordinates.y - end.coordinates.y)
            return Double((dx + dy) - min(dx, dy))
        }
    }
}
