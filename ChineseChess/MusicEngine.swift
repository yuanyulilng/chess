//
//  MusicEngine.swift
//  ChineseChess
//
//  Created by vip on 16/11/16.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import AVFoundation
class MusicEngine: NSObject {
    //音频引擎单例
    static let sharedInstance = MusicEngine()
    //音频播放器
    var player:AVAudioPlayer?
    
    private override init() {
        //获取音频文件 forResource参数为工程中的音频文件名 需要为mp3格式
        let path = Bundle.main.path(forResource: "bgMusic", ofType: "mp3")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        player = try! AVAudioPlayer(data: data)
        //进行音频的预加载
        player?.prepareToPlay()
        //设置音频循环播放次数
        player?.numberOfLoops = -1
    }
    //提供一个开始播放背景音频的方法
    func playBackgroundMusic() {
        if !player!.isPlaying {
            player?.play()
        }
        
    }
    //提供一个停止播放背景音频的方法
    func stopBackgroundMusic() {
        if player!.isPlaying {
             player?.stop()
        }
    }
}
