//
//  GameScene.swift
//  Conquer China
//
//  Created by Eric Gustin on 7/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  private var topBackground: UIView?
  private var bottomBackground: UIView?
  private var storeScrollView: UIScrollView?
  private var storeItemContainers: [UIView]?
  private var yenImage: SKSpriteNode?
  private var levelLabel: UILabel?
  private var level: Int?
  private var levelProgressBar: UIProgressView?
  private var totalYenLabel: UILabel?
  private var totalYen: Double?
  private var yenPerSecLabel: UILabel?
  private var yenPerSec: Double?
  
  override func didMove(to view: SKView) {
    self.backgroundColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 37.5/255, alpha: 1.0)
    addFallingYen()
    createTopBackground()
    createBottomBackground()
    createStoreScrollView()
    createStoreItemContainers()
    createYenImage()
    createLevelLabel()
    createLevelProgressBar()
    createTotalYenLabel()
    createYenPerSecLabel()
  }
  
  override func update(_ currentTime: TimeInterval) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.yenImage != nil {
      yenImage?.run(SKAction.scale(by: 0.95, duration: 0.05), completion: {
        self.yenImage?.run(SKAction.scale(by: 0.95, duration: 0.05).reversed())
      })
    }
    updateTotalYen()
  }
  
  func addFallingYen() {
    if let fallingYen = SKEmitterNode(fileNamed: "FallingYenAnimation.sks") {
      fallingYen.zPosition = -1
      addChild(fallingYen)
      fallingYen.position.y = scene!.frame.maxY
      fallingYen.particlePositionRange.dx = scene!.frame.width*0.7
    }
  }
  
  private func createTopBackground() {
    topBackground = UIView()
    topBackground?.backgroundColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 50/255, alpha: 1.0)
    topBackground?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(topBackground!)
    topBackground?.centerXAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.centerXAnchor).isActive = true
    topBackground?.topAnchor.constraint(equalTo: view!.topAnchor).isActive = true
    topBackground?.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor).isActive = true
    topBackground?.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
  }
  
  private func createBottomBackground() {
    bottomBackground = UIView()
    bottomBackground?.backgroundColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 50/255, alpha: 1.0)
    bottomBackground?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(bottomBackground!)
    bottomBackground?.centerXAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.centerXAnchor).isActive = true
    bottomBackground?.bottomAnchor.constraint(equalTo: view!.bottomAnchor).isActive = true
    bottomBackground?.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor).isActive = true
    bottomBackground?.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.heightAnchor, multiplier: 0.325).isActive = true
  }
  
  private func createStoreScrollView() {
    storeScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5))
    storeScrollView?.backgroundColor = .clear
    bottomBackground?.addSubview(storeScrollView!)
    storeScrollView?.contentSize = CGSize(width: UIScreen.main.bounds.width*6, height: storeScrollView!.frame.height)
  }
  
  private func createStoreItemContainers() {
    storeItemContainers = [UIView]()
    for i in 0...17 {
      storeItemContainers?.append(UIView(frame: CGRect(x: CGFloat(i) * view!.safeAreaLayoutGuide.layoutFrame.width/3, y: 0, width: view!.safeAreaLayoutGuide.layoutFrame.width/3 - 1, height: UIScreen.main.bounds.width)))
      storeItemContainers?[i].backgroundColor = .white
      storeScrollView?.addSubview(storeItemContainers![i])
    }
  }
  
  private func createYenImage() {
    yenImage = SKSpriteNode(imageNamed: "yenCoin@4x")
    yenImage?.setScale(0.2)
    addChild(yenImage!)
  }
  
  private func createLevelLabel() {
    level = 0
    levelLabel = UILabel()
    levelLabel?.textColor = .white
    levelLabel?.text = "Level \(level ?? 0)"
    levelLabel?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelLabel!)
    levelLabel?.topAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    levelLabel?.leadingAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
  }
  
  private func createLevelProgressBar() {
    levelProgressBar = UIProgressView()
    levelProgressBar?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelProgressBar!)
    levelProgressBar?.topAnchor.constraint(equalTo: levelLabel!.bottomAnchor, constant: 5).isActive = true
    levelProgressBar?.leadingAnchor.constraint(equalTo: levelLabel!.leadingAnchor).isActive = true
    levelProgressBar?.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    levelProgressBar?.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.05).isActive = true
  }
  
  private func createTotalYenLabel() {
    totalYenLabel = UILabel()
    totalYenLabel?.textColor = .white
  }
  
  private func createYenPerSecLabel() {
    
  }
  
  private func updateTotalYen() {
    totalYen? += 1
    totalYenLabel?.text = "\(totalYen ?? 0.0)"
  }
  
  func touchDown(atPoint pos : CGPoint) {}
  func touchMoved(toPoint pos : CGPoint) {}
  func touchUp(atPoint pos : CGPoint) {}
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
}
