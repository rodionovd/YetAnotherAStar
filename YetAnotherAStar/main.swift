//
//  main.swift
//  YetAnotherAStar
//
//  Created by Dmitry Rodionov on 30/10/2016.
//  Copyright © 2016 Internals Exposed. All rights reserved.
//

import Foundation

public func measureTime(block: () -> ()) -> Double
{
    let start = Date()
    block()
    let end = Date()
    return end.timeIntervalSince(start)
}

func draw(map: Map, path maybePath: Path?)
{
    for x in 0..<map.cells.count {
        print(map.cells[x].map({
            guard let path = maybePath, path.contains($0) else {
                return "\($0.kind)  "
            }
            if $0.kind == .Empty {
                return "*  "
            }
            return "\($0.kind)  "
        }).joined(separator: ""))
    }
}


let builder = MapBuilder(size: (10, 10))
//let map = builder.randomMap(withStart: (2, 4), finish: (9, 6), seed: 1920917412)
//let map = builder.map(fromStrings: [
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  |  F  .",
//    ".  .  .  .  .  .  .  |  .  .",
//    ".  .  .  .  .  S  .  |  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  ."
//])

//let map = builder.map(fromStrings: [
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  |  .  .  .",
//    ".  .  .  S  .  .  |  .  .  .",
//    ".  .  .  .  .  .  |  F  .  ."
//])
let map = builder.map(fromStrings: [
    ".  .  .  .  .  .  .  .  .  .",
    ".  .  .  .  .  .  .  .  .  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  S  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  .",
    ".  .  .  .  .  .  .  .  |  F"
])

var path: Path? = nil
let time = measureTime {
    path = findPath(onMap: map, usingHeuristic: .Manhattan, strategy: .EverythingAllowed, logging: true)
}
// [(8, 3), (9, 4), (9, 5), (8, 5), (8, 4), (7, 5), (7, 4), (6, 5), (6, 6), (6, 7), (7, 7), (8, 7)]
if path == nil {
    print("Can't find a path :(")
} else {
    print("Total path cost: \(path!.first!.distanceFromStart), found in \(time)s\n")
}
draw(map: map, path: path)


// Euclidean vs Manhattan: 1641502282


//let map = builder.map(fromStrings: [
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  .",
//    ".  .  .  .  .  .  .  .  .  ."
//])

