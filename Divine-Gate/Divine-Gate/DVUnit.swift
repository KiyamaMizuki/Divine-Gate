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
import RealmSwift


class DVUnit : Object, Codable{
    @objc dynamic var name: String = ""; // 名前
    @objc dynamic var  type: String = ""; // 属性
    @objc dynamic var  tribe: String = ""; // 種族
    @objc dynamic var  description_c: String = ""; // 説明文
    @objc dynamic var  image_path: String = ""; // 画像のパス
    @objc dynamic var  id: String = ""; // 図鑑番号
    @objc dynamic var  rarelity: Int = 0; // レア度
    @objc dynamic var  hp: Int = 0; // 体力
    @objc dynamic var  attack : Int = 0;//攻撃力
    @objc dynamic var  level: Int = 0; // レベル
    @objc dynamic var  plus: Int = 0; // statusの値に振ることで、上昇させることができる
    let normalSkills = List<NormalSkill>(); // ノーマルスキル
//    @objc dynamic var  LinkSkill linkSkill; // リンクスキル
//    @objc dynamic var  LeaderSkill LeaderSKill; // リーダースキル
//    @objc dynamic var  PassiveSkill passiveSkill; // パッシブスキル
//    @objc dynamic var  ActiveSkill activeSkill: // アクティブスキル
//    @objc dynamic var  Skill boostSkill; // ブーストスキル
    @objc dynamic var isLeader: Bool = false; // リーダーかどうか
    @objc dynamic var isSelected : Bool = false;
    
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
//                                                         "water":0, "wind":0, "light":0, "dark":0], ratio:1.2, toSingle: true, skillType: "attack", name: "skill1", description_c: "fuga", type: "fire"), NormalSkill(requirePanels: ["fire":1, "water":0, "wind":0, "light":0, "dark":0], ratio:1.2, toSingle: true, skillType: "attack", name: "skill2", description_c: "fuga", type: "fire")];
//        self.normalSkills[0].belong = self
//    }
    required init(){
        
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        tribe = try container.decode(String.self, forKey: .tribe)
        description_c = try container.decode(String.self, forKey: .description_c)
        image_path = try container.decode(String.self, forKey: .image_path)
        id = try container.decode(String.self, forKey: .id)
        rarelity = try container.decode(Int.self, forKey: .rarelity)
        hp = try container.decode(Int.self, forKey: .hp)
        attack = try container.decode(Int.self, forKey: .attack)
        level = try container.decode(Int.self, forKey: .level)
        plus = try container.decode(Int.self, forKey: .plus)
        let normalSkillsArray = try container.decode([NormalSkill].self, forKey: .normalSkills)
        normalSkills.append(objectsIn: normalSkillsArray)
        isLeader = try container.decode(Bool.self, forKey: .isLeader)
        isSelected = try container.decode(Bool.self, forKey: .isSelected)
    }
    
    
    
    func  getexecutable(container: PanelContainer) ->
        [NormalSkill] {
            var endFlag : Bool = false;
            var panelInfo : [String:Int] = container.getPanelInfo()
            var resultSkills: [NormalSkill] = [];
            while true{
                for i in 0..<self.normalSkills.count{
                    if (self.normalSkills[i].judgeExecutable(panelInfo_: panelInfo)){ // 減算可能であったら
                        panelInfo = subtract(dict1 : panelInfo,dict2 : self.normalSkills[i].requirePanels!.getAsDict()); // ひく
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
