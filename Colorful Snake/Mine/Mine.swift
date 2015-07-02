//
//  Mine.swift
//  Colorful Snake
//
//  Created by mhtran on 6/28/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit

class Mine: UIImageView {
    var point: (col:Int, row:Int)
    var cellWidth: CGFloat
    init(point: (col:Int, row: Int), cellWidth: CGFloat, parentView: UIView)
    {
        self.point = point
        self.cellWidth = cellWidth
        super.init(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        self.image = UIImage(named: "Mine.png")
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.backgroundColor = UIColor.clearColor()
        parentView.addSubview(self)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}