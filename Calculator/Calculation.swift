//
//  SimpleCalculator.swift
//  Calculator
//
//  Created by Andre Creighton on 2/7/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation

class Calculation {
  
  enum Operation {
    case add
    case subtract
    case mulitply
    case divide
    case none
  }
  
  
  
  static var symbolDictionary = ["+" : Operation.add,
                                 "-" : Operation.subtract,
                                 "÷" : Operation.divide,
                                 "x" : Operation.mulitply]

  
  static func negateUsing(_ number:Int) -> Int {
    return number * -1
  }
  
  static func getPercentageUsing(_ number:Double) -> Double {
    return number/100
  }
  
  
  
  static func performDivisionUsing(_ divisionArray:[Double]) -> Double{
    
    let count = divisionArray.count
    let first = divisionArray[count-2]
    let second = divisionArray[count-1]
    
  
    let quotient = first/second
    return quotient
  
  }
  
  static func performMultiplicationUsing(_ multiplyArray:[Int]) -> Int{
  
  let count = multiplyArray.count
  let first = multiplyArray[count-2]
  let second = multiplyArray[count-1]
  
  return first * second
  }
  static func performSubtractionUsing(_ subtractionArray:[Int]) -> Int{
    
    let count = subtractionArray.count
    let first = subtractionArray[count-2]
    let second = subtractionArray[count-1]
    
    return first - second
  }
  
  static func performAdditionGiven(_ addendArray:[Int]) ->Int{

    let count = addendArray.count
    let first = addendArray[count-2]
    let second = addendArray[count-1]

    return first + second
  }

  

  
}
