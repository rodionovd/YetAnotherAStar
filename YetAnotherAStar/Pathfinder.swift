//
//  Pathfinder.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 30/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

typealias Path = [Cell]

func findPath(onMap map: Map, usingHeuristic heuristic: Heuristic, strategy: MovingStrategy, logging: Bool = true) -> Path?
{
    var open: [Cell] = []
    var closed: [Cell] = []

    let start = map.start
    let finish = map.finish

    open.append(start)

    var i = 1
    while let current = open.sorted(by: { $0.fullDistance < $1.fullDistance }).first {
        open.remove(at: open.index(of: current)!)
        closed.append(current)

        if (current == finish) {
            return buildPath(upToCell: finish)
        }

        // For every walkable neighbour cell
        for neighbour in neighbours(forCell: current, inMap: map, movingStrategy: strategy) {
            // if this neighbour cell is already in the closed list ignore it
            if closed.contains(neighbour) {
                continue
            }
            // Calculate its G and H values
            let moveCost = heuristic.costOfMove(from: current, toNeighbour: neighbour)
            let hCost = heuristic.approximateCostOfMoving(from: neighbour, toEnd: finish)

            if !open.contains(neighbour) {
                // set this neighbour's G and H, change the previous cell to the current one
                neighbour.previous = current
                neighbour.distanceFromStart = current.distanceFromStart + moveCost
                neighbour.distanceToFinish = hCost
                open.append(neighbour)
            } else if (current.distanceFromStart + moveCost < neighbour.distanceFromStart) {
                // otherwise if using the current cell's G value make this neighbour's F value lower
                // we update its parent because this means a better path
                neighbour.previous = current
                neighbour.distanceFromStart = current.distanceFromStart + moveCost
            }
        }
        if (logging) {
            print("Iteration \(i): ")
            print("\tOpen list: \(open)")
            print("\tClosed list: \(closed)")
            print("")
        }
        i += 1
    }

    return nil
}

private func buildPath(upToCell endCell: Cell) -> Path
{
    var result = [endCell]
    var currentCell = endCell
    while case let prev? = currentCell.previous {
        if !result.contains(prev) {
            result += [prev]
        }
        currentCell = prev
    }
    return result
}

private func neighbours(forCell cell: Cell, inMap map: Map, movingStrategy: MovingStrategy) -> [Cell]
{
    return filterCuttingCorners(moves: movingStrategy.validMoves, fromCell: cell, map: map)
        .flatMap({ map[(cell.coordinates.x + $0.offset.x, cell.coordinates.y + $0.offset.y)] })
        .filter({ $0.kind.traversable })
}

private func filterCuttingCorners(moves: [Move], fromCell cell: Cell, map: Map) -> [Move]
{
    return moves.filter {
        let edges: [Move]
        switch $0 {
        case .UpLeft:
            edges = [.Up, .Left]
        case .UpRight:
            edges = [.Up, .Right]
        case .DownLeft:
            edges = [.Down, .Left]
        case .DownRight:
            edges = [.Down, .Right]
        default:
            edges = []
        }
        return edges
            .flatMap({ map[(cell.coordinates.x + $0.offset.x, cell.coordinates.y + $0.offset.y)] })
            .filter({ $0.kind == .Wall }).count == 0
    }
}
