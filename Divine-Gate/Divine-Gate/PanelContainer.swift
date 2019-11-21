//
//  PanelContainer.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/11/16.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class PanelContainer: SKSpriteNode {
    
    init(){
        
        super.init(texture: SKTexture(imageNamed: "Box"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 30, y: 30)
    }
    
    func setPosition(x: Int, y: Int){
        self.position = CGPoint(x: x, y: y);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
