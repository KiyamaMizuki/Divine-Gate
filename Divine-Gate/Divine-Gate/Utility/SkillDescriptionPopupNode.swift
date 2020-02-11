//
//  SkillDescriptionPopupNode.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/01/15.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class SkillDescriptionPopupNode : SKSpriteNode{
    var content : String!;
    var label : SKLabelNode!;
    
    init(content: String){
        self.content = content;
        super.init(texture: SKTexture(imageNamed: "frame_panel"), color: UIColor.gray, size: CGSize(width : 500, height : 500))
        self.label = SKLabelNode();
        self.label.text = content
        self.label.numberOfLines = 0;
        self.label.fontName = "Helvetica Bold"
        self.label.zPosition = self.zPosition + 1;
        self.addChild(self.label);
        self.zPosition = 100;
        self.isUserInteractionEnabled = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
