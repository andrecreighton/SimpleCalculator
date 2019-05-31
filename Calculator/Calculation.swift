//
//  SimpleCalculator.swift
//  Calculator
//
//  Created by Andre Creighton on 2/7/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation

class Calculation {
  
  
  static var symbolDictionary = ["+" : Operation.add,
                                 "-" : Operation.subtract,
                                 "÷" : Operation.divide,
                                 "x" : Operation.mulitply]
  
  enum Operation {
    case add
    case subtract
    case mulitply
    case divide
    case none
  }
  
  
  static func negate(_ number:Double) -> Double {
    return number * -1
  }
  
  static func getPercentage(_ number:Double) -> Double {
    return number/100
  }
  
  
  
  static func performDivision(_ divisionArray:[Double]) -> Double{
    
    let count = divisionArray.count
    
    let xNum = divisionArray[count-2]
    let yNum = divisionArray[count-1]
    
    return xNum / yNum
  
  }
  
  static func performMultiplication(_ multiplyArray:[Double]) -> Double{
  
    let count = multiplyArray.count
  
    let xNum = multiplyArray[count-2]
    let yNum = multiplyArray[count-1]
  
  return xNum * yNum
  }
  static func performSubtraction(_ subtractionArray:[Double]) -> Double{
    
    let count = subtractionArray.count
    
    let xNUM = subtractionArray[count-2]
    let yNUM = subtractionArray[count-1]
    
    return xNUM - yNUM
  }
  
  static func performAddition(_ addendArray:[Double]) ->Double{

    let count = addendArray.count
    
    let xNUM = addendArray[count-2]
    let yNUM = addendArray[count-1]
    
    return xNUM + yNUM
  }
  

  
}
