//
//  search.swift
//  Divine-Gate
//
//  Created by 木山瑞基 on 2019/12/14.
//  Copyright © 2019 宮里　佳音. All rights reserved.

import Foundation
import UIKit
import SpriteKit
class Search: SKSpriteNode {
//    init(imageNamed: String){
//        super.init(imageNamed: imageNamed);
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var gameScene: SKScene!
    var Danger: String!
    var image_path: String!
    
    func setScene(scene: SKScene){
        self.gameScene = scene
    }
    
    func setType(){
        // fire water wind light dark
        switch self.Danger{
        case "unknown":
            self.image_path = "search_panel";
        case "risk_1":
            self.image_path = "blue_panel";
        case "risk_2":
            self.image_path = "green_panel";
        case "risk_3":
            self.image_path = "purple_panel";
        case "risk_4":
            self.image_path = "yellow_panel";
        case "risk_5":
            self.image_path = "red_panel";
        case .none:
            print("none");
        case .some(_):
            print("some");
        }
    }
    
    init(Danger : String,panelwidth : Int,panelheight : Int){
        
        super.init(texture: SKTexture(imageNamed: "search_panel"), color: UIColor.clear, size: CGSize(width: panelwidth/5, height: panelheight/5));
        self.position = CGPoint(x: 15, y: 15)//生成した後座標を変更している
        self.Danger = Danger;
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
