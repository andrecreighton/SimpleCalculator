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
  var mutableNumber = ""
  var numberArray = [Int]()
  var operation = Calculation.Operation.add
  
  var currentNumber : Int = 0 {
    didSet{
      mutableNumber = mutableNumber + String(currentNumber)
      print("mutableNumber:\(mutableNumber)")
      consoleLabel.text = String(mutableNumber)
    }
  }
  
  var symbolDictionary = ["+" : Calculation.Operation.add,
                          "-" : Calculation.Operation.subtract,
                          "÷" : Calculation.Operation.divide,
                          "x" : Calculation.Operation.mulitply]
  
  

  @IBAction func whenClearButtonTouchUpInside(_ sender: Any) {
    let zero = 0
    consoleLabel.text = String(zero)
    mutableNumber = ""
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
    
    sender.reverseColorEffect()
    currentOperationButton = sender
    isCurrentOperation = true
    
    for button in operationButtons {
      if sender != button, button.backgroundColor == sender.backgroundColor {
        button.reverseColorEffect()
      }
    }
    
    guard let symbol = sender.titleLabel?.text else{
      print("couldn't translate symbol")
      return
    }
    processUsingSymbol(symbol)
    
  }

  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {
    
      sender.reverseColorEffect()
      sender.reverseColorEffect()
 
    if numberArray.count > 0{
      
      print(numberArray)
      
    switch operation {
    case .add:
      performAddition()
    case .subtract:
      performSubtraction()
    default:
      print("do nothing")
    }
    
    }else{
      print("No numbers in array perform this instead")
      mutableNumber = ""
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
      operation = symbolDictionary[symbol] ?? .none
      guard let newInt = Int(consoleLabel.text!) else{
        print("cannot convert to int")
        return
      }
      numberArray.append(newInt)
      mutableNumber = ""
      consoleLabel.text = String(0)
      
    case "-":
      print("subtract")
      operation = symbolDictionary[symbol] ?? .none
    case "x":
      print("multiply")
      operation = symbolDictionary[symbol] ?? .none
    case "÷":
      print("divide")
      operation = symbolDictionary[symbol] ?? .none
    default:
      print("Nada")
    }
    
  }
  
  func performAddition(){
    // set number on screen to int value and add it to numberArray. Use the Calculation function performAdditionGiven(:) to get total sum
    
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
      print("could not convert string to int")
      return
    }
    let addend = numberOnScreen
    numberArray.append(addend)
    
    let sum = Calculation.performAdditionGiven(numberArray)
    
    mutableNumber = ""
    currentNumber = sum
    numberArray.removeAll()
  }
  
  
  
  func performSubtraction(){
    
    
    
    
    
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




