//
//  Unit.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class DVUnit : Codable{
    let name: String; // 名前
    let type: String; // 属性
    let tribe: String; // 種族
    let description: String; // 説明文
    let image_path: String; // 画像のパス
    let id: String; // 図鑑番号
    let rerelity: Int = 0; // レア度
    var hp: Int = 0; // 体力
    var attack : Int = 0;//攻撃力
    var level: Int = 0; // レベル
    var plus: Int = 0; // statusの値に振ることで、上昇させることができる
    let normalSkills : [NormalSkill]; // ノーマルスキル
//    let LinkSkill linkSkill; // リンクスキル
//    let LeaderSkill LeaderSKill; // リーダースキル
//    let PassiveSkill passiveSkill; // パッシブスキル
//    let ActiveSkill activeSkill: // アクティブスキル
//    let Skill boostSkill; // ブーストスキル
    let isLeader: Bool; // リーダーかどうか
    let isNormalSkillInclude: Bool = false; // ノーマルスキルの必要とするパネルの枚数に包含関係があるかどうか
    
//    init(attack : Int) {
//        self.attack = attack;
//    }
//    init(name : String, type : String, tribe : String, image_path : String, hp : Int, attack : Int) {
//        self.name = name;
//        self.type = type;
//        self.tribe = tribe;
//        self.image_path = image_path;
//        self.hp = hp;
//        self.attack = attack;
//
//    }
//    init() {
//        self.normalSkills = [NormalSkill(requirePanels: ["fire":2,
//                                                         "water":0, "wind":0, "light":0, "dark":0], ratio:1.2, toSingle: true, skillType: "attack", name: "skill1", description: "fuga", type: "fire"), NormalSkill(requirePanels: ["fire":1, "water":0, "wind":0, "light":0, "dark":0], ratio:1.2, toSingle: true, skillType: "attack", name: "skill2", description: "fuga", type: "fire")];
//        self.normalSkills[0].belong = self
//    }
    
    func  getexecutable(container: PanelContainer) ->
        [NormalSkill] {
            var endFlag : Bool = false;
            var panelInfo : [String:Int] = container.getPanelInfo()
            var resultSkills: [NormalSkill] = [];
            while true{
                for i in 0..<self.normalSkills.count{
                    if (self.normalSkills[i].judgeExecutable(panelInfo_: panelInfo)){ // 減算可能であったら
                        panelInfo = subtract(dict1 : panelInfo,dict2 : self.normalSkills[i].requirePanels); // ひく
                        resultSkills.append(self.normalSkills[i]); // 追加して
                        // 最初のスキルの検証に戻る。つまりここのforでbreak
                        break;
                    }else{ // 不可能であったら、次のskillを検証
                        if (i == self.normalSkills.count - 1){  // 最後のスキルであったら
                            endFlag = true;
                            break;
                        }
                        continue
                    }
                    
                }
                if (endFlag){
                    break;
                }
                // 減算可能なケースでここにくる
            }
            return resultSkills;
            
    }
    
    func setSkilltoBelong(){
        for ns in self.normalSkills{
            ns.belong = self;
        }
    }
    
//    func skill(skillpal1 : [String:Int],existpal : [String:Int]) -> {
//        for panel1 in existpal{
//            if panel1.value  skillpal1.values{
//            }
//        }
//    }
    
    func subtract(dict1 : [String : Int], dict2 : [String : Int]) -> [String:Int]{
        var dict_c = dict1;
        for key in dict1.keys{
            dict_c[key] = dict_c[key]! - dict2[key]!
        }
        return dict_c;
    }
    
//    fucn isDictNatural(dict : [String:Int]) -> Bool{ // dictionaryのvalueが全て0以上だったらtrue, それ以外ならfalse
//        for
//    }
    
}
