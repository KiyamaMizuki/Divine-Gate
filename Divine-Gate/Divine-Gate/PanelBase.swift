//
//  PanelBase.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class PanelBase: SKSpriteNode {
//    Panel belong_panel;
    init(){
        super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: 80, height: 20));
        self.position = CGPoint(x: 15, y: 15);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
