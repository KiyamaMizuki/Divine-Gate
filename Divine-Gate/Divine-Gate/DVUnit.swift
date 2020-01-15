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
    

    
}
