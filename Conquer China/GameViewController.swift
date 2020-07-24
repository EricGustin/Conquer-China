//
//  GameViewController.swift
//  Conquer China
//
//  Created by Eric Gustin on 7/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
//  let emitterNode = SKEmitterNode(fileNamed: "FallingYenAnimation.sks")!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addFallingYen()
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "GameScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Present the scene
        view.presentScene(scene)
      }
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  func addFallingYen() {
//    let skView = SKView(frame: view.frame)
//    skView.backgroundColor = .clear
//    let scene = SKScene(size: view.frame.size)
//    scene.backgroundColor = .clear
//    skView.presentScene(scene)
//    skView.isUserInteractionEnabled = false
//    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//    scene.addChild(emitterNode)
//    emitterNode.position.y = scene.frame.maxY
//    emitterNode.particlePositionRange.dx = scene.frame.width
//    view.addSubview(skView)
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
