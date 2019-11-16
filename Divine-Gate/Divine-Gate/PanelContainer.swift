//
//  PanelContainer.swift
//  Divine-Gate
//
//  Created by 木山瑞基 on 2019/11/16.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class PanelContainer: SKSpriteNode {
    
    var panels : [Panel];
    
//    Panel belong_panel;
    init(){
        super.init(texture: SKTexture(imageNamed: "Box"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 100, y: 100);
    }
    
    func addPanel(panel : Panel){
//        let reSize = CGSize(width: self.width * 0.5, height: self.size.height * scaleSize)
//        self.scaleImage(scaleSize: 0.5)
        panel.size = CGSize(width: self.size.width * 0.5, height: self.size.height * 0.5);
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
