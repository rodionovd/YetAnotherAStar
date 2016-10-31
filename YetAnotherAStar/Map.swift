//
//  Map.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 29/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

class Map {
    let cells: [[Cell]]

    init(cells: [[Cell]]) {
        self.cells = cells
    }

    subscript(_ point: (x: Int, y: Int)) -> Cell? {
        guard contains(cellAt: point) else {
            return nil
        }
        return cells[point.x][point.y]
    }

    subscript(x: Int, y: Int) -> Cell? {
        guard contains(cellAt: (x, y)) else {
            return nil
        }
        return cells[x][y]
    }

    var start: Cell {
        return cells.joined().filter({ $0.kind == .Start }).first!
    }

    var finish: Cell {
        return cells.joined().filter({ $0.kind == .Finish }).first!
    }

    func contains(cellAt point: Coordinates2D) -> Bool {
        return cells.joined().contains(where: { $0.coordinates == point})
    }
}
