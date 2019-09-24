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
  
  func fromStringToDouble(theString: String) -> Double {
    
    var numberString = ""
    
    for char in theString {
      
      if char != "," {
        numberString.append(char)
      }
    }
    
    return Double(numberString) ?? 0.0
  }
  
  
  
  func formatNumber(_ number: Double) -> String {
    
    let oneBillion = 1000000000.0
    
  
    let numberFormatter = NumberFormatter()
    if currentAnswer < (number/10000000000.0) {
      //let formattedNumber = number.removeNotationFormatted
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
  
  func displayAnswer(_ answer:Double){
    
    let largestAcceptedNumber = 1.0 * pow(10.0, 100)
    
    if answer > largestAcceptedNumber {
    print("too big.Stop here")
      numberArray.removeAll()
      self.consoleLabel.text = "ERROR"
    }else{
    self.consoleLabel.text = formatNumber(answer)
    }
    
    
  }
  
  func answerToConsole(){
    
    if currentAnswer.canBeInt() {
     print("make Int")
      self.consoleLabel.text = String(Int(currentAnswer))
      
    }else{
      print("\(currentAnswer) is a double")
      self.consoleLabel.text = String(currentAnswer)
    }
  
  }
  
  func performAddition(){
    // convert String on screen to double value and add it to integerArray. Use the Calculation function performAdditionGiven(:) to get total sum

    if(isCurrentOperation){      
      
      currentAnswer = Calculation.performAddition(numberArray)
      numberArray[0] = numberArray.last!
      numberArray[1] = currentAnswer
      
    }else{
      
      currentAnswer = Calculation.performAddition(numberArray)
      numberArray[1] = currentAnswer
      
    }
    
    answerToConsole()
    print(numberArray)
  }
  
  
  
  
  
  func performSubtraction(){
    
    if(isCurrentOperation){
      let numberCurrentlyOnScreen = fromStringToDouble(theString: consoleLabel.text!)
//      numberArray.append(numberCurrentlyOnScreen)

      
      let difference = Calculation.performSubtraction(numberArray)
      currentAnswer = difference
      numberString = ""
      
      displayAnswer(difference)
      
    }else{
      // When currentOperation has no value, perform last operation.
      numberString = ""
      currentAnswer -= numberArray.last!
      displayAnswer(currentAnswer)
    }
  }
  
  func performMultiplication(){
    
    if(isCurrentOperation){
      let numberCurrentlyOnScreen = fromStringToDouble(theString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      let product = Calculation.performMultiplication(numberArray)
//      mutableNumberString = ""
      numberString = ""
      currentAnswer = product
      displayAnswer(currentAnswer)
      
    }else{
      // When currentOperation has no value, perform last operation.
//      mutableNumberString = ""
      numberString = ""
      currentAnswer *= numberArray.last!
      displayAnswer(currentAnswer)
    }
  }
  
  
  func performDivision(){
    
    if(isCurrentOperation){
      let numberCurrentlyOnScreen = fromStringToDouble(theString: consoleLabel.text!)
      numberArray.append(numberCurrentlyOnScreen)
      let quotient = Calculation.performDivision(numberArray)
//      mutableNumberString = ""
      numberString = ""
      currentAnswer = quotient

      displayAnswer(currentAnswer)
      
      
    
    }else{
      
//      mutableNumberString = ""
      numberString = ""
      currentAnswer = Double(currentAnswer / numberArray.last!)
      print(currentAnswer)
      displayAnswer(currentAnswer)
      
    }
  }
  
}


extension UIButton {
  
  func normalColor(){
    UIView.animate(withDuration: 0.3) {
      self.backgroundColor = UIColor(red: 250.0/255.0, green: 69.0/255.0, blue: 103.0/255.0, alpha: 100)
      self.setTitleColor(.white, for: .normal)
    }
  }
  
  func selectedColor(){
    UIView.animate(withDuration: 0.3) {
      self.backgroundColor = .white
      self.setTitleColor(UIColor(red: 250.0/255.0, green: 69.0/255.0, blue: 103.0/255.0, alpha: 100), for: .normal)
    }
  }
  
}

extension Double {
  
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
  
  func canBeInt() -> Bool {
    
    let dbl = self
    let isInteger = floor(dbl) == dbl
    
    return isInteger
  }
  
  var scientificFormatted: String {
    return Formatter.scientific.string(for: self) ?? ""
  }

  
}
extension Formatter {
  
  static let scientific: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .scientific
    formatter.maximumFractionDigits = 20
    formatter.positiveFormat = "0.#e+0"
    formatter.negativeFormat = "0.#e-0"
    formatter.exponentSymbol = "E"
    return formatter
  }()
  

}
