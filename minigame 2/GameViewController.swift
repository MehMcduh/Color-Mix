//
//  GameViewController.swift
//  minigame 2
//
//  Created by Bui Thu Ha on 12/25/16.
//  Copyright © 2016 dunno. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

extension Notification.Name {
    static let showAd = Notification.Name(rawValue: "NotificationShowAd")
}

class GameViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    var bannerView = GADBannerView()
    var interstitialAd : GADInterstitial?
    var musicWasStoppedByAd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAdMobBanner()
        interstitialAd = createInterstitial()
        NotificationCenter.default.addObserver(self, selector: #selector(randomPresentationOfAdWithFrequency), name: .showAd, object: nil)
        //Menu
        if let scene = MenuScene(fileNamed:"MenuScene") {
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
        }
        // sounds
        GameSounds.sharedInstance.playBackgroundMusic()
        }
    
    
                                                        // CREATE BANNER AD
    func initAdMobBanner() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: 728, height: 90))
            bannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 728, height: 90)
        }else if  UIDevice.current.userInterfaceIdiom == .phone {
            bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            bannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        }
        bannerView.adUnitID = "ca-app-pub-9896907013967265/2844480031"
        bannerView.rootViewController = self
        bannerView.delegate = self
        view.addSubview(bannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.load(request)
        
    }
 
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(bannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(bannerView)
    }
    
    // --------------------------------------------------CREATE INTERSTITIAL AD--------------------------------------------
    
    func createInterstitial() -> GADInterstitial {
        let requestInter = GADRequest()
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9896907013967265/6804858034")
        interstitial.delegate = self
        interstitial.load(requestInter)
        requestInter.testDevices = [kGADSimulatorID]
        return interstitial
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        if GameSounds.sharedInstance.musicIsMuted == false {
            GameSounds.sharedInstance.audioPlayer?.stop()
            musicWasStoppedByAd = true
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
       interstitialAd = createInterstitial()
        if musicWasStoppedByAd == true {
            GameSounds.sharedInstance.playBackgroundMusic()
            musicWasStoppedByAd = false
        }
    }
    
    func randomNumberInRange(lower: Int, upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func randomPresentationOfAdWithFrequency() {
        let randomNumber = randomNumberInRange(lower: 1, upper: 5)
        print("Random number: \(randomNumber)")
        if randomNumber == 1 {
            if interstitialAd != nil {
                if interstitialAd!.isReady {
                    interstitialAd?.present(fromRootViewController: self)
                    print("Ad presented")
                } else {
                    print("Ad was not ready for presentation")
                }
            }
            
        }
    }
   // -------------------------------------------------------------------------------------------------------------------------
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
