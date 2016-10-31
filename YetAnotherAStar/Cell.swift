//
//  Cell.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 29/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

typealias Coordinates2D = (x: Int, y: Int)


class Cell: CustomStringConvertible, Equatable
{
    let coordinates: Coordinates2D
    let kind: Kind

    var previous: Cell? = nil
    var distanceFromStart: Double = 0
    var distanceToFinish: Double = 0

    static func ==(lhs: Cell, rhs: Cell) -> Bool
    {
        return (lhs.coordinates == rhs.coordinates) && (lhs.kind == rhs.kind)
    }

    var fullDistance: Double {
        return distanceFromStart + distanceToFinish
    }

    init(coordinates: Coordinates2D, kind: Cell.Kind)
    {
        self.coordinates = coordinates
        self.kind = kind
    }

    var description: String {
        return "\(coordinates)"
    }

    enum Kind: CustomStringConvertible {
        case Empty
        case Wall
        case Start
        case Finish

        var traversable: Bool {
            switch self {
            case .Wall: return false
            default: return true
            }
        }

        var description: String {
            switch self {
            case .Empty: return "."
            case .Wall: return "|"
            case .Start: return "S"
            case .Finish: return "F"
            }
        }
    }
}
