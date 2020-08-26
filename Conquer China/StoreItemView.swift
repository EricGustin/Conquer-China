//
//  StoreItemView.swift
//  Conquer China
//
//  Created by Eric Gustin on 8/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit

class StoreItemView: UIView {
  
  public static var totalYen = 0
  
  
  // nextPrice = basePrice * (growthRate)**numOwned
  // totalProduction = (productionRateBase*numOwned)*multipliers  ### multipliers have yet to be implemented
  public var image: UIImageView
  public var currentRatePerSec: KeyValuePairs<UILabel, Int>
  public var numOwned: (key: UILabel, value: Int)
  public var nextPrice: (key: UILabel, value: Int)
  public var productionRatesBase: KeyValuePairs<UILabel, Int>
  public var multiplier: Int
  public var totalProduction: Int
  public var itemNumber: Int
  public var verticalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  var gameScene: GameScene
  
  required init(scene: inout GameScene, itemNumber: Int) {
    self.gameScene = scene
    self.image = UIImageView(image: StoreItemsConstants.images[itemNumber])
    self.currentRatePerSec = [UILabel(): 0]
    self.numOwned = (UILabel(), 0)
    let doubleNextPrice = Double(StoreItemsConstants.basePrices[itemNumber]) * pow(StoreItemsConstants.growthRates[itemNumber], Double(numOwned.value))
    self.nextPrice = (UILabel(), Int(doubleNextPrice))
    self.productionRatesBase = [UILabel(): StoreItemsConstants.productionRatesBase[itemNumber]]
    self.multiplier = 1
    self.totalProduction = productionRatesBase[0].value * numOwned.value * multiplier
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
    numOwned.key.text = "\(Int(numOwned.value))"
    nextPrice.key.text = "\(nextPrice.value) yen"
    productionRatesBase[0].key.text = "+\(productionRatesBase[0].value)/sec"
    
    self.addSubview(verticalStack)
    verticalStack.addArrangedSubview(image)
    verticalStack.addArrangedSubview(currentRatePerSec[0].key)
    verticalStack.addArrangedSubview(numOwned.key)
    verticalStack.addArrangedSubview(nextPrice.key)
    verticalStack.addArrangedSubview(productionRatesBase[0].key)
    verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    verticalStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  @objc func itemClicked() {
    print(StoreItemView.totalYen)
    if StoreItemView.totalYen >= nextPrice.value {
      buyItem()
    }
  }
  
  private func buyItem() {
    if let _ = gameScene.totalYen {
      gameScene.totalYen! -= nextPrice.value
      gameScene.totalYenLabel?.text = "\(gameScene.totalYen!)"
    }
    if let _ = gameScene.yenPerSec {
      gameScene.yenPerSec! += productionRatesBase[0].value
      gameScene.yenPerSecLabel?.text = "\(gameScene.yenPerSec!)/sec"
    }
    updateItem()
  }
  
  private func updateItem() {
    numOwned.value = numOwned.value + 1
    numOwned.key.text = "\(Int(numOwned.value))"
    let doubleNextPrice = Double(StoreItemsConstants.basePrices[itemNumber]) * pow(StoreItemsConstants.growthRates[itemNumber], Double(numOwned.value))
    nextPrice.value = Int(doubleNextPrice)
    nextPrice.key.text = "\(nextPrice.value) yen"
  }
  
}

//extension StoreItemView: NSCopying {
//  func copy(with zone: NSZone? = nil) -> Any {
//    let
//  }
//}

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
  static let basePrices: [Int] = [4, 60, 720, 8640, 103680] // The price of buying items for the first time
  static let growthRates: [Double] = [1.07, 1.15, 1.14, 1.13, 1.12]
  static let productionRatesBase: [Int] = [2, 20, 90, 360, 2160]
}
