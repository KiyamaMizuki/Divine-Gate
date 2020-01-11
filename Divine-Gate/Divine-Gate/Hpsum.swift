//
//  Hpsum.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/08.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class Hpsum : ProgressBar{
    
    //全回復時のHP
    var full_hp : Int = 0;
    
    var before_hp : Int = 0;
    var after_hp : Int = 0;
    var hp: Int = 0;
    
    override init(){
        super.init();
        //全回復時のHP
        //どこかのクラスからもってくるのですかね？
//        self.full_hp = 1000;
        
        //戦闘後HPを次戦闘時に現在HPとして保持するためのHP
        self.before_hp = 1000;
        //戦闘後HP
        self.after_hp = 1000;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inithp(units : [DVUnit], x : Int, y : Int ){ // 体力を初期化する。プレイヤー専用
        var hp_sum : Int = 0;
        for unit in units{
            hp_sum += unit.hp;
        }
        self.full_hp = hp_sum;
        self.hp = hp_sum;
        self.setProgress(progress: 1.0);
        self.position = CGPoint(x: x,y: y)
        self.zPosition = 1 // 背景バーよりレイヤーを前に
    }
    
    func inithp(num : Int, x: Int, y: Int){  // 体力を初期化する。エネミー専用
        self.full_hp = num;
        self.hp = num;
        self.setProgress(progress: 1.0)
        self.position = CGPoint(x: x, y: y);
        self.zPosition = 1
    }
    
    func recovery(){
//        setProgress(progress: <#T##CGFloat#>)
    }
    
    
    
    //想定としては全員のhpの値を足し合わせた値をunitから持ってくる想定？こっちで計算する想定？
    //ちょっとわかりませんが、どちらにしろ計算すればでてくるのでとりあえず前者でやってみます
    
    func CalculationHp() -> Int{
        //とりあえず敵の攻撃力を100にしておきます
        //想定としては関数の引数に他クラスから持ってきた敵の攻撃力を入れるのかな？
        var enemy_attack = 100;
        
        //確認用
        var hp = Int(self.before_hp);
        print("【戦闘前のHP】= \(hp)");
        
        //戦闘前HP-敵の攻撃力を戦闘後HPにします
        self.after_hp = self.before_hp - enemy_attack;
        
        //次の戦闘時に現在の戦闘後HPを戦闘前HPとするために、
        //現在の戦闘後HPを戦闘前HPにぶちこみます
        self.before_hp = self.after_hp;
        
        //確認用
        print("【戦闘後のHP】= \(self.after_hp)");
        
        //戦闘後HPを返します
        return self.after_hp;
        
    }
    
    func wounded(damage : Int, type : String){
        self.hp -= damage; // damageでひき
        var percent : Float = Float(Float(self.hp) / Float(full_hp))
        print("割合");
        print(percent)
        self.setProgress(progress: CGFloat(percent));
    }
}
