//
//  Timer.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/01/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class TimerLabel : SKLabelNode{
    
    var begin : NSDate!
    var now : Int!
    var count : Int!
    let max = 6
    var isStop = true;
    var dateFormatter = DateFormatter();//日付と時刻を表現
    
    override init() {
        super.init()
        initLabel()
    }
    
    func start(){
        isStop = false;
        self.begin = NSDate()
    }
    
    func reset(){
        isStop = true
        self.count = self.max
        self.text = String(self.count)
    }
    
    func stop(){
        self.isStop = true;
    }
    
    func update(){
        if !isStop{
            var now = NSDate().timeIntervalSince(self.begin as Date);
            self.now = Int(now)
            self.count = self.max - self.now  // maxとstart関数実行からの経過時間の差
            self.text = String(self.count)
        }
    }
    
    func initLabel(){
        self.count = max;
        
        self.color = UIColor(named: "white");//表示される文字の色?
        self.fontSize = 100;//文字のサイズ
        self.zPosition = 100;//文字のZ座標
        self.fontColor = UIColor.white;//表示される文字の色
        self.position = CGPoint(x: 0, y: 150)//文字の位置を指定
        self.text = String(max)
        self.name = "buttonLabel"
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
