//
//  ViewController.swift
//  Calculator
//
//  Created by Andre Creighton on 2/5/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var consoleLabel: UILabel!
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet var operationButtons: [UIButton]!
  
  var currentOperationButton = UIButton()
  var isCurrentOperation = false
  var mutableNumberString = ""
  var numberArray = [Int]()
  var answerArray = [Int]()
  var operation = Calculation.Operation.add
  
  
  var currentNumber : Int = 0 {
    didSet{
      mutableNumberString = mutableNumberString + String(currentNumber)
      print("mutableNumberString:\(mutableNumberString)")
      consoleLabel.text = String(mutableNumberString)
    }
  }


  @IBAction func whenClearButtonTouchUpInside(_ sender: Any) {
    let zero = 0
    consoleLabel.text = String(zero)
    mutableNumberString = ""
    numberArray.removeAll()
  
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
    
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
      print("could not convert string to int")
      return
    }
    
    let newNum = Calculation.negateUsing(numberOnScreen)
    mutableNumberString = ""
    currentNumber = newNum
    
  }
  
  @IBAction func whenPercentTappedUpInside(_ sender: Any) {
    
    guard let numberOnScreen = Double(consoleLabel.text ?? "0") else{
      print("could not convert string to int")
      return
    }
    
    let percentage = Calculation.getPercentageUsing(numberOnScreen)
    mutableNumberString = ""
    print(percentage)
  //  currentNumber = percentage
    
  }
  
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {


    print("mutableNumberString: \(mutableNumberString)")
    if numberArray.count > 0{
      
      print(numberArray)
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
      guard let newInt = Int(consoleLabel.text!) else{
        print("cannot convert to int")
        return
      }
      numberArray.append(newInt)
      mutableNumberString = ""
      
      
    case "-":
      print("subtract")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      guard let newInt = Int(consoleLabel.text!) else{
        print("cannot convert to int")
        return
      }
      
      numberArray.append(newInt)
      mutableNumberString = ""
      
    case "x":
      print("multiply")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      guard let newInt = Int(consoleLabel.text!) else{
        print("cannot convert to int")
        return
      }
      
      numberArray.append(newInt)
      mutableNumberString = ""
      
    case "÷":
      print("divide")
      operation = Calculation.symbolDictionary[symbol] ?? .none
    default:
      print("Nada")
    }
    
  }
  
  func performAddition(){
    // convert String on screen to int value and add it to numberArray. Use the Calculation function performAdditionGiven(:) to get total sum
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
      print("could not convert string to int")
      return
    }
    let addend = numberOnScreen
    numberArray.append(addend)
    
    let sum = Calculation.performAdditionGiven(numberArray)
    
    mutableNumberString = ""
    currentNumber = sum
    numberArray.removeAll()
  }
  
  func performSubtraction(){
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
      print("could not convert string to int")
      return
    }
    
    numberArray.append(numberOnScreen)
    let difference = Calculation.performSubtractionUsing(numberArray)
    
    mutableNumberString = ""
    currentNumber = difference
    numberArray.removeAll()
  }
  
  func performMultiplication(){
 
    let numberOnScreen = convertedIntFromString(consoleLabel.text)
    
    numberArray.append(numberOnScreen)
    let product = Calculation.performMultiplicationUsing(numberArray)
    
    mutableNumberString = ""
    currentNumber = product
    numberArray.removeAll()
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





// TASK : WHEN CALCULATIONS COMPLETE, START ADDING DOUBLE VALUES


