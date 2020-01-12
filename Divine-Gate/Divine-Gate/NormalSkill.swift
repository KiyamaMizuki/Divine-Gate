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
import RealmSwift

class NormalSkill : Object, Codable {
    @objc dynamic var id : Int = 0;
    @objc dynamic var  ratio : Float = 0.0;//コンボ倍率
    @objc dynamic var toSingle : Bool = false;
    @objc dynamic var executable : Bool = false;//実行可能
    @objc dynamic var skillType : String = "";//スキルの種類(ノーマル、パッシブ)
    @objc dynamic var requirePanels : RequirePanelModel?;//スキル発動に必要なパネルを格納する
    @objc dynamic var name : String = ""
    @objc dynamic var description_c : String = ""
    @objc dynamic var type : String = ""
    var belong : DVUnit?
//    let dvunits = LinkingObjects(fromType: DVUnit.self, property: "normalSkills")

    
    
//    init(requirePanels : Dictionary<String, Int>, ratio : Float, toSingle : Bool, skillType : String, name : String, description_c : String, type : String) {
//        super.init(name : name, description_c : description_c, type : type);
//        self.requirePanels = requirePanels;
//        self.ratio = ratio;
//        self.toSingle = toSingle;
//        self.executable = false;
//        self.skillType = skillType;
//    }
    
    enum CodingKeys: String, CodingKey{
        case requirePanels
        case ratio
        case toSingle
        case executable
        case skillType
        case name
        case description_c
        case type
    }
    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
        super.init();
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requirePanels = try container.decode(RequirePanelModel.self, forKey: .requirePanels)
//        self.requirePanels.fire = requirePanelsDict["fire"]!
//        self.requirePanels.water = requirePanelsDict["water"]!
//        self.requirePanels.wind = requirePanelsDict["wind"]!
//        self.requirePanels.light = requirePanelsDict["light"]!
//        self.requirePanels.dark = requirePanelsDict["dark"]!
        self.ratio = try container.decode(Float.self, forKey: .ratio)
        self.toSingle = try container.decode(Bool.self, forKey: .toSingle)
        self.executable = try container.decode(Bool.self, forKey: .executable)
        self.skillType = try container.decode(String.self, forKey: .skillType)
        self.name = try container.decode(String.self, forKey: .name)
        self.description_c = try container.decode(String.self, forKey: .description_c)
        self.type = try container.decode(String.self, forKey: .type)

    }
    
    required init() {
        
    }
    
    
    
    
//    override required init() {
//        fatalError("init() has not been implemented")
//    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    func judgeExecutable(panelInfo_ : [String:Int]) -> Bool{// containerの持つパネルの情報を見て、実行可能か判断する
//        for container.
        var panelInfo : [String:Int] = panelInfo_//container.getType(panel : container.belong_panel);
        var fill_count = 0;
        for key in panelInfo.keys{
            if panelInfo[key]! >= self.requirePanels!.getNumType(type: key){
                fill_count += 1;
                if (fill_count == panelInfo.keys.count){
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
            var damage : Int = Int(Float(self.belong!.attack) * ratio); // damageを与える
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


