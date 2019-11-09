//
//  Panel.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class Panel: SKSpriteNode {
//    init(imageNamed: String){
//        super.init(imageNamed: imageNamed);
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var gameScene: SKScene!
    var type: String!
    var image_path: String!
    
    
    func setScene(scene: SKScene){
        self.gameScene = scene
    }
    
    init(){
        super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 15, y: 15);
        
    }
    
    func setPosition(x: Int, y: Int){
        self.position = CGPoint(x: x, y: y);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
