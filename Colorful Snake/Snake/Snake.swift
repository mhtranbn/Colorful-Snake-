//
//  Snake.swift
//  Colorful Snake
//
//  Created by mhtran on 6/29/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Snake {
    var body = [CellSnake]()
    var length: Int = 2
    var gameVC: ViewController
    var head: CellSnake
    var tail: CellSnake
    var parentView: UIView!
    
    var eatSound = AVAudioPlayer()
    
    init(gameVC: ViewController) {
        self.gameVC = gameVC
        self.parentView = gameVC.view
        for cell in 0..<length {
            body.append(CellSnake(point: (0, 0), cellWidth: gameVC.board.cellWidth, parentView: gameVC.view))
        }
        
        head = body[0]
        tail = body[body.count - 1]
        head.image = UIImage(named: "headDown.png")
        tail.image = UIImage(named: "tailDown.png")
        head.direction = .Down
        tail.direction = .Down
        println("Snake length = \(body.count)")
        
        
    }
    
    func showSnake(){
        head.point = (col: 1, row: 2)
        body[1].point = (col: head.point.col, head.point.row - 1)
        for i in 0..<body.count {
            body[i].center = gameVC.board.cells[body[i].point.col][body[i].point.row].center
        }
        
    }
    
    func move() {
        switch head.direction {
        case Direction.Up: moveUp()
        case Direction.Right :moveRight()
        case Direction.Down: moveDown()
        case Direction.Left: moveLeft()
        default: println("moved")
        }
        
        if head.point.col == gameVC.board.food.point.col && head.point.row == gameVC.board.food.point.row {
            NSLog("_____\(head.point.col)")
            NSLog("-----------\(gameVC.board.food.point.col)")
            NSLog("++++++++++++++++\(head.point.row)")
            NSLog("=========================\(gameVC.board.food.point.row)")
            eatFood()
        }
    }
    
    func moveBody() {
        for i in reverse(1..<body.count){
            body[i].point = body[i-1].point
            body[i].center = body[i-1].center
            body[i].direction = body[i-1].direction
            
        }
        switch tail.direction {
        case Direction.Up: tail.image = UIImage(named: "tailUp.png")
        case Direction.Down: tail.image = UIImage(named: "tailDown.png")
        case Direction.Right: tail.image = UIImage(named: "tailRight.png")
        case Direction.Left: tail.image = UIImage(named: "tailLeft.png")
        default: println("tailDirection changed")
        }
    }
    
    func moveUp() {
        head.image = UIImage(named: "headUp.png")
        head.direction = .Up
        moveBody()
        if head.point.row > 0 {
            head.point = (col: head.point.col, head.point.row - 1 )
        }
            else {
                head.point = (col:head.point.col, row:gameVC.board.rows - 1)
            }
            head.center = gameVC.board.cells[head.point.col][head.point.row].center
            
        
    }
    
    func moveDown() {
        head.image = UIImage(named: "headDown.png")
        head.direction = .Down
        moveBody()
        if head.point.row < gameVC.board.rows - 1 {
            head.point = (col: head.point.col, head.point.row + 1)
            
        } else
        {
            head.point = (col: head.point.col, 0)
            
        }
        head.center = gameVC.board.cells[head.point.col][head.point.row].center
    }
    
    func moveRight() {
        head.image = UIImage(named: "headRight.png")
        head.direction = .Right
        moveBody()
        if head.point.col < gameVC.board.cols - 1 {
            head.point = (col: head.point.col + 1, head.point.row )
        } else
        {
            head.point = (col: 0 , head.point.row)
        }
        head.center = gameVC.board.cells[head.point.col][head.point.row].center
    }
    
    func moveLeft() {
        head.image = UIImage(named: "headLeft.png")
        head.direction = .Left
        moveBody()
        if head.point.col > 0 {
            head.point = (col:head.point.col - 1, head.point.row)
        } else {
            head.point = (col:gameVC.board.cols - 1, head.point.row)
        }
        head.center = gameVC.board.cells[head.point.col][head.point.row].center
    }
    
    func checkTurnUp() -> Bool {
        if head.direction == Direction.Right || head.direction == Direction.Left {
            return true
        } else {
            return false
        }
    }
    
    func checkTurnDown() -> Bool {
        if head.direction == Direction.Right || head.direction == Direction.Left {
            return true
        } else {
            return false
        }
    }
    
    func checkTurnLeft() -> Bool {
        if head.direction == Direction.Up || head.direction == Direction.Down {
            return true
        } else {
            return false
        }
    }
    
    func checkTurnRight() -> Bool {
        if head.direction == Direction.Up || head.direction == Direction.Down {
            
            return true
        } else {
            
            return false
        }
    }
    
    func checkHeadHitBody() -> Bool {
        var result = false
        for i in 1..<body.count {
            if head.point.col == body[i].point.col && head.point.row == body[i].point.row {
                result = true
            }
        }
        return result
    }
    
    func checkMine() -> Bool {
        var result = false
        if gameVC.board.cells[head.point.col][head.point.row].type == BoardState.Mine {
            result = true
        }
        return result
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer {
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        var error: NSError?
        var audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        return audioPlayer!
    }
    
    func addFoddToSnake() {
        let newCell = CellSnake(point: (col: 0, row: 0), cellWidth: gameVC.board.cellWidth, parentView: gameVC.view)
        newCell.point = body[1].point
        newCell.direction = body[1].direction
        newCell.center = body[1].center
        newCell.backgroundColor = gameVC.board.food.color
        body.insert(newCell, atIndex: 1)
        for i in 1..<body.count - 1 {
            body[i].point = body[i+1].point
            body[i].direction = body[i+1].direction
            body[i].center = body[i+1].center
        }
        
        switch tail.direction {
        case .Up: tail.point = (col: tail.point.col, tail.point.row + 1)
        case .Down: tail.point = (col:tail.point.col,tail.point.row - 1)
        case .Right: tail.point = (col:tail.point.col - 1,tail.point.row)
        case .Left: tail.point = (col:tail.point.col + 1, tail.point.row)
        default: println("eat!")
        }
        tail.center = gameVC.board.cells[tail.point.col][tail.point.row].center
    }
    
    
    
    func eatFood() {
        gameVC.board.cells[head.point.col][head.point.row].type == BoardState.Empty
        eatSound = setupAudioPlayerWithFile("effect_1", type: "mp3")
        eatSound.play()
        addFoddToSnake()
        gameVC.board.food.removeFromSuperview()
        gameVC.board.randomFood()
        
    }
    
//    func 
    
}