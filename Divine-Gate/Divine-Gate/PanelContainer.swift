//
//  PanelContainer.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/28.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit;

class PanelContainer: SKSpriteNode {
    
    var panels : [Panel] = []
    
    var MAXLEN : Int = 5;
    
    //このコンテナに入っているパネルの属性をString配列で記録しています
    var belong_panel:[String] = [];//コンテナに入ってるパネルの属性を記録
    
    var firepanel : Int!;
    var waterpanel : Int!;
    var windpanel : Int!;
    var lightpanel : Int!;
    var darkpanel : Int!;
    
    var holdpanel : [String:Int] = ["fire":0,"water":0,"wind":0,"light":0,"dark":0];
    

//    Panel belong_panel;
    init(){
        super.init(texture: SKTexture(imageNamed: "Box"), color: UIColor.clear, size: CGSize(width: 100, height: 100));
        self.position = CGPoint(x: 10, y: 10);
    }
    
    func addPanel(panel : Panel, judgeflag : Bool) -> Bool{
//        let reSize = CGSize(width: self.width * 0.5, height: self.size.height * scaleSize)
//        self.scaleImage(scaleSize: 0.5)
        if self.panels.count < MAXLEN&&judgeflag{
            self.panels.append(panel)
            panel.zPosition = self.zPosition + 1
            panel.size = CGSize(width:self.size.width/2, height:self.size.height/2)
            switch self.panels.count{
                case 1:
                    panel.setPosition(x: Int(self.position.x - self.size.width/4), y: Int(self.position.y + self.size.height/4))
                    CountInPanel(panel_type: panel.type);
                    //一番目のパネルを正しい場所に固定する
                case 2:
                    panel.setPosition(x: Int(self.position.x + self.size.width/4), y: Int(self.position.y + self.size.height/4))
                   CountInPanel(panel_type: panel.type);
                    //二番目のパネルを正しい場所に固定する
                case 3:
                    panel.setPosition(x: Int(self.position.x - self.size.width/4), y: Int(self.position.y - self.size.height/4))
                    CountInPanel(panel_type: panel.type);
                    //三番目のパネルを正しい場所に固定する
                case 4:
                    panel.setPosition(x: Int(self.position.x + self.size.width/4), y: Int(self.position.y - self.size.height/4))
                    CountInPanel(panel_type: panel.type);
                    //四番目のパネルを正しい場所に固定する
                case 5:
                    panel.setPosition(x: Int(self.position.x), y: Int(self.position.y))
                    panel.zPosition = panel.zPosition + 1;
                    CountInPanel(panel_type: panel.type);
                    //コンテナに持ってきたパネルを入れる
                    //五番目のパネルを正しい場所に固定する
                default:
                    print("ifの段階で弾かれてる")
            }
            
            //ここでContainerクラスのインスタンスを作って
            //コンテナに入っているパネルのtypeを記録しているbelong_panel変数を
            //ContainerクラスのgetType関数に代入しています
            getType(panel:self.belong_panel);
            return true;
        }else{
            return false;
        }
    }
    
    //コンテナの中に入っているパネルのtypeをbelong_panel配列に記録します
    //addPanel関数で使用しています
    func CountInPanel(panel_type : String){
        self.belong_panel.append(panel_type);
        print(belong_panel);
    }
    
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
