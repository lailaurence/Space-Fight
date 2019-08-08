//
//  GameRanking.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 7/8/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//

import Foundation
import SpriteKit
import FirebaseDatabase
import Firebase
var highscore:Int = 0

class GameRankingScene:SKScene{

    
    var postData = [String]()
    override func sceneDidLoad() {
        
      
}
    
    
    override func didMove(to view: SKView) {
        //Background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("High Score").child("HighScore")
        ref?.child("High Score").observe(.childAdded, with: {(snapshot) in
            
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                print(userDict["HighScore"] as Any)
            }
            
        }) 
    }
       

        
        
    }

    
    
    
    
    


