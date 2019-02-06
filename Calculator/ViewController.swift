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
  var numberArray = [0]
  var operation = Operation.add
  
  var currentNumber : Int = 0 {
    didSet{
      mutableNumber = mutableNumber + String(currentNumber)
      consoleLabel.text = String(mutableNumber)
    }
  }
  
  var symbolDictionary = ["+" : Operation.add,
                          "-" : Operation.subtract,
                          "÷" : Operation.divide,
                          "x" : Operation.mulitply]
  
  

  @IBAction func whenClearButtonTouchUpInside(_ sender: Any) {
    let zero = 0
    consoleLabel.text = String(zero)
    mutableNumber = ""
    numberArray.removeAll()
  
    if(isCurrentOperation){
      currentOperationButton.reverseColorEffect()
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
      }else if sender == button{
        
      }
    }
    
    
    guard let symbol = sender.titleLabel?.text else{
      print("couldn't translate symbol")
      return
    }
    
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
  
  
  private func performAddition(){
    // get the number that is adding on to the number already stored.
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
        print("could not convert string to int")
      return
    }
  
    // set that number to sum
    var sum = numberOnScreen
    
    //iterate all numbers and add to sum
    for i in numberArray {
      print(i)
      sum += i
    }
    
    print(sum)
    mutableNumber = ""
    currentNumber = sum
    numberArray.removeAll()
  }
  
  private func performSubtraction(){
    
    
    
    
    
  }
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: UIButton) {
    
      sender.reverseColorEffect()
      sender.reverseColorEffect()
 
    if numberArray.count > 0{
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
    
    if(isCurrentOperation){
      currentOperationButton.reverseColorEffect()
    }

  }
  
  enum Operation {
    case add
    case subtract
    case mulitply
    case divide
    case none
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
