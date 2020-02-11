//
//  BattleCalculation.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/12/05.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class BattleCalculation{
    
    var attack : [double_t];
    var characterType : [String];
    
    var characterName : [String] = [];
    
    var firepanel : Int = 0;
    var waterpanel : Int = 0;
    var windpanel : Int = 0;
    var lightpanel : Int = 0;
    var darkpanel : Int = 0;
    
    //キャラクタの攻撃力と属性は、多分作ると勝手に思っているcharacterクラスから配列にして持ってくる
    //ことを想定してinit()しています。
    //今回は攻撃力100で属性が「"fire","water","dark"」のキャラクタを想定しています。
    init(){
        self.attack=[100,100,100];
        self.characterType=["fire","water","dark"];
    }
    
    //PanelContainerクラスから、各コンテナの各属性パネルの枚数を習得して、フィールド関数に入れています。
    //実行時は「"fire","water","wind","light","dark"」の順番で枚数が出力されます。
    func getPower(panel : [String]){
        var setpanel : [String] = [];
        setpanel.append(contentsOf: panel);
        
        self.firepanel = setpanel.filter{$0 == "fire"}.count;
        self.waterpanel = setpanel.filter{$0 == "water"}.count;
        self.windpanel = setpanel.filter{$0 == "wind"}.count;
        self.lightpanel = setpanel.filter{$0 == "light"}.count;
        self.darkpanel = setpanel.filter{$0 == "dark"}.count;
        
    print(Int(self.firepanel),Int(self.waterpanel),Int(self.windpanel),Int(self.lightpanel),Int(self.darkpanel));
        
        //damageCount()
    }
    
    
    //なんかうまくいかなかったダメージ計算の関数です。消してもらっても構いません。むしろ消してください。
    //実行はできるのですが、パネルをコンテナに入れるとシュミレータが止まります。
    //
//    func damageCount(){
//        var power : double_t = 0;
//        var attackpower : [Int]!;
//        var attack_result : double_t!;
//        for character in self.characterType{
//            for i in (0 ..< self.characterType.count){
//                if character=="fire"{
//                    power = self.magnificationCount(panel:self.firepanel);
//                }else if character=="water"{
//                    power = self.magnificationCount(panel:self.waterpanel);
//                }else if character=="wind"{
//                    power = self.magnificationCount(panel:self.windpanel);
//                }else if character=="light"{
//                    power = self.magnificationCount(panel:self.lightpanel);
//                }else if character=="dark"{
//                    power = self.magnificationCount(panel:self.darkpanel);
//                }
//                attack_result = power * self.attack[i];
//                attackpower.append(Int(attack_result));
//            }
//        }
//        print(attackpower)
//
//    }
//
//    func magnificationCount(panel : Int) -> double_t{
//        var power : double_t;
//        if panel==0{
//            power = 0;
//        }else if panel == 1{
//            power = 1;
//        }else if panel == 2{
//            power = 1.1;
//        }else if panel == 3{
//            power = 1.3;
//        }else if panel == 4{
//            power = 1.5;
//        }else{
//            power = 1.7;
//        }
//        return power;
//    }
//}
}
