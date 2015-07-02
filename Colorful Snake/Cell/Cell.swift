//
//  Cell.swift
//  
//
//  Created by mhtran on 6/28/15.
//
//

import Foundation
import UIKit

class Cell: UIView {
    var point: (col:Int, row: Int)
    var color: UIColor
    var cellWidth: CGFloat
    init(point: (col: Int, row: Int), cellWidth:CGFloat, color: UIColor) {
        self.point = point
        self.color = color
        self.cellWidth = cellWidth
        super.init(frame: CGRect(x:0, y:0, width:cellWidth, height:cellWidth))
        self.backgroundColor = color
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}