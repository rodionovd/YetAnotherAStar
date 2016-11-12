//
//  MapBuilder.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 30/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

struct MapBuilder {
    let size: (width: Int, height: Int)

    func map(fromStrings strings: [String]) -> Map
    {
        var cells: [[Cell]] = [[]]
        for x in 0..<size.width {
            cells.append([])
            for y in 0..<size.height {
                let row = strings[x]
                cells[x].append(Cell(coordinates: (x, y), kind: Cell.Kind.from(description: row.components(separatedBy: "  ")[y])))
            }
        }
        return Map(cells: cells)
    }

    func randomMap(withStart start: Coordinates2D, finish: Coordinates2D, seed: Int? = nil) -> Map {
        if let actualSeed = seed {
            srand48(actualSeed)
            print("USING SEED: \(actualSeed)")
        } else {
            let s = Int(arc4random_uniform(UInt32.max))
            srand48(s)
            print("USING SEED: \(s)")
        }

        var cells: [[Cell]] = [[]]
        for x in 0..<size.width {
            cells.append([])
            for y in 0..<size.height {
                if ((x,y) == start) {
                    cells[x].append(Cell(coordinates: start, kind: .Start))
                } else if ((x, y) == finish) {
                    cells[x].append(Cell(coordinates: finish, kind: .Finish))
                } else {
                    cells[x].append(randomCell(at: (x, y)))
                }
            }
        }

        return Map(cells: cells)
    }

    private func randomCell(at location: Coordinates2D) -> Cell {
        let guess = Int(drand48() * 4)
        switch guess {
        case 0...2: return Cell(coordinates: location, kind: .Empty)
        case 3: return Cell(coordinates: location, kind: .Wall)
        default:
            fatalError("ಠ_ಠ")
        }
    }
}
