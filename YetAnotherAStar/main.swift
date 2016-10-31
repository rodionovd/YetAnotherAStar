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


let builder = MapBuilder(size: (10, 15))
let map = builder.randomMap(withStart: (0, 3), finish: (7, 11), seed: nil)
var path: Path? = nil
let time = measureTime {
    path = findPath(onMap: map, usingHeuristic: .Euclidean, strategy: .EverythingAllowed, logging: false)
}
if path == nil {
    print("Can't find a path :(")
} else {
    print("Total path cost: \(path!.first!.distanceFromStart), found in \(time)")
}
draw(map: map, path: path)


// Euclidean vs Manhattan: 1641502282


