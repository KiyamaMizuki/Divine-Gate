//
//  Hpsum.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation

class Hpsum{
    
    var before_hp : Int!;
    var after_hp : Int;
    
    init(){
        //戦闘前HP
        self.before_hp = 1000;
        //戦闘後HP
        self.after_hp = 1000;
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
}
