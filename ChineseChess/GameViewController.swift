//
//  GameViewController.swift
//  ChineseChess
//
//  Created by vip on 16/11/17.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,GameEngineDelegate {
    //棋盘
    var  chessBoard:ChessBoard?
    //游戏引擎
    var gameEngine:GameEngine?
    
    var startGameButton:UIButton?
    var settingButton:UIButton?
    var tipLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImageView(image: UIImage(named: "gameBg"))
        bgImage.frame = self.view.frame
        self.view.addSubview(bgImage)
        self.view.backgroundColor = UIColor.white
        chessBoard = ChessBoard(origin: CGPoint(x: 20, y: 80))
        self.view.addSubview(chessBoard!)
        //进行游戏引擎的实例化
        gameEngine = GameEngine(board: chessBoard!)
        gameEngine!.delegate = self
        
        startGameButton = UIButton(type: .system)
        startGameButton?.frame = CGRect(x: 40, y: self.view.frame.size.height-80, width: self.view.frame.size.width/2-80, height: 30)
        startGameButton?.backgroundColor = UIColor.green
        startGameButton?.setTitle("开始游戏", for: .normal)
        startGameButton?.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(startGameButton!)
        startGameButton?.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        settingButton = UIButton(type: .system)
        settingButton?.frame = CGRect(x: self.view.frame.size.width/2+40, y: self.view.frame.size.height-80, width: self.view.frame.size.width/2-80, height: 30)
        settingButton?.setTitle("红方行棋", for: .normal)
        settingButton?.backgroundColor = UIColor.green
        settingButton?.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(settingButton!)
        settingButton?.addTarget(self, action: #selector(settingGame), for: .touchUpInside)
        
        tipLabel.frame = CGRect(x: self.view.frame.size.width/2-100, y: 200, width: 200, height: 60)
        tipLabel.backgroundColor = UIColor.clear
        tipLabel.font = UIFont.systemFont(ofSize: 25)
        tipLabel.textColor = UIColor.red
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
        self.view.addSubview(tipLabel)
    }
    
    func startGame(btn:UIButton){
        tipLabel.isHidden = true
        gameEngine?.startGame()
        settingButton?.backgroundColor = UIColor.gray
        settingButton?.isEnabled = false
        btn.setTitle("重新开局", for: .normal)
    }
    func settingGame(btn:UIButton){
        if btn.title(for: .normal)=="红方行棋" {
            gameEngine?.setRedFirstMove(red: false)
            btn.setTitle("绿方行棋", for: .normal)
        }else{
            gameEngine?.setRedFirstMove(red: true)
            btn.setTitle("红方行棋", for: .normal)
        }
        
    }
    
    func gameOver(redWin:Bool){
        if redWin {
            tipLabel.text = "红方胜"
            tipLabel.textColor = UIColor.red
        }else{
            tipLabel.text = "绿方胜"
            tipLabel.textColor = UIColor.green
        }
        tipLabel.isHidden = false
        settingButton?.isEnabled = true
        settingButton?.backgroundColor=UIColor.green
    }
    func couldRedMove(red: Bool) {
        if red {
            settingButton?.setTitle("红方行棋", for: .normal)
        }else{
            settingButton?.setTitle("绿方行棋", for: .normal)
        }
    }
}
