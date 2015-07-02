//
//  ViewController.swift
//  Colorful Snake
//
//  Created by mhtran on 6/28/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var backgroundMusic = AVAudioPlayer()
    var gameOverSound = AVAudioPlayer()
    var timer: NSTimer!
    var timerMine: NSTimer!
    var board: Board!
    var snake: Snake!
    var swipeUp: UISwipeGestureRecognizer!
    var swipeDown: UISwipeGestureRecognizer!
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBegin()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func gameBegin() {
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: "tree_theme.png")
        self.view.addSubview(backgroundImageView)
        board = Board(cols: 17, rows: 30, gameVC: self)
        board.showBoard()
        playBackGroundMusic()
        println("board has \(board.cols) colums and \(board.rows) rows.")
        snake = Snake(gameVC: self)
        snake.showSnake()
        board.randomFood()
        timerBegin()
        swipeUp = UISwipeGestureRecognizer(target: self, action: "onSwipeUp")
        swipeDown = UISwipeGestureRecognizer(target: self, action: "onSwipeDown")
        swipeLeft = UISwipeGestureRecognizer(target: self, action: "onSwipeLeft")
        swipeRight = UISwipeGestureRecognizer(target: self, action: "onSwipeRight")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.userInteractionEnabled = true
        self.view.multipleTouchEnabled = true
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func setupAudioPlayWithFile(file:NSString, type:NSString) -> AVAudioPlayer {
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        var errors: NSError?
        var audioPlayer: AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &errors)
        return audioPlayer!
    }
    
    func playBackGroundMusic() {
        backgroundMusic = setupAudioPlayWithFile("background", type: "mp3")
        backgroundMusic.numberOfLoops = -1
        backgroundMusic.play()
    }
    
    func timerBegin() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.13, target: self, selector: "onTime", userInfo: nil, repeats: true)
        timerMine = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "onMineTiming", userInfo: nil, repeats: true)
        timer.fire()
        timerMine.fire()
    }
    
    func onTime() {
        snake.move()
        if snake.checkHeadHitBody() {
            gameOver()
        }
        if snake.checkMine() {
            gameOver()
        }
    }
    
    func onMineTiming() {
//        board.randomMine()
//        board.cells[board.mine.point.col][board.mine.point.row].type = BoardState.Mine
//        UIView.animateWithDuration(5.0, animations: { self.board.mine.alpha = 0 }, completion:{finished in self.board.cells[self.board.mine.point.col][self.board.mine.point.row].type = BoardState.Empty;
//            self.board.mine.removeFromSuperview()
//            println("board.mine = \(self.board.mine.point)")
//        })
    }
    
    func onSwipeUp() {
        if snake.checkTurnUp() {
            snake.moveUp()
        }
    }
    
    func onSwipeDown() {
        if snake.checkTurnDown() {
            snake.moveDown()
        }
    }
    
    func onSwipeLeft() {
        if snake.checkTurnLeft() {
            snake.moveLeft()
        }
    }
    func onSwipeRight() {
        if snake.checkTurnRight() {
            snake.moveRight()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        timerMine.invalidate()
        backgroundMusic.stop()
        snake.body[1].backgroundColor = UIColor.redColor()
        gameOverSound = setupAudioPlayWithFile("game-over", type: "mp3")
        gameOverSound.play()
    }

}

