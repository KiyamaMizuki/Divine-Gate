//
//  Enemy.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/08.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
class Enemy: SKSpriteNode{
    
    
        var gameScene: SKScene!
        var type: String!//enemyの属性
        var image_path: String!
        var hpsum: Hpsum!;
        var x : Int;
        var y : Int;
    
        func wounded(damage : Int, type : String){
        //        被ダメージ処理
            self.hpsum.wounded(damage: damage, type: type);
            print("wounded");
        }
        
    
        func setScene(scene: SKScene){
            self.gameScene = scene
        }
    init(type : String,enemywidth : Int,enemyheight : Int,image_path: String){
            self.x = 100;
            self.y = 150;
            self.image_path = image_path;
            super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: enemywidth/2, height: enemyheight/2));
            self.position = CGPoint(x: self.x, y: self.y)
            self.type = type;
            self.texture = SKTexture(imageNamed: self.image_path)
            self.setPosition(x: self.x, y:self.y);//!は実行する時になるとエラーを吐く。
            self.zPosition = self.zPosition + 3;
        }

        func setType(){
            // fire water wind light dark
            switch self.type{
            case "fire":
                self.image_path = "red_panel";
            case "water":
                self.image_path = "blue_panel";
            case "wind":
                self.image_path = "green_panel";
            case "dark":
                self.image_path = "purple_panel";
            case "light":
                self.image_path = "yellow_panel";
            case .none:
                print("none");
            case .some(_):
                print("some");
            }
        }
        
        
        func setPosition(x: Int, y: Int){
            self.position = CGPoint(x: x, y: y);
            //ポジション
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
