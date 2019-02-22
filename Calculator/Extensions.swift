//
//  Extensions.swift
//  Calculator
//
//  Created by Andre Creighton on 2/7/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation
import UIKit



extension SimpleCalculatorViewController {
  
  
  func consoleWillDisplayAnswer(_ answer:Double){
    
    // This prints the answer to the console depending on whether the answer has a double with a number after decimal point
    
    if floor(answer) == answer {
      print(Int(answer))
      self.consoleLabel.text = "\(Int(answer))"
    }else{
      print(answer)
      self.consoleLabel.text = "\(answer)"
    }
    
  }
  
  
  func performAddition(){
    // convert String on screen to int value and add it to integerArray. Use the Calculation function performAdditionGiven(:) to get total sum
    
    if(isCurrentOperation){
      
      let numberCurrentlyOnScreen = Calculation.returnDoubleValue(aString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      
      mutableNumberString = ""
      let sum = Calculation.performAdditionGiven(numberArray)
      latestNum = sum
      consoleWillDisplayAnswer(sum)
      
    }else{
      
      // When currentOperation has no value, perform last operation.
      mutableNumberString = ""
      latestNum += numberArray.last!
      consoleWillDisplayAnswer(latestNum)
      
      
    }
  }
  
  func performSubtraction(){
    
    if(isCurrentOperation){
      let numberCurrentlyOnScreen = Calculation.returnDoubleValue(aString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
  
      let difference = Calculation.performSubtractionUsing(numberArray)
      latestNum = difference
      mutableNumberString = ""
      consoleWillDisplayAnswer(difference)
      
    }else{
      // When currentOperation has no value, perform last operation.
      mutableNumberString = ""
      latestNum -= numberArray.last!
      consoleWillDisplayAnswer(latestNum)
    }
  }
  
  func performMultiplication(){
    
    if(isCurrentOperation){
      let numberOnScreen = convertedIntFromString(consoleLabel.text)
      integerArray.append(numberOnScreen)
      let product = Calculation.performMultiplicationUsing(integerArray)
      mutableNumberString = ""
      currentNumber = product
    }else{
      // When currentOperation has no value, perform last operation.
      mutableNumberString = ""
      currentNumber *= integerArray.last!
    }
  }
  
  
  func performDivision(){
    
    if(isCurrentOperation){
      let numberOnScreen = convertedIntFromString(consoleLabel.text)
      doubleArray.append(Double(numberOnScreen))
      let quotient = Calculation.performDivisionUsing(doubleArray)
      
      mutableNumberString = ""
      print("quotient \(quotient)")
      
      if(floor(quotient) == quotient){
        print("is an integer")
        currentNumber = Int(quotient)
      }else{
        consoleLabel.text = "\(quotient.rounded(toPlaces: 5))"
        print("not an integer")
      }
      
      //currentNumber = quotient
      
      
    }
  }
  
}


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

extension Double {
  
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
  
}
