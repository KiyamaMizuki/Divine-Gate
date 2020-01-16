//
//  SkillView.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/15.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class SkillView : SKSpriteNode{ // skillの表示を担う
    var normalSkill: BattleNormalSkill; // 保持しているノーマルスキル
    var x,y : Int!;
    var width, height : Int!;
    var image_path : String = "";
    
    
    init(viewWidth : Int,viewHeight : Int, normalSkill : BattleNormalSkill){
        self.normalSkill = normalSkill;
        super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: viewWidth, height: viewHeight)); // viewのサイズとともに描画
        self.position = CGPoint(x: 15, y: 15)//生成した後座標を設定
        self.x = 15;
        self.y = 15;
        self.width = viewWidth;
        self.height = viewHeight;
        self.setType(type: normalSkill.type) // タイプごとにセットするimageを変更
        self.texture = SKTexture(imageNamed: self.image_path) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setType(type: String){ // setter メソッドの役割と、画像のセットの役割を同時に担う
        // fire water wind light dark
        switch type{
            case "fire":
                self.image_path = "red_skill";
            case "water":
                self.image_path = "blue_skill";
            case "wind":
                self.image_path = "green_skill";
            case "dark":
                self.image_path = "purple_skill";
            case "light":
                self.image_path = "yellow_skill";
            default:
                self.image_path = "";
        }
    }
    
    // タイプによって色の表示を帰る
    
    func setSize(width:Int, height:Int){
        self.width = width;
        self.height = height;
        self.size = CGSize(width: width, height: height)
    }
    
    func setPosition(x : Int, y : Int){
        self.x = x;
        self.y = y;
        self.position = CGPoint(x:self.x, y:self.y);
    }
    
    
}
