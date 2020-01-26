//
//  Panel.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class SearchBorn: SKSpriteNode {

    var gameScene: SKScene!
    var type: String!
    var image_path: String!
    var active_type : String!
    
    func setScene(scene: SKScene){
        self.gameScene = scene
    }
    
    
    init(panelwidth : Int,panelheight : Int){
        
        super.init(texture: SKTexture(imageNamed: "search_panel"), color: UIColor.clear, size: CGSize(width: panelwidth/5, height: panelheight/5));
        self.position = CGPoint(x: 15, y: 15)//生成した後座標を変更している
        self.texture = SKTexture(imageNamed: "born")
    }
    
    func setPosition(x: Int, y: Int){
        self.position = CGPoint(x: x, y: y);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
