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
    
    return Double(numberString) ?? 0.0
  }
  
  func convertToNumberWithCommasUsing(_ number: Double) -> String {
    
    let oneBillion = 1000000000.0
    let tenThounsandths = 0.0001
    let oneBillionths = 0.000000001
    
    print(number)
    
    let numberFormatter = NumberFormatter()
    if number <= tenThounsandths {
    
      let formattedNumber = number.removeNotationFormatted
      return formattedNumber
      
    }
    
    // TASK : FIGURE THIS OUTT!!
    if number <= oneBillionths {
      print("yurr")
      let formattedNumber = number.scientificFormatted
      return formattedNumber
    }
    
    
    if number / oneBillion >= 1{
      
      // We have reached 1 Billion
        let formattedNumber = number.scientificFormatted
    
      return formattedNumber
     }else{
      
      numberFormatter.numberStyle = NumberFormatter.Style.decimal
      let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
      
      return formattedNumber!
    }
    

    
  }
  
  func consoleWillDisplayAnswer(_ answer:Double){
    
    // This prints the answer to the console depending on whether the answer has a double with a number after decimal point
    
    if floor(answer) == answer {
//      print(Int(answer))
      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
    }else{
//      print(answer)
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
    
      consoleWillDisplayAnswer(quotient)
    
    }else{
      
      mutableNumberString = ""
      latestNum = latestNum / numberArray.last!
      consoleWillDisplayAnswer(latestNum)
      
    }
  }
  
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
  
  var scientificFormatted: String {
    return Formatter.scientific.string(for: self) ?? ""
  }
  
  var removeNotationFormatted: String {
    return Formatter.avoidNotation.string(for: self) ?? ""
  }
  
}
extension Formatter {
  
  static let scientific: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .scientific
    formatter.positiveFormat = "0.###e+0"
    formatter.exponentSymbol = "E"
    return formatter
  }()
  
  static let avoidNotation: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 8
    numberFormatter.numberStyle = .decimal
    return numberFormatter
  }()
  

}
