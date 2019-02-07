//
//  Extensions.swift
//  Calculator
//
//  Created by Andre Creighton on 2/7/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation
import UIKit


extension String {
  
//  let groupingSeparator = "," // determined based on user input, as per the question
//
//  let formatter = NumberFormatter()
//  formatter.positiveFormat = "###,###"
//  formatter.negativeFormat = "-###,###"
//  formatter.groupingSeparator = groupingSeparator
//
//  if let string = formatter.string(from: 18686305) {
//    print(string) // prints "1868,6305"
//  }
//

}


extension UIButton {
  
  func reverseColorEffect(){
    
    UIView.animate(withDuration: 0.3) {
      let backgroundColor = self.backgroundColor
      let titleColor = self.titleColor(for: .normal)
      
      self.setTitleColor(backgroundColor, for: .normal)
      self.backgroundColor = titleColor
    }
    
  }
  

}
