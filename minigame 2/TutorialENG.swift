//
//  Tutorial.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 3/20/17.
//  Copyright © 2017 dunno. All rights reserved.
//

import SpriteKit

class TutorialENG: SKScene {
    var tut1ENG : SKSpriteNode!
    var tut2ENG : SKSpriteNode!
    var tut3ENG : SKSpriteNode!
    var tut4ENG : SKSpriteNode!
    var tut5ENG : SKSpriteNode!
    var tut6ENG : SKSpriteNode!
    var tut7ENG : SKSpriteNode!
    var tut8ENG : SKSpriteNode!
    var tut9ENG : SKSpriteNode!
    var nextButton : SKSpriteNode!
    var a : Int = 0
    
    
    override func didMove(to view: SKView) {
        tut1ENG = self.childNode(withName: "tut1ENG") as! SKSpriteNode
        tut1ENG.size = self.size
        tut1ENG.texture = SKTexture(imageNamed: "tut1ENG")
        tut1ENG.anchorPoint = CGPoint(x:1,y:1)
        tut1ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut1ENG.zPosition = 9
        
        tut2ENG = self.childNode(withName: "tut2ENG") as! SKSpriteNode
        tut2ENG.size = self.size
        tut2ENG.texture = SKTexture(imageNamed: "tut2ENG")
        tut2ENG.anchorPoint = CGPoint(x:1,y:1)
        tut2ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut2ENG.zPosition = 8
        
        tut3ENG = self.childNode(withName: "tut3ENG") as! SKSpriteNode
        tut3ENG.size = self.size
        tut3ENG.texture = SKTexture(imageNamed: "tut3ENG")
        tut3ENG.anchorPoint = CGPoint(x:1,y: 1)
        tut3ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut3ENG.zPosition = 7
        
        tut4ENG = self.childNode(withName: "tut4ENG") as! SKSpriteNode
        tut4ENG.size = self.size
        tut4ENG.texture = SKTexture(imageNamed: "tut4ENG")
        tut4ENG.anchorPoint = CGPoint(x:1,y: 1)
        tut4ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut4ENG.zPosition = 6
        
        tut5ENG = self.childNode(withName: "tut5ENG") as! SKSpriteNode
        tut5ENG.size = self.size
        tut5ENG.texture = SKTexture(imageNamed: "tut5ENG")
        tut5ENG.anchorPoint = CGPoint(x:1,y:1)
        tut5ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut5ENG.zPosition = 5
        
        tut6ENG = self.childNode(withName: "tut6ENG") as! SKSpriteNode
        tut6ENG.size = self.size
        tut6ENG.texture = SKTexture(imageNamed: "tut6ENG")
        tut6ENG.anchorPoint = CGPoint(x:1,y:1)
        tut6ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut6ENG.zPosition = 4
        
        tut7ENG = self.childNode(withName: "tut7ENG") as! SKSpriteNode
        tut7ENG.size = self.size
        tut7ENG.texture = SKTexture(imageNamed: "tut7ENG")
        tut7ENG.anchorPoint = CGPoint(x:1,y:1)
        tut7ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut7ENG.zPosition = 3
        
        tut8ENG = self.childNode(withName: "tut8ENG") as! SKSpriteNode
        tut8ENG.size = self.size
        tut8ENG.texture = SKTexture(imageNamed: "tut8ENG")
        tut8ENG.anchorPoint = CGPoint(x:1,y:1)
        tut8ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut8ENG.zPosition = 2
        
        tut9ENG = self.childNode(withName: "tut9ENG") as! SKSpriteNode
        tut9ENG.size = self.size
        tut9ENG.texture = SKTexture(imageNamed: "tut9ENG")
        tut9ENG.anchorPoint = CGPoint(x:1,y:1)
        tut9ENG.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut9ENG.zPosition = 1
        
        nextButton = self.childNode(withName: "next") as! SKSpriteNode
        nextButton.name = "next"
        nextButton.anchorPoint = CGPoint(x:1,y:1)
        nextButton.position = CGPoint(x: self.size.width-400, y: self.size.height*1/32)
        nextButton.zPosition = 10
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "next" {
                a = a + 1
                switch  a {
                case 1:
                    tut1ENG.zPosition = -1
                case 2:
                    tut2ENG.zPosition = -1
                case 3:
                    tut3ENG.zPosition = -1
                case 4:
                    tut4ENG.zPosition = -1
                case 5:
                    tut5ENG.zPosition = -1
                case 6:
                    tut6ENG.zPosition = -1
                case 7:
                    tut7ENG.zPosition = -1
                case 8:
                    tut8ENG.zPosition = -1
                case 9:
                    let transition = SKTransition.fade(withDuration: 1)
                    let menuScene = SKScene(fileNamed: "MenuScene") as! MenuScene
                    menuScene.scaleMode = .aspectFill
                    self.view?.presentScene(menuScene, transition: transition)
                default:
                    a = 0
                }
            }
            
        }
        
    }
}
