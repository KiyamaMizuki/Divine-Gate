//
//  PanelBase.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class PanelGenerate: SKSpriteNode {
//    Panel belong_panel;
    var x: Int;
    var y: Int;
    var width: Int;
    var height: Int;
    var pal: Panel?;//パネルクラスのインスタンス生成
    let screenwidth = UIScreen.main.bounds.size.width//スマホの横幅
    //lazy var pal = Panel?(width: Int(panelwidth), height: Int(panelwidth))//lazyプロパティにすることで遅延して初期化する　またオプショナル型にしたい
    init(){
        var size :Int = Int(screenwidth)
        self.x = 15;
        self.y = 15;
        self.width = size/5;//パネルの横タップ判定
        self.height = size/5;//パネルの縦タップ判定

        super.init(texture: SKTexture(imageNamed: "frame_panel"), color: UIColor.clear, size: CGSize(width: size/5, height: size/5));//ジェネレータの情報
        self.position = CGPoint(x: 15, y: 15);
                
    }
    
    func generate() {
        
        var size :Int = Int(screenwidth)
        let type_list = ["fire","water","wind","dark","light"];
        var len  = type_list.count;
        var ran = Int.random(in:0..<len);
        //self.pal = Panel(type:type_list[ran]);
        self.pal = Panel(type: type_list[ran], panelwidth: size, panelheight:size)
        self.pal!.setPosition(x: self.x, y:self.y);
        self.pal!.zPosition = self.zPosition + 3;
    }
    
    func contain(touchX: Int, touchY:Int) -> Bool{
        if (self.x - width/2 < touchX && touchX < self.x + width/2 && self.y - height/2 < touchY && touchY < self.y + height / 2){
            return true;
        }
        else{
            return false;
        }
    }
    
    func setpoint(x:Int, y:Int) {
        self.x = x;
        self.y = y;
//        let z : Int = -10
        self.position = CGPoint(x: self.x, y: self.y);
//        self.zPosition = CGFloat(z);
        
    }
    
    func destroyPanel(){
        self.pal = nil;//palはまだオプショナル型じゃないからnil入らんw
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
