//
//  ViewController.swift
//  Calculator
//
//  Created by Andre Creighton on 2/5/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class SimpleCalculatorViewController: UIViewController {
  
  @IBOutlet weak var consoleLabel: UILabel!
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet var operationButtons: [UIButton]!
  
  var currentOperationButton = UIButton()
  var isCurrentOperation = false
  var mutableNumberString = ""
  var numberArray = [Int]()
  var doubleArray = [Double]()
  var operation = Calculation.Operation.add
  
  
  var currentNumber : Int = 0 {
    didSet{
      mutableNumberString = mutableNumberString + String(currentNumber)
      print("mutableNumberString:\(mutableNumberString)")
      consoleLabel.text = mutableNumberString
    }
  }


  @IBAction func whenClearButtonTouchUpInside(_ sender: Any) {
    
    let zero = 0
    consoleLabel.text = String(zero)
    mutableNumberString = ""
    numberArray.removeAll()
    doubleArray.removeAll()
    
    if(isCurrentOperation){
      currentOperationButton.reverseColorEffect()
      isCurrentOperation = false
    }

    
  }
  
  @IBAction func whenNumberButtonTouchUpInside(_ sender: UIButton) {
    if sender.tag <= 9, sender.tag >= 0{
    currentNumber = sender.tag
    print(sender.tag)
    }
}
  
  @IBAction func whenActionButtonTouchedUpInside(_ sender: UIButton) {
    
    
    if !(isCurrentOperation){
      print("no current operation")
      sender.reverseColorEffect()
      currentOperationButton = sender
      isCurrentOperation = true
    }else{
      print("current opertaion highlighted")
      for button in operationButtons {
        if button == sender {
         //do nothing
        }else{
          sender.reverseColorEffect()
          currentOperationButton.reverseColorEffect()
          currentOperationButton = sender
          isCurrentOperation = true
        }
      }
      
    }
    guard let symbol = sender.titleLabel?.text else{
      print("couldn't translate symbol")
      return
    }
    
    processUsingSymbol(symbol)
    
  }
  
  @IBAction func whenNegateTappedUpInside(_ sender: Any) {
    
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    
    let newNum = Calculation.negateUsing(numberOnScreen)
    mutableNumberString = ""
    currentNumber = newNum
    
  }
  
  @IBAction func whenPercentTappedUpInside(_ sender: Any) {
    
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    
    let percentage = Calculation.getPercentageUsing(Double(numberOnScreen))
    mutableNumberString = ""
    print(percentage)
  //  currentNumber = percentage
    
  }
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {

    print("mutableNumberString: \(mutableNumberString)")
    if numberArray.count > 0 || doubleArray.count > 0 {
      
    switch operation {
    case .add:
      performAddition()
      mutableNumberString = ""
    case .subtract:
      performSubtraction()
      mutableNumberString = ""
    case .mulitply:
      performMultiplication()
      mutableNumberString = ""
    case .divide:
      performDivision()
      mutableNumberString = ""
    default:
      print("do nothing")
    }
    
    }else{
      print("No numbers in array perform this instead")
      mutableNumberString = ""
      numberArray.removeAll()
    }
    // whatever operation button is highlighted, should be reversed back to normal. set current operation to false.
    if(isCurrentOperation){
      currentOperationButton.reverseColorEffect()
      isCurrentOperation = false
    }
  }

  func processUsingSymbol(_ symbol:String){
    
    switch symbol {
    case "+":
      print("add")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      let newInt = convertedIntFromString(consoleLabel.text)
      numberArray.append(newInt)
      mutableNumberString = ""
      
    case "-":
      print("subtract")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      let newInt = convertedIntFromString(consoleLabel.text)
      
      numberArray.append(newInt)
      mutableNumberString = ""
      
    case "x":
      print("multiply")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      let newInt = convertedIntFromString(consoleLabel.text)
      
      numberArray.append(newInt)
      mutableNumberString = ""
      
    case "÷":
      print("divide")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      let newInt = convertedIntFromString(consoleLabel.text)
      
      doubleArray.append(Double(newInt))
      mutableNumberString = ""
    default:
      print("Nada")
    }
    
  }
  
  func convertedIntFromString(_ stringValue: String?) -> Int {
    
  let numberValue = Int(stringValue ?? "0")
  return numberValue!
  
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override var prefersStatusBarHidden: Bool{
    return false
  }
}



extension SimpleCalculatorViewController {
  
  func performAddition(){
    // convert String on screen to int value and add it to numberArray. Use the Calculation function performAdditionGiven(:) to get total sum
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    numberArray.append(numberOnScreen)
    
    let sum = Calculation.performAdditionGiven(numberArray)
    
    mutableNumberString = ""
    currentNumber = sum
  }
  
  func performSubtraction(){
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    
    numberArray.append(numberOnScreen)
    let difference = Calculation.performSubtractionUsing(numberArray)
    
    mutableNumberString = ""
    currentNumber = difference
  }
  
  func performMultiplication(){
    
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    
    numberArray.append(numberOnScreen)
    let product = Calculation.performMultiplicationUsing(numberArray)
    
    mutableNumberString = ""
    currentNumber = product
  }
  
  
  func performDivision(){
    
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


// TASK : WHEN CALCULATIONS COMPLETE, START ADDING DOUBLE VALUES


