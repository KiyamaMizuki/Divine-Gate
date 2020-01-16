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
        super.init();
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requirePanels = try container.decode(RequirePanelModel.self, forKey: .requirePanels)
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
    
}


