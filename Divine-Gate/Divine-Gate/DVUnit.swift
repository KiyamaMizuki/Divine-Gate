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
    let rerelity: Int; // レア度
    var hp: Int; // 体力
    var attack : Int;//攻撃力
    var level: Int; // レベル
    var plus: Int; // statusの値に振ることで、上昇させることができる
    let normalSkil : [NormalSkill]; // ノーマルすきる
//    let LinkSkill linkSkill; // リンクスキル
//    let LeaderSkill LeaderSKill; // リーダースキル
//    let PassiveSkill passiveSkill; // パッシブスキル
//    let ActiveSkill activeSkill: // アクティブスキル
//    let Skill boostSkill; // ブーストスキル
    let isLeader: Bool; // リーダーかどうか
    let isNormalSkillInclude: Bool; // ノーマルスキルの必要とするパネルの枚数に包含関係があるかどうか
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
//    }
}
