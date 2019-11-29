//
//  PanelContainer.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/28.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit;

class PanelContainer: SKSpriteNode {
    
    var panels : [Panel] = []
    
    var MAXLEN : Int = 5;
    
//    Panel belong_panel;
    init(){
        super.init(texture: SKTexture(imageNamed: "Box"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 10, y: 10);
    }
    
    func addPanel(panel : Panel) -> Bool{
//        let reSize = CGSize(width: self.width * 0.5, height: self.size.height * scaleSize)
//        self.scaleImage(scaleSize: 0.5)
        if self.panels.count < MAXLEN{
            self.panels.append(panel)
            panel.zPosition = self.zPosition + 1
            panel.size = CGSize(width:self.size.width/2, height:self.size.height/2)
            switch self.panels.count{
                case 1:
                    panel.setPosition(x: Int(self.position.x - self.size.width/4), y: Int(self.position.y + self.size.height/4))
                    //一番目のパネルを正しい場所に固定する
                case 2:
                    print("２ ")
                    panel.setPosition(x: Int(self.position.x + self.size.width/4), y: Int(self.position.y + self.size.height/4))
                    //一番目のパネルを正しい場所に固定する
                case 3:
                    print("３ ")
                    panel.setPosition(x: Int(self.position.x - self.size.width/4), y: Int(self.position.y - self.size.height/4))
                    //一番目のパネルを正しい場所に固定する
                case 4:
                    print(" ")
                    panel.setPosition(x: Int(self.position.x + self.size.width/4), y: Int(self.position.y - self.size.height/4))
                //一番目のパネルを正しい場所に固定する
                case 5:
                    panel.setPosition(x: Int(self.position.x), y: Int(self.position.y))
                    panel.zPosition = panel.zPosition + 1;
                    print(" ")
                //コンテナに持ってきたパネルを入れる
                //一番目のパネルを正しい場所に固定する
                default:
                    print("ifの段階で弾かれてる")
            }
            return true;
        }else{
            return false;
        }
        
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
