//
//  CellBoard.swift
//  Colorful Snake
//
//  Created by mhtran on 6/28/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit

class CellBoard: Cell {
    var type: BoardState
    init(type: BoardState, point: (col:Int, row:Int), cellWidth:CGFloat,color: UIColor) {
        self.type = type
        super.init(point: point, cellWidth: cellWidth, color: color)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}