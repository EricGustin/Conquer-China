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
  private var smallYenImage: UIImageView?  // Placed to the left of the user's totalYenLabel
  private var levelLabel: UILabel?
  private var level: Int?
  private var levelProgressBar: UIProgressView?
  private var totalYenLabel: UILabel?
  private var totalYen: Double?
  private var yenPerSecLabel: UILabel?
  private var yenPerSec: Double?
  
  private var subviewsScale = CGFloat()
  
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
    createSmallYenImage()
    createTotalYenLabel()
    createYenPerSecLabel()
  }
  
  override func update(_ currentTime: TimeInterval) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.yenImage != nil {
      updateLevelProgressBar()
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
    topBackground?.layoutIfNeeded()
    subviewsScale = (topBackground!.frame.height/203)
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
    levelLabel?.font = .systemFont(ofSize: 20*subviewsScale, weight: .heavy)
    levelLabel?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelLabel!)
    levelLabel?.topAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.topAnchor, constant: 5*subviewsScale).isActive = true
    levelLabel?.leadingAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.leadingAnchor, constant: 5*subviewsScale).isActive = true
    levelLabel?.layoutIfNeeded()
    print(levelLabel!.frame.height)
    print(topBackground!.frame.height)
    print()
  }
  
  private func createLevelProgressBar() {
    levelProgressBar = UIProgressView()
    levelProgressBar?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelProgressBar!)
    levelProgressBar?.topAnchor.constraint(equalTo: levelLabel!.bottomAnchor, constant: 5*subviewsScale).isActive = true
    levelProgressBar?.leadingAnchor.constraint(equalTo: levelLabel!.leadingAnchor).isActive = true
    levelProgressBar?.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    levelProgressBar?.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.04).isActive = true
    levelProgressBar?.layoutIfNeeded()
    print(levelProgressBar!.frame.height)
    print(topBackground!.frame.height)
    print()
  }
  
  private func createSmallYenImage() {
    smallYenImage = UIImageView(image: UIImage(named: "yenCoin@4x"))
    smallYenImage?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(smallYenImage!)
    smallYenImage?.widthAnchor.constraint(equalToConstant: 20*subviewsScale).isActive = true
    smallYenImage?.heightAnchor.constraint(equalToConstant: 20*subviewsScale).isActive = true
    smallYenImage?.leadingAnchor.constraint(equalTo: levelLabel!.leadingAnchor).isActive = true
    smallYenImage?.topAnchor.constraint(equalTo: levelProgressBar!.bottomAnchor, constant: 20*subviewsScale).isActive = true
    smallYenImage?.layoutIfNeeded()
    print(smallYenImage!.frame.height)
    print(topBackground!.frame.height)
    print()
  }
  
  private func createTotalYenLabel() {
    totalYen = 0
    totalYenLabel = UILabel()
    totalYenLabel?.textColor = .white
    totalYenLabel?.text = "\(totalYen ?? 0)"
    totalYenLabel?.font = .systemFont(ofSize: 24*subviewsScale, weight: .heavy)
    totalYenLabel?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(totalYenLabel!)
    totalYenLabel?.centerYAnchor.constraint(equalTo: smallYenImage!.centerYAnchor).isActive = true
    totalYenLabel?.leadingAnchor.constraint(equalTo: smallYenImage!.trailingAnchor, constant: 5*subviewsScale).isActive = true
    totalYenLabel?.layoutIfNeeded()
    print(totalYenLabel!.frame.height)
    print(topBackground!.frame.height)
    print()
  }
  
  private func createYenPerSecLabel() {
    yenPerSec = 0
    yenPerSecLabel = UILabel()
    yenPerSecLabel?.textColor = .white
    yenPerSecLabel?.text = "\(yenPerSec ?? 0)/ sec"
    yenPerSecLabel?.font = .systemFont(ofSize: 14*subviewsScale, weight: .heavy)
    yenPerSecLabel?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(yenPerSecLabel!)
    yenPerSecLabel?.topAnchor.constraint(equalTo: totalYenLabel!.bottomAnchor, constant: 5*subviewsScale).isActive = true
    yenPerSecLabel?.leadingAnchor.constraint(equalTo: totalYenLabel!.leadingAnchor).isActive = true
    yenPerSecLabel?.layoutIfNeeded()
    print(yenPerSecLabel!.frame.height)
    print(topBackground!.frame.height)
    print()
  }
  
  private func updateTotalYen() {
    totalYen? += 1
    totalYenLabel?.text = "\(totalYen ?? 0.0)"
  }
  
  private func updateLevelProgressBar() {
    levelProgressBar?.setProgress(levelProgressBar!.progress + 0.05, animated: true)
    if levelProgressBar?.progress == 1.0 {
      levelProgressBar?.setProgress(0.0, animated: false)
      updateLevel()
    }
  }
  
  private func updateLevel() {
    level! += 1
    levelLabel?.text = "Level \(level!)"
  }
  
  func touchDown(atPoint pos : CGPoint) {}
  func touchMoved(toPoint pos : CGPoint) {}
  func touchUp(atPoint pos : CGPoint) {}
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
}
