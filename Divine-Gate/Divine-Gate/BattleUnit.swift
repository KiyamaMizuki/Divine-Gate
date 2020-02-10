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
class BattleUnit : SKSpriteNode, Codable{
    var name_: String = ""; // 名前
    var  type: String = ""; // 属性
    var  tribe: String = ""; // 種族
    var  description_c: String = ""; // 説明文
    var  image_path: String = ""; // 画像のパス
    var  id: String = ""; // 図鑑番号
    var  rarelity: Int = 0; // レア度
    var  hp: Int = 0; // 体力
    var  attack : Int = 0;//攻撃力
    var  level: Int = 0; // レベル
    var  plus: Int = 0; // statusの値に振ることで、上昇させることができる
    var normalSkills : [BattleNormalSkill] = []; // ノーマルスキル
//    var  LinkSkill linkSkill; // リンクスキル
//    var  LeaderSkill LeaderSKill; // リーダースキル
//    var  PassiveSkill passiveSkill; // パッシブスキル
//    var  ActiveSkill activeSkill: // アクティブスキル
//    var  Skill boostSkill; // ブーストスキル
    var isLeader: Bool = false;
    var isSelected : Bool = false;
    var x : Int = 0
    var y : Int = 0;
    var width : Int = 0;
    var height : Int = 0;
    func setPosition(x : Int, y : Int) {
        self.x = x;
        self.y = y;
        self.position = CGPoint(x: self.x, y:self.y)
    }
    func setSize(width : Int, height : Int){
        self.width = width;
        self.height = height;
        self.size = CGSize(width:self.width, height:self.height)
    }
    init(){
        super.init(texture: SKTexture(imageNamed: self.image_path), color: UIColor.clear, size: CGSize(width: width, height: height));
    }
    func setImage(){
        self.texture = SKTexture(imageNamed: self.image_path)
    }
    enum CodingKeysUnit: String, CodingKey{
        case name
        case type
        case tribe
        case description_c
        case image_path
        case id
        case rarelity
        case hp
        case attack
        case level
        case plus
        case normalSkills
        case isLeader
        case isSelected
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeysUnit.self)
        name_ = try container.decode(String.self, forKey: .name)
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
        normalSkills = try container.decode([BattleNormalSkill].self, forKey: .normalSkills)
        isLeader = try container.decode(Bool.self, forKey: .isLeader)
        isSelected = try container.decode(Bool.self, forKey: .isSelected)
        setImage()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hoishoifasd");
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            var content = ""
            for i in 0..<self.normalSkills.count{
                content += self.normalSkills[i].name + "\n ";
                content += self.normalSkills[i].description_c + "\n";
            }
            var sdpn = SkillDescriptionPopupNode(content: content);
            self.parent!.parent!.addChild(sdpn);
        }
    }
    func  getexecutable(container: PanelContainer) ->
        [BattleNormalSkill] {
            var endFlag : Bool = false;
            var panelInfo : [String:Int] = container.getPanelInfo()
            var resultSkills: [BattleNormalSkill] = [];
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
    func subtract(dict1 : [String : Int], dict2 : [String : Int]) -> [String:Int]{
        var dict_c = dict1;
        for key in dict1.keys{
            dict_c[key] = dict_c[key]! - dict2[key]!
        }
        return dict_c;
    }
}
