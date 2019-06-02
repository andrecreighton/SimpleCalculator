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
    
  
    let numberFormatter = NumberFormatter()
    if number < 0.1 {

      let formattedNumber = number.removeNotationFormatted
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
    
//    // This prints the answer to the console depending on whether the answer has a double with a number after decimal point
//    if floor(answer) == answer {
////      print(Int(answer))
//      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
//    }else{
////      print(answer)
//      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
//    }
//
    let smallestAcceptedNumber = 1.0 * pow(10.0, -22)
    let largestAcceptedNumber = 1.0 * pow(10.0, 100)
    
    
    if answer < smallestAcceptedNumber || answer > largestAcceptedNumber {
      print("Stop here")
      self.consoleLabel.text = "ERROR"
    }else{
      self.consoleLabel.text = convertToNumberWithCommasUsing(answer)
    }
    
  
  
  }
  
  func performAddition(){
    // convert String on screen to double value and add it to integerArray. Use the Calculation function performAdditionGiven(:) to get total sum
    
    if(isCurrentOperation){
      
      let numberCurrentlyOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      
      mutableNumberString = ""
      let sum = Calculation.performAddition(numberArray)
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
  
      let difference = Calculation.performSubtraction(numberArray)
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
      let product = Calculation.performMultiplication(numberArray)
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
      let quotient = Calculation.performDivision(numberArray)
      mutableNumberString = ""
      latestNum = quotient

      consoleWillDisplayAnswer(latestNum)
      
      
    
    }else{
      
      mutableNumberString = ""
      latestNum = Double(latestNum / numberArray.last!)
      print(latestNum)
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
    numberFormatter.maximumFractionDigits = 22
    numberFormatter.numberStyle = .decimal
    return numberFormatter
  }()
  

}
