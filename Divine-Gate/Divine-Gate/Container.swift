//
//  Container.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class Container{
    
    var firepanel : Int!;
    var waterpanel : Int!;
    var windpanel : Int!;
    var lightpanel : Int!;
    var darkpanel : Int!;
    
    var holdpanel : [String:Int] = ["fire":0,"water":0,"wind":0,"light":0,"dark":0];
    
    //PanelContainerクラスから、コンテナに格納したパネルのタイプを記録しているbelong_panel変数を持ってきて
    //Containerクラスのフィールド変数firepanel,watarpanel,windpanel,lightpanel,darkpanelに格納し、
    //dict型フイールド変数のholdpanelにそれぞれの枚数を格納する関数です
    func getType(panel : [String]) -> [String:Int] {
        var setpanel : [String];
        setpanel = [];
        setpanel.append(contentsOf: panel);
        let orderedSet: NSOrderedSet = NSOrderedSet(array: setpanel);
        var belongpanel = orderedSet.array as! [String];
        
        for type in belongpanel{
            if type=="fire"{
                self.holdpanel["fire"]=Int(setpanel.filter{$0 == "fire"}.count);
            }else if type=="water"{
                self.holdpanel["water"]=Int(setpanel.filter{$0 == "water"}.count);
            }else if type=="wind"{
                self.holdpanel["wind"]=Int(setpanel.filter{$0 == "wind"}.count);
            }else if type=="light"{
                self.holdpanel["light"]=Int(setpanel.filter{$0 == "light"}.count);
            }else if type=="dark"{
                self.holdpanel["dark"]=Int(setpanel.filter{$0 == "dark"}.count);
            }
        }
        
        for (type,count) in self.holdpanel{
            print("\(type)=\(count)");
        }
        
        return self.holdpanel;
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
