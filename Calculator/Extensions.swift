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
  
  func removeCommasIfAnyAndConvertToDouble(theString: String) -> Double {
    
    var numberString = ""
    
    for char in theString {
      
      if char != "," {
        
        numberString.append(char)
      }
      
    }
    print(numberString)
    
    return Double(numberString) ?? 0.0
  }
  
  func convertToNumberWithCommasUsing(_ number: Double) -> String {
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
    
    return formattedNumber!
  }
  
  
  func consoleWillDisplayAnswer(_ answer:Double){
    
    // This prints the answer to the console depending on whether the answer has a double with a number after decimal point
    
    if floor(answer) == answer {
      print(Int(answer))
      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
    }else{
      print(answer)
      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
    }
    
  }
  

  func performAddition(){
    // convert String on screen to int value and add it to integerArray. Use the Calculation function performAdditionGiven(:) to get total sum
    
    if(isCurrentOperation){
      
      let numberCurrentlyOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
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
      let numberCurrentlyOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
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
      let numberCurrentlyOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      let product = Calculation.performMultiplicationUsing(numberArray)
      mutableNumberString = ""
      latestNum = product
      consoleWillDisplayAnswer(latestNum)
      
    }else{
      // When currentOperation has no value, perform last operation.
      mutableNumberString = ""
      latestNum *= numberArray.last!
      consoleWillDisplayAnswer(latestNum)
    }
  }
  
  
  func performDivision(){
    
    if(isCurrentOperation){
      let numberCurrentlyOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      let quotient = Calculation.performDivisionUsing(numberArray)
      mutableNumberString = ""
      latestNum = quotient
      
      
      if(floor(quotient) == quotient){
        print("is an integer")
        
        consoleWillDisplayAnswer(quotient)
      }else{
        
        consoleWillDisplayAnswer(quotient.rounded(toPlaces: 4))
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
