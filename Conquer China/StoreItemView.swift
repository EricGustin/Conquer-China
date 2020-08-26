//
//  StoreItemView.swift
//  Conquer China
//
//  Created by Eric Gustin on 8/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit

class StoreItemView: UIView {
  // nextPrice = basePrice * (growthRate)**numOwned
  // totalProduction = (productionRateBase*numOwned)*multipliers  ### multipliers have yet to be implemented
  public var image: UIImageView
  public var currentRatePerSec: KeyValuePairs<UILabel, Double>
  public var numOwned: KeyValuePairs<UILabel, Double>
  public var nextPrice: KeyValuePairs<UILabel, Double>
  public var productionRatesBase: KeyValuePairs<UILabel, Double>
  public var multiplier: Double
  public var totalProduction: Double
  public var itemNumber: Int
  public var verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  var gameScene: GameScene
  
  required init(scene: GameScene, itemNumber: Int) {
    self.gameScene = scene
    self.image = UIImageView(image: StoreItemsConstants.images[itemNumber])
    self.currentRatePerSec = [UILabel(): 0]
    self.numOwned = [UILabel(): 0]
    self.nextPrice = [UILabel(): StoreItemsConstants.basePrices[itemNumber] * pow(StoreItemsConstants.growthRates[itemNumber], numOwned[0].value)]
    self.productionRatesBase = [UILabel(): StoreItemsConstants.productionRatesBase[itemNumber]]
    self.multiplier = 1
    self.totalProduction = productionRatesBase[0].value * numOwned[0].value * multiplier
    self.itemNumber = itemNumber
    
    super.init(frame: .zero)
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked)))
    setUpSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpSubviews() {
    
    currentRatePerSec[0].key.text = "\(productionRatesBase[0].value)/sec"
    numOwned[0].key.text = "\(Int(numOwned[0].value))"
//    numOwned[0].key.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    nextPrice[0].key.text = "\(nextPrice[0].value) yen"
    productionRatesBase[0].key.text = "+\(productionRatesBase[0].value)/sec"
    
    self.addSubview(verticalStack)
    verticalStack.addArrangedSubview(image)
    verticalStack.addArrangedSubview(currentRatePerSec[0].key)
    verticalStack.addArrangedSubview(numOwned[0].key)
    verticalStack.addArrangedSubview(nextPrice[0].key)
    verticalStack.addArrangedSubview(productionRatesBase[0].key)
    verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    verticalStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
//  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//    if keyPath == "text" {
//
//    }
//  }
  
  @objc func itemClicked() {
    if gameScene.totalYen ?? 0 >= nextPrice[0].value {
      print("Buying an item!")
      buyItem()
    }
  }
  
  private func buyItem() {
    if let _ = gameScene.totalYen {
      gameScene.totalYen! -= nextPrice[0].value
      gameScene.totalYenLabel?.text = "\(gameScene.totalYen!)"
    }
    if let _ = gameScene.yenPerSec {
      gameScene.yenPerSec! += productionRatesBase[0].value
      gameScene.yenPerSecLabel?.text = "\(productionRatesBase[0].value)/sec"
    }
    numOwned = [UILabel(): numOwned[0].value + 1]
    numOwned[0].key.text = "\(numOwned[0].value)"
    updateItem()
  }
  
  private func updateItem() {
    
  }
  
}

public struct StoreItemsConstants {
  static let numOfItems: Int = 5
  static let names: [String] = ["item 0", "item 1", "item 2", "item 3", "item 4"]
  static let images: [UIImage] = [
    UIImage(named: "questionmark@4x")!,
    UIImage(named: "questionmark@4x")!,
    UIImage(named: "questionmark@4x")!,
    UIImage(named: "questionmark@4x")!,
    UIImage(named: "questionmark@4x")!
  ]
  static let basePrices: [Double] = [4, 60, 720, 8640, 103680] // The price of buying items for the first time
  static let growthRates: [Double] = [1.07, 1.15, 1.14, 1.13, 1.12]
  static let productionRatesBase: [Double] = [1.67, 20, 90, 360, 2160]
}
