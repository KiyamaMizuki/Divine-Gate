//
//  NormalSkill.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class NormalSkill : Skill{
    var requirePanels : Dictionary<String, Int> = [:];
    var ratio : Float = 0.0;
    var toSingle : Bool = false;
    var executable : Bool = false;
    var skillType : String = "";
    
    
    init(requirePanels : Dictionary<String, Int>, ratio : Float, toSingle : Bool, skillType : String, name : String, description : String, type : String, belong : Unit) {
        super.init(name : name, description : description, type : type, belong : belong);
        self.requirePanels = requirePanels;
        self.ratio = ratio;
        self.toSingle = toSingle;
        self.executable = false;
        self.skillType = skillType;
    }
    
    func judgeExecutable(container : PanelContainer) -> Bool{ // containerの持つパネルの情報を見て、実行可能か判断する
//        for container.
        var panelInfo : [String:Int] = container.getType(panel : container.belong_panel);
        var fill_count = 0;
        for key in panelInfo.keys{
            if panelInfo[key]! >= self.requirePanels[key]!{
                fill_count += 1;
                if (fill_count == 5){
                    return true;
                }
            }
            else{
                return false;
            }
        }
        return false;
    }
    
    func execute(hpsum : Hpsum, enemies : [Enemy], enemy_index : Int){ // スキルの効果を実行する
        if skillType == "heal"{ // スキルの種類がもし「回復」であったら
            hpsum.hp += Int(Float(hpsum.full_hp) * ratio);
            if hpsum.hp >= hpsum.full_hp{ // 体力が最大値以上になってしまったら
                hpsum.hp = hpsum.full_hp; // 最大値に合わせる
            }
        }else{ // もし「攻撃」であれば
            var damage : Int = Int(Float(self.belong.attack) * ratio); // damageを与える
            if (self.toSingle){ // もし個人用の攻撃であれば
                enemies[enemy_index].wounded(damage : damage, type : self.type); // 指定したインデックスで相手を攻撃する
            }else{
                for enemy in enemies{ // 敵を一人ずつ見ていく
                    enemy.wounded(damage : damage, type:self.type);
                }
            }
        }
    }
    
}


