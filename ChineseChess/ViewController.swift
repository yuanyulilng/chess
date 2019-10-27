//
//  ViewController.swift
//  ChineseChess
//
//  Created by vip on 16/11/16.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //从StoryBoard关联进来的视图控件
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserInfoManager.getAudioState() {
            musicButton.setTitle("音乐:开", for: .normal)
            MusicEngine.sharedInstance.playBackgroundMusic()
        }else{
            musicButton.setTitle("音乐:关", for: .normal)
            MusicEngine.sharedInstance.stopBackgroundMusic()
        }
    }
    //从StoryBoard关联进来的功能按钮触发方法
    @IBAction func startGmaeClick(_ sender: UIButton) {
        let gameController = GameViewController()
        self.present(gameController, animated: true, completion: nil)
    }
    @IBAction func musicButtonClick(_ sender: UIButton) {
        if UserInfoManager.getAudioState() {
            musicButton.setTitle("音乐:关", for: .normal)
            UserInfoManager.setAudioState(isOn:false)
            MusicEngine.sharedInstance.stopBackgroundMusic()
        }else{
            musicButton.setTitle("音乐:开", for: .normal)
            UserInfoManager.setAudioState(isOn:true)
            MusicEngine.sharedInstance.playBackgroundMusic()
        }
    }

}

