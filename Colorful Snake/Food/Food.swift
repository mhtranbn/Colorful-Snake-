//
//  Food.swift
//  Colorful Snake
//
//  Created by mhtran on 6/28/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit

class Food: Cell {
    var colors = ["#031634", "#033649", "#036564", "#490A3D", "BD1550", "#C44D58", "#4ECDC4", "#556270", "#00A0B0", "#6A4A3C", "#CC333F", "#EB6841", "#6E0E0E", "#030000"]
    init(point: (col: Int, row: Int), cellWidth:CGFloat) {
        super.init(point: point, cellWidth: cellWidth, color: UIColor(hex:colors[Int(arc4random_uniform(UInt32(colors.count)))],alpha:1.0))
        self.layer.cornerRadius = cellWidth * 0.5
   
     }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
