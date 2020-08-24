//
//  StoreItemView.swift
//  Conquer China
//
//  Created by Eric Gustin on 8/23/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit

class StoreItemView: UIView {
  private var image: [UIImageView]?
  private var ratePerSec: KeyValuePairs<UILabel, Int>?
  private var numOwned: KeyValuePairs<UILabel, Int>?
  private var price: Int = 0
  private var rateIncrease: KeyValuePairs<UILabel, Int>?
}
