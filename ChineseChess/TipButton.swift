//
//  TipButton.swift
//  ChineseChess
//
//  Created by vip on 16/11/19.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class TipButton: UIButton {

    init(center:CGPoint){
        super.init(frame: CGRect(x: center.x-10, y: center.y-10, width: 20, height: 20))
        installUI()
    }
    
    func installUI()  {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
