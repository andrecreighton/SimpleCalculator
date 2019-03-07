//
//  ViewController.swift
//  Calculator
//
//  Created by Andre Creighton on 2/5/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class SimpleCalculatorViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var consoleLabel: UILabel!
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet var operationButtons: [UIButton]!
  @IBOutlet weak var decimalButton: UIButton!
  
  var currentOperationButton = UIButton()
  var containsDecimal = false
  var isCurrentOperation = false
  var mutableNumberString = ""
  var numberArray = [Double]()
  var operation = Calculation.Operation.add
  
  var latestNum = 0.0 // Used to store lastest answer when using it in another operation.
  
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
    containsDecimal = false
    
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
    
    guard let doubleValue = Double(consoleLabel.text!) else{
      print("Could not convert to Double")
      return
    }
    
    if doubleValue / 1000 >= 1 {
      let value = convertToNumberWithCommasUsing(doubleValue)
      consoleLabel.text = value
    }
    
}
  
  
  @IBAction func whenDecimalPointTouchUpInside(_ sender: Any) {
    
    if(containsDecimal){
      // do nothing
    }else{
      mutableNumberString.append(".")
      consoleLabel.text?.append(".")
      containsDecimal = true
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

    
    containsDecimal = false
    processUsingSymbol(symbol)
    
  }
  
  @IBAction func whenNegateTappedUpInside(_ sender: Any) {
    
    let numberOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
    
    let negatedNum = Calculation.negateUsing(numberOnScreen)
    mutableNumberString = ""
    consoleWillDisplayAnswer(negatedNum)
 
    
  }
  
  @IBAction func whenPercentTappedUpInside(_ sender: Any) {
    
    let numberOnScreen = removeCommasIfAnyAndConvertToDouble(theString: consoleLabel.text!)
    
    let percentage = Calculation.getPercentageUsing(Double(numberOnScreen))
    mutableNumberString = ""
    consoleWillDisplayAnswer(percentage)
    print(percentage)
  //  currentNumber = percentage
    
  }
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {

    print("Number Array Count \(numberArray.count)")
    if numberArray.count > 0 {
      
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
    
    
    // When a operation sign is tapped, We will store the number currently on display to the number array.
    
    guard let currentStringOnConsole = consoleLabel.text else {
      print("Cannot convert to String type")
      return
    }
    
    let doubleValue = removeCommasIfAnyAndConvertToDouble(theString: currentStringOnConsole)
    numberArray.append(doubleValue)
  
    switch symbol {
    case "+":
      print("add")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      mutableNumberString = ""
      
    case "-":
      print("subtract")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      mutableNumberString = ""
      
    case "x":
      print("multiply")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      mutableNumberString = ""
      
    case "÷":
      print("divide")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      mutableNumberString = ""
    default:
      print("Nada")
    }
    
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





// TASK : WHEN CALCULATIONS COMPLETE, START ADDING DOUBLE VALUES


