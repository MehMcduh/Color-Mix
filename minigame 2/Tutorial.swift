//
//  Tutorial.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 3/20/17.
//  Copyright © 2017 dunno. All rights reserved.
//

import SpriteKit

class Tutorial: SKScene {
    var tut1 : SKSpriteNode!
    var tut2 : SKSpriteNode!
    var tut3 : SKSpriteNode!
    var tut4 : SKSpriteNode!
    var tut5 : SKSpriteNode!
    var tut6 : SKSpriteNode!
    var tut7 : SKSpriteNode!
    var tut8 : SKSpriteNode!
    var tut9 : SKSpriteNode!
    var nextButton : SKSpriteNode!
    var a : Int = 0
    
    
    override func didMove(to view: SKView) {
        tut1 = self.childNode(withName: "tut1") as! SKSpriteNode
        tut1.size = self.size
        tut1.texture = SKTexture(imageNamed: "tut1")
        tut1.anchorPoint = CGPoint(x:1,y:1)
        tut1.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut1.zPosition = 9
        
        tut2 = self.childNode(withName: "tut2") as! SKSpriteNode
        tut2.size = self.size
        tut2.texture = SKTexture(imageNamed: "tut2")
        tut2.anchorPoint = CGPoint(x:1,y:1)
        tut2.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut2.zPosition = 8
        
        tut3 = self.childNode(withName: "tut3") as! SKSpriteNode
        tut3.size = self.size
        tut3.texture = SKTexture(imageNamed: "tut3")
        tut3.anchorPoint = CGPoint(x:1,y: 1)
        tut3.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut3.zPosition = 7
        
        tut4 = self.childNode(withName: "tut4") as! SKSpriteNode
        tut4.size = self.size
        tut4.texture = SKTexture(imageNamed: "tut4")
        tut4.anchorPoint = CGPoint(x:1,y: 1)
        tut4.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut4.zPosition = 6
        
        tut5 = self.childNode(withName: "tut5") as! SKSpriteNode
        tut5.size = self.size
        tut5.texture = SKTexture(imageNamed: "tut5")
        tut5.anchorPoint = CGPoint(x:1,y:1)
        tut5.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut5.zPosition = 5
        
        tut6 = self.childNode(withName: "tut6") as! SKSpriteNode
        tut6.size = self.size
        tut6.texture = SKTexture(imageNamed: "tut6")
        tut6.anchorPoint = CGPoint(x:1,y:1)
        tut6.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut6.zPosition = 4
        
        tut7 = self.childNode(withName: "tut7") as! SKSpriteNode
        tut7.size = self.size
        tut7.texture = SKTexture(imageNamed: "tut7")
        tut7.anchorPoint = CGPoint(x:1,y:1)
        tut7.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut7.zPosition = 3
        
        tut8 = self.childNode(withName: "tut8") as! SKSpriteNode
        tut8.size = self.size
        tut8.texture = SKTexture(imageNamed: "tut8")
        tut8.anchorPoint = CGPoint(x:1,y:1)
        tut8.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut8.zPosition = 2
        
        tut9 = self.childNode(withName: "tut9") as! SKSpriteNode
        tut9.size = self.size
        tut9.texture = SKTexture(imageNamed: "tut9")
        tut9.anchorPoint = CGPoint(x:1,y:1)
        tut9.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        tut9.zPosition = 1
        
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
                    tut1.zPosition = -1
                case 2:
                    tut2.zPosition = -1
                case 3:
                    tut3.zPosition = -1
                case 4:
                    tut4.zPosition = -1
                case 5:
                    tut5.zPosition = -1
                case 6:
                    tut6.zPosition = -1
                case 7:
                    tut7.zPosition = -1
                case 8:
                    tut8.zPosition = -1
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
