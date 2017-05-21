//
//  TutorialVN.swift
//  Color Mix
//
//  Created by Bui Thu Ha on 5/16/17.
//  Copyright © 2017 HI Entertainment. All rights reserved.
//

import SpriteKit

class TutorialVN: SKScene {
        var tut1VN : SKSpriteNode!
        var tut2VN : SKSpriteNode!
        var tut3VN : SKSpriteNode!
        var tut4VN : SKSpriteNode!
        var tut5VN : SKSpriteNode!
        var tut6VN : SKSpriteNode!
        var tut7VN : SKSpriteNode!
        var tut8VN : SKSpriteNode!
        var tut9VN : SKSpriteNode!
        var tiepButton : SKSpriteNode!
        var a : Int = 0
        
        
        override func didMove(to view: SKView) {
            tut1VN = self.childNode(withName: "tut1VN") as! SKSpriteNode
            tut1VN.size = self.size
            tut1VN.texture = SKTexture(imageNamed: "tut1VN")
            tut1VN.anchorPoint = CGPoint(x:1,y:1)
            tut1VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut1VN.zPosition = 9
            
            tut2VN = self.childNode(withName: "tut2VN") as! SKSpriteNode
            tut2VN.size = self.size
            tut2VN.texture = SKTexture(imageNamed: "tut2VN")
            tut2VN.anchorPoint = CGPoint(x:1,y:1)
            tut2VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut2VN.zPosition = 8
            
            tut3VN = self.childNode(withName: "tut3VN") as! SKSpriteNode
            tut3VN.size = self.size
            tut3VN.texture = SKTexture(imageNamed: "tut3VN")
            tut3VN.anchorPoint = CGPoint(x:1,y: 1)
            tut3VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut3VN.zPosition = 7
            
            tut4VN = self.childNode(withName: "tut4VN") as! SKSpriteNode
            tut4VN.size = self.size
            tut4VN.texture = SKTexture(imageNamed: "tut4VN")
            tut4VN.anchorPoint = CGPoint(x:1,y: 1)
            tut4VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut4VN.zPosition = 6
            
            tut5VN = self.childNode(withName: "tut5VN") as! SKSpriteNode
            tut5VN.size = self.size
            tut5VN.texture = SKTexture(imageNamed: "tut5VN")
            tut5VN.anchorPoint = CGPoint(x:1,y:1)
            tut5VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut5VN.zPosition = 5
            
            tut6VN = self.childNode(withName: "tut6VN") as! SKSpriteNode
            tut6VN.size = self.size
            tut6VN.texture = SKTexture(imageNamed: "tut6VN")
            tut6VN.anchorPoint = CGPoint(x:1,y:1)
            tut6VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut6VN.zPosition = 4
            
            tut7VN = self.childNode(withName: "tut7VN") as! SKSpriteNode
            tut7VN.size = self.size
            tut7VN.texture = SKTexture(imageNamed: "tut7VN")
            tut7VN.anchorPoint = CGPoint(x:1,y:1)
            tut7VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut7VN.zPosition = 3
            
            tut8VN = self.childNode(withName: "tut8VN") as! SKSpriteNode
            tut8VN.size = self.size
            tut8VN.texture = SKTexture(imageNamed: "tut8VN")
            tut8VN.anchorPoint = CGPoint(x:1,y:1)
            tut8VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut8VN.zPosition = 2
            
            tut9VN = self.childNode(withName: "tut9VN") as! SKSpriteNode
            tut9VN.size = self.size
            tut9VN.texture = SKTexture(imageNamed: "tut9VN")
            tut9VN.anchorPoint = CGPoint(x:1,y:1)
            tut9VN.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            tut9VN.zPosition = 1
            
            tiepButton = self.childNode(withName: "tiep") as! SKSpriteNode
            tiepButton.name = "tiep"
            tiepButton.anchorPoint = CGPoint(x:1,y:1)
            tiepButton.position = CGPoint(x: self.size.width-400, y: self.size.height*1/32)
            tiepButton.zPosition = 10
            
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch: AnyObject in touches {
                let positionOfTouch = touch.location(in: self)
                let tappedNode = atPoint(positionOfTouch)
                let nameOfTappedNode = tappedNode.name
                
                if nameOfTappedNode == "tiep" {
                    a = a + 1
                    switch  a {
                    case 1:
                        tut1VN.zPosition = -1
                    case 2:
                        tut2VN.zPosition = -1
                    case 3:
                        tut3VN.zPosition = -1
                    case 4:
                        tut4VN.zPosition = -1
                    case 5:
                        tut5VN.zPosition = -1
                    case 6:
                        tut6VN.zPosition = -1
                    case 7:
                        tut7VN.zPosition = -1
                    case 8:
                        tut8VN.zPosition = -1
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



