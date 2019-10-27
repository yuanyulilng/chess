//
//  ChessBoard.swift
//  ChineseChess
//
//  Created by vip on 16/11/17.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit


protocol ChessBoardDelegate {
    func chessItemClick(item:ChessItem)
    func chessMoveEnd()
    func gameOver(redWin:Bool)
}

class ChessBoard: UIView {

    //根据屏幕宽度计算网格大小
    let Width = (UIScreen.main.bounds.size.width-40)/9
    
    let allRedChessItemsName = ["車","馬","相","士","帥","士","相","馬","車","炮","炮","兵","兵","兵","兵","兵"]
    let allGreenChessItemsName = ["车","马","象","仕","将","仕","象","马","车","炮","炮","卒","卒","卒","卒","卒"]
    var currentRedItem = Array<ChessItem>()
    var currentGreenItem = Array<ChessItem>()
    
    var delegate:ChessBoardDelegate?
    var tipButtonArray = Array<TipButton>()
    //当前行棋的棋子可以前进的矩阵位置
    var currentCanMovePosition = Array<(Int,Int)>()
    
    init(origin:CGPoint) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: UIScreen.main.bounds.size.width-40, height: Width*10))
        self.backgroundColor = UIColor(red: 1, green: 252/255.0, blue: 234/255.0, alpha: 1)
        let label1 = UILabel(frame: CGRect(x: Width, y: Width*9/2, width: Width*3, height: Width))
        label1.backgroundColor = UIColor.clear
        label1.text = "楚河"
        let label2 = UILabel(frame: CGRect(x: Width*5, y: Width*9/2, width: Width*3, height: Width))
        label2.backgroundColor = UIColor.clear
        label2.text = "漢界"
        label2.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        self.addSubview(label1)
        self.addSubview(label2)
        reStartGame()
    }
    
    func reStartGame(){
        //清理残局
        currentGreenItem.forEach { (item) in
            item.removeFromSuperview()
        }
        currentRedItem.forEach { (item) in
            item.removeFromSuperview()
        }
        currentRedItem.removeAll()
        currentGreenItem.removeAll()
        tipButtonArray.forEach { (item) in
            item.removeFromSuperview()
        }
        tipButtonArray.removeAll()
        
        self.cancelAllSelect()
        
           //棋子布局
        var redItem:ChessItem?
        var greenItem:ChessItem?
        for index in 0..<16 {
            if index<9 {
                //红方布局
                redItem = ChessItem(center: CGPoint(x: Width/2+Width*CGFloat(index), y: Width*10-Width/2))
                redItem!.setTitle(title: allRedChessItemsName[index], isOwn: true)
                
                //绿方布局
                greenItem = ChessItem(center: CGPoint(x: Width/2+Width*CGFloat(index), y: Width/2))
                greenItem!.setTitle(title: allGreenChessItemsName[index], isOwn: false)
            }else if index<11 {
                if index==9 {
                    redItem = ChessItem(center: CGPoint(x: Width/2+Width, y: Width*10-Width/2-Width*2))
                    redItem!.setTitle(title: allRedChessItemsName[index], isOwn: true)
                    greenItem = ChessItem(center: CGPoint(x: Width/2+Width, y: Width/2+Width*2))
                    greenItem!.setTitle(title: allGreenChessItemsName[index], isOwn: false)
                }else{
                    redItem = ChessItem(center: CGPoint(x: Width*9-Width/2-Width, y: Width*10-Width/2-Width*2))
                    redItem!.setTitle(title: allRedChessItemsName[index], isOwn: true)
                    greenItem = ChessItem(center: CGPoint(x: Width*9-Width/2-Width, y: Width/2+Width*2))
                    greenItem!.setTitle(title: allGreenChessItemsName[index], isOwn: false)
                }
            }else{
                //红方布局
                redItem = ChessItem(center: CGPoint(x: Width/2+Width*2*CGFloat(index-11), y: Width*10-Width/2-Width*3))
                redItem!.setTitle(title: allRedChessItemsName[index], isOwn: true)
                //绿方布局
                greenItem = ChessItem(center: CGPoint(x: Width/2+Width*2*CGFloat(index-11), y: Width/2+Width*3))
                greenItem!.setTitle(title: allGreenChessItemsName[index], isOwn: false)
            }
            self.addSubview(redItem!)
            self.addSubview(greenItem!)
            currentRedItem.append(redItem!)
            currentGreenItem.append(greenItem!)
            redItem?.addTarget(self, action: #selector(itemClick), for: .touchUpInside)
            greenItem?.addTarget(self, action: #selector(itemClick), for: .touchUpInside)
        }
        
    }
    func itemClick(item:ChessItem){
        if delegate != nil {
            delegate?.chessItemClick(item: item)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(0.5)
        for index in 0...9 {
            context?.move(to: CGPoint(x: Width/2, y:Width/2+Width*CGFloat(index)))
            context?.addLine(to: CGPoint(x: rect.size.width-Width/2, y:Width/2+Width*CGFloat(index)))
            context?.drawPath(using: .stroke)
        }
        for index in 0..<9 {
            if index==0 || index==8 {
                context?.move(to: CGPoint(x: Width/2+Width*CGFloat(index), y: Width/2))
                context?.addLine(to: CGPoint(x: Width*CGFloat(index)+Width/2, y: rect.size.height-Width/2))
            }else{
                context?.move(to: CGPoint(x: Width/2+Width*CGFloat(index), y: Width/2))
                context?.addLine(to: CGPoint(x: Width*CGFloat(index)+Width/2, y: rect.size.height/2-Width/2))
                context?.move(to: CGPoint(x: Width/2+Width*CGFloat(index), y: rect.size.height/2+Width/2))
                context?.addLine(to: CGPoint(x: Width*CGFloat(index)+Width/2, y: rect.size.height-Width/2))
            }
        }
        context?.move(to: CGPoint(x: Width/2+Width*3, y: Width/2))
        context?.addLine(to: CGPoint(x:  Width/2+Width*5, y: Width/2+Width*2))
        context?.move(to: CGPoint(x: Width/2+Width*5, y: Width/2))
        context?.addLine(to: CGPoint(x:  Width/2+Width*3, y: Width/2+Width*2))
        context?.move(to: CGPoint(x: Width/2+Width*3, y: Width*10-Width/2))
        context?.addLine(to: CGPoint(x:  Width/2+Width*5, y: Width*10-Width/2-Width*2))
        context?.move(to: CGPoint(x: Width/2+Width*5, y:Width*10-Width/2))
        context?.addLine(to: CGPoint(x:  Width/2+Width*3, y: Width*10-Width/2-Width*2))
        context?.drawPath(using: .stroke)
        
    }
    
    
    //取消所有棋子的选中
    func cancelAllSelect()  {
        currentRedItem.forEach { (item) in
            item.setUnselectedState()
        }
        currentGreenItem.forEach { (item) in
            item.setUnselectedState()
        }
    }
    //将棋子坐标映射为二维矩阵中的点
    func transfromPositionToMatrix(item:ChessItem) -> (Int,Int) {
        let res =  (Int(item.center.x-Width/2)/Int(Width),Int(item.center.y-Width/2)/Int(Width))
        return res
    }
    //获取所有红方棋子的矩阵数组
    func getAllRedMstrixList()->[(Int,Int)] {
        var list = Array<(Int,Int)>()
        currentRedItem.forEach { (item) in
            list.append(self.transfromPositionToMatrix(item: item))
        }
        return list
    }
    //获取素有绿方棋子的矩阵数组
    func getAllGreenMstrixList()->[(Int,Int)] {
        var list = Array<(Int,Int)>()
        currentGreenItem.forEach { (item) in
            list.append(self.transfromPositionToMatrix(item: item))
        }
        return list
    }
    //将可以移动到的位置进行标记
    func wantMoveItem(positions:[(Int,Int)],item:ChessItem)  {
        //如果是红方 如果在路径上有己方棋子，则不能移动
        var list:Array<(Int,Int)>?
        if item.isRed {
            list = getAllRedMstrixList()
        }else{
            list = getAllGreenMstrixList()
        }
        currentCanMovePosition.removeAll()
        positions.forEach { (position) in
            if list!.contains(where: { (pos) -> Bool in
                if pos == position {
                    return true
                }
                return false
            }) {
                
            }else{
                currentCanMovePosition.append(position)
            }
            
        }
        
        //将可以进行前进的位置使用按钮进行标记
        tipButtonArray.forEach { (item) in
            item.removeFromSuperview()
        }
        tipButtonArray.removeAll()
        for index in 0..<currentCanMovePosition.count {
            //将矩阵转换成位置坐标
            let position = currentCanMovePosition[index]
            let center = CGPoint(x: CGFloat(position.0)*Width+Width/2, y: CGFloat(position.1)*Width+Width/2)
            let tip = TipButton(center: center)
            tip.addTarget(self, action: #selector(moveItem), for: .touchUpInside)
            tip.tag = 100+index
            self.addSubview(tip)
            tipButtonArray.append(tip)
        }
        
        
    }
    func moveItem(tipButton:TipButton) {
        //得到要移动到的位置
        let position = currentCanMovePosition[tipButton.tag-100]
        //转换成坐标
        let point = CGPoint(x: CGFloat(position.0)*Width+Width/2, y: CGFloat(position.1)*Width+Width/2)
        //找到被选中的棋子
        var isRed:Bool?
        currentRedItem.forEach { (item) in
            if item.selectedState {
                isRed = true
                //进行动画移动
                UIView.animate(withDuration: 0.3, animations: { 
                    item.center = point
                })
            }
        }
        currentGreenItem.forEach { (item) in
            if item.selectedState {
                isRed = false
                //进行动画移动
                UIView.animate(withDuration: 0.3, animations: {
                    item.center = point
                })
            }
        }
        //检查是否有地方棋子 如果有 进行吃子
        var shouldDeleteItem:ChessItem?
        if isRed! {
            currentGreenItem.forEach({ (item) in
                if transfromPositionToMatrix(item: item) == position {
                    shouldDeleteItem = item
                }
            })
        }else{
            currentRedItem.forEach({ (item) in
                if transfromPositionToMatrix(item: item) == position {
                    shouldDeleteItem = item
                }
            })
        }
        if let it = shouldDeleteItem {
            it.removeFromSuperview()
            if  isRed!{
                currentGreenItem.remove(at: currentGreenItem.index(of: it)!)
            }else{
                currentRedItem.remove(at: currentRedItem.index(of: it)!)
            }
            if it.title(for: .normal) == "将"{
                if delegate != nil {
                    delegate!.gameOver(redWin: true)
                }
            }
            if it.title(for: .normal) == "帥"{
                if delegate != nil {
                    delegate!.gameOver(redWin: false)
                }
            }
        }
        tipButtonArray.forEach { (item) in
            item.removeFromSuperview()
        }
        tipButtonArray.removeAll()
        if delegate != nil {
            delegate?.chessMoveEnd()
        }
    }
 

}
