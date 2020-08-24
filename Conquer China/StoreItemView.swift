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
  public var nextPrice: Double
  public var productionRatesBase: KeyValuePairs<UILabel, Double>
  public var multiplier: Double
  public var totalProduction: Double
  public var itemNumber: Int
  
  
  required init(itemNumber: Int) {
    self.image = UIImageView(image: StoreItemsConstants.images[itemNumber])
    self.currentRatePerSec = [UILabel(): 0]
    self.numOwned = [UILabel(): 0]
    self.nextPrice = StoreItemsConstants.basePrices[itemNumber] * pow(StoreItemsConstants.growthRates[itemNumber], numOwned[0].value)
    self.productionRatesBase = [UILabel(): StoreItemsConstants.productionRatesBase[itemNumber]]
    self.multiplier = 1
    self.totalProduction = productionRatesBase[0].value * numOwned[0].value * multiplier
    self.itemNumber = itemNumber
    super.init(frame: .zero)
  
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

struct StoreItemsConstants {
  static let names: [String] = ["item 0", "item 1", "item 2", "item 3", "item 4"]
  static let images: [UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
  static let basePrices: [Double] = [4, 60, 720, 8640, 103680] // The price of buying items for the first time
  static let growthRates: [Double] = [1.07, 1.15, 1.14, 1.13, 1.12]
  static let productionRatesBase: [Double] = [1.67, 20, 90, 360, 2160]
}
