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
  @IBOutlet weak var decimalButton: UIButton!
  
  var currentOperationButton = UIButton()
  var containsDecimal = false
  var isCurrentOperation = false
  var mutableNumberString = ""
  var integerArray = [Int]()
  var doubleArray = [Double]()
  var numberArray = [Double]()
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
    integerArray.removeAll()
    doubleArray.removeAll()
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
      integerArray.removeAll()
    }
    // whatever operation button is highlighted, should be reversed back to normal. set current operation to false.
    if(isCurrentOperation){
      currentOperationButton.reverseColorEffect()
      isCurrentOperation = false
    }
  }

  func processUsingSymbol(_ symbol:String){
    
    // returns value of string whether its a integer or a double
    let foo = Calculation.ValueType.getValueFrom(aString: consoleLabel.text!)
    
    // adds number to specific array based on type
    switch foo  {
    case .double(let numThatIsDouble):
     // doubleArray.append(numThatIsDouble)
      numberArray.append(numThatIsDouble)
      print("number of double value added to Array")
    case .int(let numThatIsInt):
      numberArray.append(Double(numThatIsInt))
      print("number of integer value added to number Array")
    }
    
    
    switch symbol {
    case "+":
      print("add")
      operation = Calculation.symbolDictionary[symbol] ?? .none
      //      let newInt = convertedIntFromString(consoleLabel.text)
      
      //integerArray.append(newInt)
      mutableNumberString = ""
      
    case "-":
      print("subtract")
      operation = Calculation.symbolDictionary[symbol] ?? .none

    //  integerArray.append(newInt)
      mutableNumberString = ""
      
    case "x":
      print("multiply")
      operation = Calculation.symbolDictionary[symbol] ?? .none

   //   integerArray.append(newInt)
      mutableNumberString = ""
      
    case "÷":
      print("divide")
      operation = Calculation.symbolDictionary[symbol] ?? .none

 //     doubleArray.append(Double(newInt))
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





// TASK : WHEN CALCULATIONS COMPLETE, START ADDING DOUBLE VALUES


