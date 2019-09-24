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
  
  
  @IBOutlet weak var subtractionButton: UIButton!
  @IBOutlet weak var multiplicationButton: UIButton!
  @IBOutlet weak var divisionButton: UIButton!
  
  var currentOperationButton = UIButton()
  var isCurrentOperation = false
  var numberArray = [Double]()
  var operation = Calculation.Operation.add
  var numberOnScreen : Double = 0
  var numberString = ""
  var nonIntegerValue = false
  var numB = 0.0
  
  var currentAnswer = 0.0 // Used to store lastest answer when using it in another operation.
  

  @IBAction func whenClearButtonTouchUpInside(_ sender: UIButton) {
  
    
    numberString = ""
    consoleLabel.text = String(0)
    numberArray.removeAll()
    nonIntegerValue = false
  
    
    if(isCurrentOperation){
      currentOperationButton.normalColor()
      isCurrentOperation = false
    }
    
  }
  
  @IBAction func whenNumberButtonTouchUpInside(_ sender: UIButton) {
    
    if sender.tag <= 9, sender.tag >= 0 {
  
      numberString = numberString + String(sender.tag)
      consoleLabel.text = numberString
  
      print(numberString)
      
    }
    
    if isCurrentOperation {
      
      currentOperationButton.normalColor()
  
    }
}
  
  
  @IBAction func whenDecimalPointTouchUpInside(_ sender: Any) {
    
    if(nonIntegerValue){
      // do nothing
    }else{
      
      numberString.append(".")
      consoleLabel.text = numberString
      nonIntegerValue = true
    }
  
  }

  
  @IBAction func whenPercentTappedUpInside(_ sender: Any) {
    
    if consoleLabel.text!.isEmpty {
      //do nothing
      // 0 is always in the console, but just for extra precaution
    }else{
    let numberOnScreen = fromStringToDouble(theString: numberString)
    consoleLabel.text = String(Calculation.getPercentage(Double(numberOnScreen)))
    numberString = ""
    }
  }
  
  @IBAction func whenNegateTappedUpInside(_ sender: Any) {
    
    if !numberString.isEmpty{
      
      if nonIntegerValue {
        
        print("double value")
        let double = Double(numberString)
        numberString = String( -1 * double!)
        consoleLabel.text = numberString
        
      }else{
        
        let int = Int(numberString)
        numberString = String(-1 * int!)
        consoleLabel.text = numberString
        
      }
      
    }
    
  }
  
  @IBAction func whenActionButtonTouchedUpInside(_ sender: UIButton) {
    
   
    if numberString != "0", numberString != ""{
       // convert to double, add to numberarray
      // clear console for next number input
        let stringConvertedToNumber = Double(numberString)
        numberArray.append(stringConvertedToNumber!)
        numberString = ""
      
    }else{
      // add the number zero to array for zero needs to be in console as the default
      numberArray.append(0)
    }
  
    
 // get currentOpertaion
    if !(isCurrentOperation){
      sender.selectedColor()
      currentOperationButton = sender
      isCurrentOperation = true
    }else{
      
    //check to see if any other button is highlighted. If so, change that button back to normal
    //and make new operationbutton highlighted and becomes new currentOperation
      
      for button in operationButtons {
        if button == sender {
          //do nothing
        }else{
          sender.selectedColor()
          currentOperationButton.normalColor()
          currentOperationButton = sender
          isCurrentOperation = true
        }
      }
      
    }
    // get the operationSymbol
    guard let operationSymbol = sender.titleLabel?.text else{
      //      print("couldn't translate symbol")
      return
    }
    
    // reset nonIntegerValue for next number input
    nonIntegerValue = false
    
    //
    processUsingSymbol(operationSymbol)
    
    
    if numberArray.count == 2{
    
      performOperation()
      let newFirst = currentAnswer
      numberArray.removeAll()
      numberArray.append(newFirst)
      
    }
    
  }
  
  func processUsingSymbol(_ symbol:String){
    
    switch symbol {
    case "+":
      //      print("add")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      
    case "-":
      //      print("subtract")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      
    case "x":
      //      print("multiply")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      
    case "÷":
      //      print("divide")
      operation = Calculation.symbolDictionary[symbol] ?? .none
  
    default:
      print("Nada")
    }
    
  }
  
  func performOperation(){
    
    switch operation {
    case .add:
      performAddition()
    case .subtract:
      performSubtraction()
    case .mulitply:
      performMultiplication()
    case .divide:
      performDivision()
    default:
      print("do nothing")
    }
    
  }
  
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {
    
    // when equal tapped, set number to value in console.
    // add number to array if array less than 2
    
    if numberArray.count < 2 {
      numberString = consoleLabel.text!
      let stringConvertedToNumber = Double(numberString)
      numberArray.append(stringConvertedToNumber!)
    
      if(isCurrentOperation){
        performOperation()
        currentOperationButton.normalColor()
        isCurrentOperation = false
      }else{
        print("no current operation, perform \(operation)")
        performOperation()
      }
  }
    
    if numberArray.count == 2 {
      
        if(isCurrentOperation){
          performOperation()
          currentOperationButton.normalColor()
          isCurrentOperation = false
      }else{
        print("no current operation, perform \(operation)")
        performOperation()
      }
      
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


