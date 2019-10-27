//
//  UserInfoManager.swift
//  ChineseChess
//
//  Created by vip on 16/11/16.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
    //获取用户音频设置状态
    class func getAudioState() -> Bool {
        let isOn =  UserDefaults.standard.string(forKey: "audioKey")
        if let on = isOn {
            if on == "on" {
                return true
            }else{
                return false
            }
        }
        return true
    }
    //进行用户音频设置状态的存储
    class func setAudioState(isOn:Bool){
        if isOn {
            UserDefaults.standard.set("on", forKey: "audioKey")
        }else{
            UserDefaults.standard.set("off", forKey: "audioKey")
        }
        UserDefaults.standard.synchronize()
    }
}
