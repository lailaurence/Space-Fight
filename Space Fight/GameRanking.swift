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
    
    
    let databaseRef = Database.database().reference()
    databaseRef.child("HighScore")
}

