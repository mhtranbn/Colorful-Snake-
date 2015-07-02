//
//  Board.swift
//  Colorful Snake
//
//  Created by mhtran on 6/28/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit

class Board {
    var cols: Int
    var rows: Int
    var gameVC: ViewController
    var parentView: UIView
    var cellWidth: CGFloat
    var cells = [[CellBoard]]()
    var food: Food!
    var mine: Mine!
    
    init(cols:Int, rows: Int, gameVC: ViewController) {
        self.gameVC = gameVC
        self.cols = cols
        self.rows = rows
        self.parentView = gameVC.view
        cellWidth = sqrt((parentView.frame.width * parentView.frame.height) / CGFloat(cols * rows))
    }
    
    func showBoard() {
        for col in 0..<cols {
            var colsArray = [CellBoard]()
            for row in 0..<rows {
                let cell = CellBoard(type: BoardState.Empty, point: (col, row), cellWidth: cellWidth, color: UIColor.clearColor())
                cell.frame = CGRect(x: CGFloat(col) * cellWidth, y: CGFloat(row) * cellWidth, width: cellWidth, height: cellWidth)
                cell.color = UIColor.clearColor()
                    parentView.addSubview(cell)
                    colsArray.append(cell)
            }
            cells.append(colsArray)
        }
        println("board.CellWidth = \(cellWidth)")
        println("Board has \(cols) columns and \(rows) and framwBoard is \(parentView.frame)!")
        
    }
    
    func checkRandomPointWithSnake(randomPoint: (col: Int, row: Int), snake:Snake) -> Bool {
        var result = false
        for cellSnake in snake.body {
            if cellSnake.point.col == randomPoint.col && cellSnake.point.row == randomPoint.row {
                result = true
            }
        }
        return result
    }
    
    func randomPointOnboard() -> (col:Int, row: Int) {
        var randomPonit = (col:Int(arc4random_uniform(UInt32(cols))),row: Int(arc4random_uniform(UInt32(rows))))
        if !checkRandomPointWithSnake(randomPonit, snake: gameVC.snake) && cells[randomPonit.col][randomPonit.row].type == BoardState.Empty {
            return randomPonit
        } else {
            return randomPointOnboard()
        }
    }
    
    func randomFood() {
        let randomPoint = randomPointOnboard()
        food = Food(point: randomPoint, cellWidth: gameVC.board.cellWidth)
        food.center = cells[randomPoint.col][randomPoint.row].center
        cells[randomPoint.col][randomPoint.row].type = BoardState.Food
        parentView.addSubview(food)
    }
}