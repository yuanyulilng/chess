//
//  ChessItem.swift
//  ChineseChess
//
//  Created by vip on 16/11/17.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ChessItem: UIButton {

    var selectedState:Bool = false
    var isRed = true
    init(center:CGPoint) {
        //根据屏幕尺寸决定棋子大小
        let screenSize = UIScreen.main.bounds.size
        let itemSize = CGSize(width: (screenSize.width-40)/9-4, height: (screenSize.width-40)/9-4)
        super.init(frame: CGRect(origin: CGPoint(x: center.x-itemSize.width/2, y: center.y-itemSize.width/2), size: itemSize))
        installUI()
    }
    
    func installUI()  {
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = ((UIScreen.main.bounds.size.width-40)/9-4)/2
        self.layer.borderWidth = 0.5
    }
    
    func setTitle(title:String,isOwn:Bool) {
        self.setTitle(title, for: .normal)
        if isOwn {
            self.layer.borderColor = UIColor.red.cgColor
            self.setTitleColor(UIColor.red, for: .normal)
            self.isRed = true
        }else{
            self.layer.borderColor = UIColor.green.cgColor
            self.setTitleColor(UIColor.green, for: .normal)
            self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            self.isRed = false
        }
    }
    
    func setSelectedState()  {
        if !selectedState {
            selectedState = true
            self.backgroundColor = UIColor.purple
        }
        
    }
    
    func setUnselectedState(){
        if selectedState {
            selectedState = false
            self.backgroundColor = UIColor.white
        }
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
