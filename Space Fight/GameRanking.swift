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
let defaults = UserDefaults()

class GameRankingScene:SKScene{

    
    var postData = [String]()
    override func sceneDidLoad() {
        
      
}
     let highScoreNumber = defaults.integer(forKey: "highScoreSaved")
    
    override func didMove(to view: SKView) {
        //Background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let ref = Database.database().reference(withPath: "High Score")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot) // Its print all values including Snap (User)
            
            print(snapshot.value!)
            
            //let xp = snapshot.childSnapshot(forPath: "XP").value
           
            let xp = snapshot.childSnapshot(forPath: "XP").value
            print("XP: \(xp!)")
            
            
        
        
    })
       
        

        
        
    }

    
    
    
    
    


}
