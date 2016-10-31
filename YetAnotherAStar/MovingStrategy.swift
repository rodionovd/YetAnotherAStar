//
//  MovingStrategy.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 29/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

enum MovingStrategy {
    case EverythingAllowed
    case NoDiagonalMoves

    var validMoves: [Move] {
        switch self {
        case .EverythingAllowed:
            return [.Up, .Down, .Left, .Right, .UpLeft, .UpRight, .DownLeft, .DownRight]
        case .NoDiagonalMoves:
            return [.Up, .Down, .Left, .Right]
        }
    }
}

enum Move {
    case Up
    case Down
    case Left
    case Right
    case UpLeft
    case UpRight
    case DownLeft
    case DownRight

    typealias Offset = Coordinates2D
    var offset: Offset {
        switch self {
        case .Up:
            return (0, 1)
        case .Down:
            return (0, -1)
        case .Left:
            return (-1, 0)
        case .Right:
            return (1, 0)
        case .UpLeft:
            return (-1, 1)
        case .UpRight:
            return (1, 1)
        case .DownLeft:
            return (-1, -1)
        case .DownRight:
            return (1, -1)
        }
    }
}
