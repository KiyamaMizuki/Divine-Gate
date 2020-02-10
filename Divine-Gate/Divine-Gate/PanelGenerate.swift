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
    var x: Int = 0;
    var y: Int = 0;
    var width: Int = 0;
    var height: Int = 0;
    var pal: Panel?;//パネルクラスのインスタンス生成
    let screenwidth = UIScreen.main.bounds.size.width//スマホの横幅
    //lazy var pal = Panel?(width: Int(panelwidth), height: Int(panelwidth))//lazyプロパティにすることで遅延して初期化する　またオプショナル型にしたい
//    init(){
////        var size :Int = Int(screenwidth)
//        self.x = 15;
//        self.y = 15;
//        self.width = 121;//パネルの横タップ判定
//        self.height = 121;//パネルの縦タップ判定
//
//        super.init(texture: SKTexture(imageNamed: "frame_panel"), color: UIColor.clear, size: CGSize(width: self.width, height: self.height));//ジェネレータの情報
//        self.position = CGPoint(x: 15, y: 15);
//
//    }
    
    func generate() {
        
        var size :Int = Int(screenwidth)
        let type_list = ["fire","water","wind","dark","light"];
        var len  = type_list.count;
        var ran = Int.random(in:0..<len);
        //self.pal = Panel(type:type_list[ran]);
        self.pal = Panel(type: type_list[ran], panelwidth: Int(self.size.width), panelheight:Int(self.size.height))
        self.pal!.setPosition(x: Int(self.position.x), y:Int(self.position.y));
        self.pal!.zPosition = self.zPosition + 3;
    }
    
    func contain(touchX: Float, touchY:Float) -> Bool{
        if (Float(self.position.x - self.size.width/2) < touchX && touchX < Float(self.position.x + self.size.width/2) && Float(self.position.y - self.size.height/2) < touchY && touchY < Float(self.position.y + self.size.height / 2)){
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
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
