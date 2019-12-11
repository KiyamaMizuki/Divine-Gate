//
//  ProgressBar.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/11.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import SpriteKit

class ProgressBar: SKCropNode {
    var width : Int = 0;
    var height : Int = 0;
    override init() {
        super.init()
        let sprite = SKSpriteNode(imageNamed: "progressbar")
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        self.width = Int(sprite.size.width)
        self.height = Int(sprite.size.height);
        let maskSprite = SKSpriteNode(color: SKColor.black, size: sprite.size)
        maskSprite.anchorPoint = CGPoint(x: 0, y: 0)
        self.maskNode = maskSprite

        addChild(sprite)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 初期値設定メソッド (0.0 〜 1.0)
    func setProgress(progress: CGFloat) {
        self.maskNode?.xScale = progress
    }

    // プログレスバーの数値を増やすメソッド
    func updateProgress(progress:CGFloat){
        self.maskNode?.xScale += progress
    }
}
