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
  public var image: [UIImageView]?
  public var ratePerSec: KeyValuePairs<UILabel, Double>?
  public var numOwned: KeyValuePairs<UILabel, Double>?
  public var nextPrice: Double?
  public var rateIncrease: KeyValuePairs<UILabel, Double>?
  public var totalProduction: Double?
}

struct StoreItemsConstants {
  static let names: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5"]
  static let basePrices: [Double] = [3.738, 60, 720, 8640, 103680] // The price of buying items for the first time
  static let growthRates: [Double] = [1.07, 1.15, 1.14, 1.13, 1.12]
  static let productionRatesBase: [Double] = [1.67, 20, 90, 360, 2160]
}
