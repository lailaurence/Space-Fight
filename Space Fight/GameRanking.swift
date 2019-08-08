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


class GameRankingScene:SKScene{
    var postData = [String]()
    override func sceneDidLoad() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref?.child("High Score").observe(.childAdded, with: {(snapshot) in
            let post = snapshot.value as? String
            
            if let actualPost = post{
            self.postData.append(actualPost)
            }
        })

}

    
    
    
    
    
}
