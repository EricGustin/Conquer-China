//
//  GameScene.swift
//  Conquer China
//
//  Created by Eric Gustin on 7/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import SpriteKit
import GameplayKit

public class GameScene: SKScene {
  
  public var gameScene: GameScene?
    
  private var topBackground: UIView?
  private var bottomBackground: UIView?
  private var storeScrollView: UIScrollView?
  private var storeItemContainers: [UIView]?
  private var yenImage: SKSpriteNode?
  private var smallYenImage: UIImageView?  // Placed to the left of the user's totalYenLabel
  private var levelLabel: UILabel?
  private var level: Int?
  private var levelProgressBar: UIProgressView?
  public var totalYenLabel: UILabel?
  public var totalYen: Int?
  public var smallNumTotalYen: Double?
  public var yenPerSecLabel: UILabel?
  public var yenPerSec: Int?
  
  public var isSmallYenPerSec: Bool = true
  
  // Views for items in store
  private var storeItems: [StoreItemView]?
  
  private var subviewsScale = CGFloat()
  
  public override func didMove(to view: SKView) {
    Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(customUpdate), userInfo: nil, repeats: false)
    self.gameScene = self
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
    createStoreItems()
  }
  
  public override func update(_ currentTime: TimeInterval) {
  }
  
  @objc public func customUpdate(_ currentTime: TimeInterval) {
    if isSmallYenPerSec {
      if (yenPerSec ?? 0) < 100 {
        smallNumTotalYen! += (Double(yenPerSec ?? 0))/100
        totalYenLabel?.text = String(format: "%.01f", smallNumTotalYen!)
        totalYen = Int(smallNumTotalYen!)
      }
      else {
        isSmallYenPerSec = !isSmallYenPerSec
        totalYen = Int(smallNumTotalYen!)
      }
    } else {
      totalYen! += (yenPerSec ?? 0)/100
      totalYenLabel?.text = "\(totalYen!)"
      totalYen = totalYen!
    }
    
    Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(customUpdate), userInfo: nil, repeats: false)
  }
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
      storeItemContainers?.append(UIView(frame: CGRect(x: CGFloat(i) * view!.safeAreaLayoutGuide.layoutFrame.width/3, y: 0, width: view!.safeAreaLayoutGuide.layoutFrame.width/3 - 1, height: UIScreen.main.bounds.height/5)))
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
    level = 1
    levelLabel = UILabel()
    levelLabel?.textColor = .white
    levelLabel?.text = "Level \(level ?? 0)"
    levelLabel?.font = .systemFont(ofSize: 20*subviewsScale, weight: .heavy)
    levelLabel?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelLabel!)
    levelLabel?.topAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.topAnchor, constant: 5*subviewsScale).isActive = true
    levelLabel?.leadingAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.leadingAnchor, constant: 5*subviewsScale).isActive = true
    levelLabel?.layoutIfNeeded()
  }
  
  private func createLevelProgressBar() {
    levelProgressBar = UIProgressView()
    levelProgressBar?.progressTintColor = .systemGreen
    levelProgressBar?.translatesAutoresizingMaskIntoConstraints = false
    view?.addSubview(levelProgressBar!)
    levelProgressBar?.topAnchor.constraint(equalTo: levelLabel!.bottomAnchor, constant: 5*subviewsScale).isActive = true
    levelProgressBar?.leadingAnchor.constraint(equalTo: levelLabel!.leadingAnchor).isActive = true
    levelProgressBar?.widthAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
    levelProgressBar?.heightAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.widthAnchor, multiplier: 0.04).isActive = true
    levelProgressBar?.layoutIfNeeded()
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
  }
  
  private func createTotalYenLabel() {
    smallNumTotalYen = 0
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
  }
  
  private func createStoreItems() {

    storeItems = [
      StoreItemView(scene: &(gameScene!), itemNumber: 0),
      StoreItemView(scene: &(gameScene!), itemNumber: 1),
      StoreItemView(scene: &(gameScene!), itemNumber: 2),
      StoreItemView(scene: &(gameScene!), itemNumber: 3),
      StoreItemView(scene: &(gameScene!), itemNumber: 4)
    ]

    for (index, storeItem) in storeItems!.enumerated() {
      storeItem.tag = index
      storeItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked)))
      storeItem.translatesAutoresizingMaskIntoConstraints = false
      storeItemContainers![index].addSubview(storeItem)
      storeItem.leadingAnchor.constraint(equalTo: storeItemContainers![index].leadingAnchor).isActive = true
      storeItem.trailingAnchor.constraint(equalTo: storeItemContainers![index].trailingAnchor).isActive = true
      storeItem.topAnchor.constraint(equalTo: storeItemContainers![index].topAnchor).isActive = true
      storeItem.bottomAnchor.constraint(equalTo: storeItemContainers![index].bottomAnchor).isActive = true
      
    }
  }
  
  @objc func itemClicked(sender: UITapGestureRecognizer) {
    if let item = sender.view {
      if isSmallYenPerSec {
        if smallNumTotalYen! >= Double((item as! StoreItemView).nextPrice.value) {
          buyItem(item: item as! StoreItemView)
        }
      }
      else {
        if totalYen! >= (item as! StoreItemView).nextPrice.value {
          buyItem(item: item as! StoreItemView)
        }
      }
    }
  }
  
  private func buyItem(item: StoreItemView) {
    if isSmallYenPerSec {
      smallNumTotalYen! -= Double(item.nextPrice.value)
      totalYenLabel?.text = "\(smallNumTotalYen!)"
      yenPerSec! += item.productionRatesBase[0].value
      yenPerSecLabel?.text = "\(yenPerSec!)/sec"
    }
    else {
      totalYen! -= item.nextPrice.value
      totalYenLabel?.text = "\(totalYen!)"
      yenPerSec! += item.productionRatesBase[0].value
      yenPerSecLabel?.text = "\(yenPerSec!)/sec"
    }
    updateItem(item: item)
  }
  
  private func updateItem(item: StoreItemView) {
    item.numOwned.value = item.numOwned.value + 1
    item.numOwned.key.text = "\(Int(item.numOwned.value))"
    let doubleNextPrice = Double(StoreItemsConstants.basePrices[item.tag]) * pow(StoreItemsConstants.growthRates[item.tag], Double(item.numOwned.value))
    item.nextPrice.value = Int(doubleNextPrice)
    item.nextPrice.key.text = "\(item.nextPrice.value) yen"
  }
  
  private func updateTotalYen() {
    if isSmallYenPerSec {
      smallNumTotalYen? += 1
      totalYenLabel?.text = "\(smallNumTotalYen!)"
      totalYenLabel?.layoutIfNeeded()
      totalYenLabel?.updateFocusIfNeeded()
      totalYenLabel?.setNeedsLayout()
    }
    else {
      totalYen? += 1
      totalYenLabel?.text = "\(totalYen ?? 0)"
    }
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
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
}
