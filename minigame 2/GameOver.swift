//
//  GameOver.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 3/4/17.
//  Copyright © 2017 dunno. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var score: Int = 0
    var Label: SKLabelNode!
    var scoreLabel : SKLabelNode!
    var startGameButton : SKSpriteNode!
    var newHighScore : Bool = false
    var newHighScoreImage :SKSpriteNode!

    
    override func didMove(to view: SKView) {
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        newHighScoreImage = self.childNode(withName: "newHighScoreImage") as! SKSpriteNode
        newHighScoreImage.isHidden = true
        if newHighScore == true {
            newHighScoreImage.texture = SKTexture(imageNamed: "newHighScoreImage")
            newHighScoreImage.isHidden = false
        }
        
        startGameButton = self.childNode(withName: "startGameButton") as! SKSpriteNode
        startGameButton.texture = SKTexture(imageNamed: "startgamebutton")
        
        NotificationCenter.default.post(name: .showAd, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "startGameButton" {
                let transition1 = SKTransition.fade(withDuration: 1)
                let gameScene = GameScene(size: CGSize(width: 1536, height: 2048))
                gameScene.scaleMode = .aspectFill
                self.view?.presentScene(gameScene, transition: transition1)
                
            }

        }
}
   
}
