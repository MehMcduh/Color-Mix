//
//  GameScene.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 12/25/16.
//  Copyright © 2016 dunno. All rights reserved.
//



import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let cateCoin1: UInt32 = UInt32(1)
        static let cateCoin2: UInt32 = UInt32(2)
        static let cateCoin3: UInt32 = UInt32(3)
        static let cateColor1: UInt32 = UInt32(4)
        static let cateColor2: UInt32 = UInt32(5)
    }
    
    var score = 0
    let scoreLabel = SKLabelNode(fontNamed: "Action Jackson")
    var scoreNumber = SKLabelNode(fontNamed: "Action Jackson")
    
    var missed = 0
    let missedLabel = SKLabelNode(fontNamed: "Action Jackson")
    var missedNumber = SKLabelNode(fontNamed: "Action Jackson")
    
    var highScore :Int = 0
    var newHighScore = false
    let highScoreLabel = SKLabelNode(fontNamed: "Action Jackson")
    var highScoreNumber = SKLabelNode(fontNamed: "Action Jackson")
    
    var colorNumber = 1
    let yellowButton = SKSpriteNode(imageNamed: "button1")
    let redButton = SKSpriteNode(imageNamed: "button2")
    
    var pauseButton = SKSpriteNode(imageNamed: "pause")
    var returnPopup = SKSpriteNode(imageNamed: "return popup")
    var resumeButton = SKSpriteNode(imageNamed: "resumebutton")
    var rePlayButton = SKSpriteNode(imageNamed: "replaybutton")
    var menuButton = SKSpriteNode(imageNamed: "menubutton")
    
    let eatCoinSound = SKAction.playSoundFileNamed("eat coin", waitForCompletion: false)
    let missedSound = SKAction.playSoundFileNamed("missed sound", waitForCompletion: false)
    let gameMusic = SKAction.playSoundFileNamed("game music", waitForCompletion: false)
    
    var pauseTest = false
    
    // tao game area cho universal device
    let gameArea: CGRect
    override init(size: CGSize) {
        
        // CHEATSHEET 1
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y: size.height*1/7 + 200 , width: playableWidth, height: size.height*5/7 - 200)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // END OF CHEATSHEET 1
    
    // CHEAT SHEET 2
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    // END OF CHEATSHEET 2
    
    func spawnAndFadeCoins() -> () {
        
        let randNum = arc4random()%6 + 1
        let anotherCoin = SKSpriteNode(imageNamed: "coin\(randNum)")
        anotherCoin.name = "coin\(randNum)"
        anotherCoin.zPosition = 10
        
        // code lay random position cho new anotherCoin. (Phai lay randomX +- nua anotherCoin vi random position la center point cua anotherCoin)
        let randomX = random(min: gameArea.minX + anotherCoin.size.width/2,
                             max: gameArea.maxX - anotherCoin.size.width/2)
        let randomY = random(min: gameArea.minY + anotherCoin.size.height/2,
                             max: gameArea.maxY - anotherCoin.size.height/2)
        
        
        anotherCoin.position = CGPoint(x: randomX, y: randomY)
        anotherCoin.physicsBody = SKPhysicsBody(circleOfRadius: max(anotherCoin.size.width / 2,
                                                                    anotherCoin.size.height / 2))
        anotherCoin.physicsBody?.affectedByGravity = false
        
        // choose category for anotherCoin
        switch randNum {
        case 1:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin1
        case 2:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin2
        case 3:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin3
        case 4:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin1
        case 5:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin2
        case 6:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin3
        default:
            anotherCoin.physicsBody?.categoryBitMask = PhysicsCategory.cateCoin1
            
        }
        
        anotherCoin.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        
        if randNum >= 4 {
            let disappearForStar = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent(),
                                                      SKAction.run{
                                                        if GameSounds.sharedInstance.soundIsMuted == false {
                                                            self.run(self.missedSound)
                                                        }
                                                        self.missed += 1
                                                        self.missedNumber.text = "\(self.missed)"
                                                        if self.missed == 3 {
                                                            self.pauseTest = true
                                                           let transition2 = SKTransition.fade(withDuration: 1)
                                                            let gameOver = SKScene(fileNamed: "GameOver") as! GameOver
                                                            gameOver.score = self.score
                                                            gameOver.newHighScore = self.newHighScore
                                                            gameOver.scaleMode = .aspectFill
                                                            self.view?.presentScene(gameOver, transition: transition2)
                                                        }
                                                        
                                                        
                }])
            anotherCoin.run(SKAction.repeatForever(disappearForStar))
        } else {
            let disappear = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()])
            anotherCoin.run(SKAction.repeatForever(disappear))
        }
        self.addChild(anotherCoin)
        }
    
    
        override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed:"bg2")
        background.size = self.size
        background.position = CGPoint(x:self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        yellowButton.name = "button1"
        yellowButton.position = CGPoint(x:self.size.width*1/3, y:yellowButton.size.height + 200 )
        yellowButton.zPosition = 20
        self.addChild(yellowButton)
        
        redButton.name = "button2"
        redButton.position = CGPoint(x: self.size.width*2/3, y: redButton.size.height + 200)
        redButton.zPosition = 20
        self.addChild(redButton)
        
        highScoreLabel.fontSize = 100
        highScoreLabel.text = "high"
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x:self.size.width*0.5 - 400, y: self.size.height*0.92)
        self.addChild(highScoreLabel)
        
        // accessing default High Score
        let HighScoreDefault = UserDefaults.standard
        if (HighScoreDefault.value(forKey: "highscore") != nil) {
            highScore = HighScoreDefault.value(forKey: "highscore") as! NSInteger!
            highScoreNumber.text = "\(highScore)"
        }
        
        highScoreNumber.fontSize = 100
        highScoreNumber.zPosition = 1
        highScoreNumber.position = CGPoint(x:self.size.width*0.5 - 400, y: self.size.height*0.85)
        self.addChild(highScoreNumber)
        
        missedLabel.fontSize = 100
        missedLabel.text = "missed"
        missedLabel.zPosition = 1
        missedLabel.position = CGPoint(x:self.size.width*0.5-50, y: self.size.height*0.92)
        self.addChild(missedLabel)
        
        missedNumber.fontSize = 100
        missedNumber.text = "\(missed)"
        missedNumber.zPosition = 1
        missedNumber.position = CGPoint(x:self.size.width*0.5-100, y: self.size.height*0.85)
        self.addChild(missedNumber)
        
        scoreLabel.fontSize = 100
        scoreLabel.text = "score"
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x:self.size.width-480, y: self.size.height*0.92)
        self.addChild(scoreLabel)
        
        scoreNumber.fontSize = 100
        scoreNumber.text = "\(score)"
        scoreNumber.zPosition = 1
        scoreNumber.position = CGPoint(x:self.size.width-500 , y: self.size.height*0.85)
        self.addChild(scoreNumber)
        

        pauseButton.position = CGPoint(x:self.size.width-250, y:self.size.height*0.94 )
        pauseButton.zPosition = 11
        pauseButton.name = "pause"
        self.addChild(pauseButton)
        
        returnPopup.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        returnPopup.zPosition = 20
        returnPopup.isHidden = true
        self.addChild(returnPopup)
        
        resumeButton.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2+400)
        resumeButton.name = "resumebutton"
        resumeButton.zPosition = 21
        resumeButton.isHidden = true
        self.addChild(resumeButton)
        
        rePlayButton.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
        rePlayButton.name = "replaybutton"
        rePlayButton.zPosition = 21
        rePlayButton.isHidden = true
        self.addChild(rePlayButton)
        
        menuButton.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2 - 400)
        menuButton.name = "menubutton"
        menuButton.zPosition = 21
        menuButton.isHidden = true
        self.addChild(menuButton)
        
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1),SKAction.run(spawnAndFadeCoins)])), withKey:"spawnCoins"
                )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "button1"{
                colorNumber = 1
            }
            else if nameOfTappedNode == "button2"{
                colorNumber = 2
            }
            
            if nameOfTappedNode == "pause" && self.speed != 0.0 {
                self.speed = 0.0
                returnPopup.isHidden = false
                resumeButton.isHidden = false
                rePlayButton.isHidden = false
                menuButton.isHidden = false
                pauseTest = true
                self.action(forKey: "spawnCoins")?.speed = 0.0
                
            }
            
            if nameOfTappedNode == "resumebutton" && self.speed == 0.0 {
                returnPopup.isHidden = true
                resumeButton.isHidden = true
                rePlayButton.isHidden = true
                menuButton.isHidden = true
                self.speed = 1.0
                pauseTest = false
                self.action(forKey: "spawnCoins")?.speed = 1.0

            }
            
            if nameOfTappedNode == "replaybutton" && self.speed == 0.0 {
               let transition1 = SKTransition.fade(withDuration: 1)
                let gameScene = GameScene(size: CGSize(width: 1536, height: 2048))
                gameScene.scaleMode = .aspectFill
                self.view?.presentScene(gameScene, transition: transition1)
            }
            
            if nameOfTappedNode == "menubutton" && self.speed == 0.0 {
                let transition3 = SKTransition.fade(withDuration: 1)
                let menuScene = MenuScene(fileNamed: "MenuScene")!
                menuScene.scaleMode = .aspectFit
                self.view?.presentScene(menuScene, transition: transition3)
            }
            
            if nameOfTappedNode != "button1" && nameOfTappedNode != "button2" && nameOfTappedNode != "pause" {
                
                let color = SKSpriteNode(imageNamed: "color\(colorNumber)")
                color.name = "color\(colorNumber)"
                color.zPosition = 10
                color.position = positionOfTouch
                color.physicsBody = SKPhysicsBody(circleOfRadius: max(color.size.width / 2,
                                                                      color.size.height / 2))
                color.physicsBody?.affectedByGravity = false
                
                
                // choose category for color
                switch colorNumber {
                case 1:
                    color.physicsBody?.categoryBitMask = PhysicsCategory.cateColor1
                case 2:
                    color.physicsBody?.categoryBitMask = PhysicsCategory.cateColor2
                default:
                    color.physicsBody?.categoryBitMask = PhysicsCategory.cateColor1
                    
                }
                
                // choose contact test bit mask for color
                switch colorNumber {
                case 1:
                    color.physicsBody?.contactTestBitMask = PhysicsCategory.cateCoin1
                case 2:
                    color.physicsBody?.contactTestBitMask = PhysicsCategory.cateCoin2
                default:
                    color.physicsBody?.contactTestBitMask = PhysicsCategory.cateCoin1
                    
                }
                
                color.physicsBody?.collisionBitMask = PhysicsCategory.none
                
                
                let disappear2 = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()])
                color.run(disappear2)
                self.addChild(color)
                
                let blendMode = SKBlendMode.alpha
                color.alpha = 0.8
                color.blendMode = blendMode
                
                
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask == 1) && (secondBody.categoryBitMask == 4) || (firstBody.categoryBitMask == 2) && (secondBody.categoryBitMask == 5)) && pauseTest == false {
            
            firstBody.node!.run(SKAction.removeFromParent())
           if GameSounds.sharedInstance.soundIsMuted == false {
                  self.run(self.eatCoinSound)
            }

            score += 1
            scoreNumber.text = "\(score)"
            if score > highScore {
                highScore = score
                highScoreNumber.text = "\(highScore)"
                newHighScore = true
                
                let HighScoreDefault = UserDefaults.standard
                HighScoreDefault.setValue(highScore, forKey: "highscore")                }
            
        }
        else if (firstBody.categoryBitMask == 3) && (secondBody.categoryBitMask == 4) && pauseTest == false {
            firstBody.node!.name! += "+Yellow"
        }
        else if (firstBody.categoryBitMask == 3) && (secondBody.categoryBitMask == 5) && pauseTest == false {
            firstBody.node!.name! += "+Red"
        }
        
        if (firstBody.node!.name!.range(of:"Yellow")) != nil && (firstBody.node!.name!.range(of:"Red")) != nil {
            
            firstBody.node!.run(SKAction.removeFromParent())
            if GameSounds.sharedInstance.soundIsMuted == false {
                    self.run(self.eatCoinSound)
            }
            score += 1
            scoreNumber.text = "\(score)"
            if score > highScore {
                highScore = score
                highScoreNumber.text = "\(highScore)"
                newHighScore = true
                
                let HighScoreDefault = UserDefaults.standard
                HighScoreDefault.setValue(highScore, forKey: "highscore")
            }
        }
        if (score == 10 || score == 100 || score == 150 || score == 300 || score == 400) {
             run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run(spawnAndFadeCoins) ])))
        }
}

}



