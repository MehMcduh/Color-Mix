//
//  MenuScene.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 3/4/17.
//  Copyright © 2017 dunno. All rights reserved.
//

import SpriteKit

// làm tutorialVN scene
    class MenuScene: SKScene {
        
        var ColorMix : SKLabelNode!
        var startGameButton :SKSpriteNode!
        var tutorialButton : SKSpriteNode!
        
        var languageBoard : SKSpriteNode!
        var closeButton: SKSpriteNode!
        var englishButton: SKSpriteNode!
        var vietnameseButton : SKSpriteNode!
        var languageChoosingPause = false
        
        var musicButton: SKSpriteNode!
        var soundButton: SKSpriteNode!
       
        var background : SKSpriteNode!
        
        let musicOnTexture = SKTexture(imageNamed: "musicOn")
        let musicOffTexture = SKTexture(imageNamed: "musicOff")
        let soundOnTexture = SKTexture(imageNamed: "soundOn")
        let soundOffTexture = SKTexture(imageNamed: "soundOff")
        
        func showLanguageBoard() {
            languageBoard.isHidden = false
            closeButton.isHidden = false
            englishButton.isHidden = false
            vietnameseButton.isHidden = false
            languageChoosingPause = true
        }
        
        func hideLanguageBoard() {
            languageBoard.isHidden = true
            closeButton.isHidden = true
            englishButton.isHidden = true
            vietnameseButton.isHidden = true
            languageChoosingPause = false
        }
        
        override func didMove(to view: SKView) {
            
            background = self.childNode(withName: "background") as! SKSpriteNode
            background.size = self.size
            background.anchorPoint = CGPoint(x:1,y:1)
            background.position = CGPoint(x:self.size.width*1/2, y:self.size.height*1/2)
            background.zPosition = -1
            background.texture = SKTexture(imageNamed: "bg2")
            
            startGameButton = self.childNode(withName: "startGameButton") as! SKSpriteNode
            startGameButton.texture = SKTexture(imageNamed: "startgamebutton")
            tutorialButton = self.childNode(withName: "tutorialButton") as! SKSpriteNode
            tutorialButton.texture = SKTexture(imageNamed: "tutorialbutton")
            
            languageBoard = self.childNode(withName: "languageBoard") as! SKSpriteNode
            languageBoard.isHidden = true
            closeButton = self.childNode(withName: "closeButton") as! SKSpriteNode
            closeButton.isHidden = true
            englishButton = self.childNode(withName: "englishButton") as! SKSpriteNode
            englishButton.isHidden = true
            vietnameseButton = self.childNode(withName: "vietnameseButton") as! SKSpriteNode
            vietnameseButton.isHidden = true
            
            musicButton = self.childNode(withName: "musicButton") as! SKSpriteNode
            musicButton.texture = GameSounds.sharedInstance.musicIsMuted ? musicOffTexture : musicOnTexture
            
            soundButton = self.childNode(withName: "soundButton") as! SKSpriteNode
            soundButton.texture = GameSounds.sharedInstance.soundIsMuted ? soundOffTexture : soundOnTexture
            
            }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch: AnyObject in touches {
                let positionOfTouch = touch.location(in: self)
                let tappedNode = atPoint(positionOfTouch)
                let nameOfTappedNode = tappedNode.name
                
                if nameOfTappedNode == "startGameButton" && languageChoosingPause == false{
                    let transition1 = SKTransition.fade(withDuration: 1)
                    let gameScene = GameScene(size: CGSize(width: 1536, height: 2048))
                    gameScene.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene, transition: transition1)                
                }
                if nameOfTappedNode == "tutorialButton" {
                    showLanguageBoard()
                }
                if nameOfTappedNode == "closeButton" {
                    hideLanguageBoard()
                }
                
                if nameOfTappedNode == "englishButton" {
                    let transition2 = SKTransition.fade(withDuration: 1)
                    let tutorialENGScene = SKScene(fileNamed: "TutorialENG") as! TutorialENG
                    tutorialENGScene.scaleMode = .aspectFit
                    self.view?.presentScene(tutorialENGScene, transition: transition2)
                }
                
                if nameOfTappedNode == "vietnameseButton" {
                    let transition3 = SKTransition.fade(withDuration: 1)
                    let tutorialVNScene = SKScene(fileNamed: "TutorialVN") as! TutorialVN
                    tutorialVNScene.scaleMode = .aspectFit
                    self.view?.presentScene(tutorialVNScene, transition: transition3)
                }

                if nameOfTappedNode == "musicButton" {
                    if GameSounds.sharedInstance.toggleMuteMusic() {
                        //is muted
                        musicButton.texture = SKTexture(imageNamed:"musicOff")
                    } else {
                        //is not muted
                        musicButton.texture = SKTexture(imageNamed: "musicOn")
                    }
                }
                if nameOfTappedNode == "soundButton" {
                    if GameSounds.sharedInstance.toggleMuteSound() {
                        //is muted
                        soundButton.texture = SKTexture(imageNamed:"soundOff")
                    } else {
                        //is not muted
                        soundButton.texture = SKTexture(imageNamed: "soundOn")
                    }
                }

            }
        }
    }



