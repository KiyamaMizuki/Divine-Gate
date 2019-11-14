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
    
    func setType(){
        // fire water wind light dark
        switch self.type{
        case "fire":
            self.image_path = "red_panel";
        case "water":
            self.image_path = "blue_panel";
        case "wind":
            self.image_path = "green_panel";
        case .none:
            print("none");
        case .some(_):
            print("some");
        }
    }
    
    init(type : String){
        
        super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 15, y: 15)
        self.type = type;
        self.setType();
        self.texture = SKTexture(imageNamed: self.image_path)
    }
    
    func setPosition(x: Int, y: Int){
        self.position = CGPoint(x: x, y: y);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
