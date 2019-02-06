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
  
  
  var mutableNumber = ""
  var numberArray = [Int]()
  var operation = Operation.add
  
  var currentNumber : Int = 0 {
    didSet{
      mutableNumber = mutableNumber + String(currentNumber)
      consoleLabel.text = String(mutableNumber)
    }
  }
  
  
  
  
  
  @IBAction func whenClearButtonTouchUpInside(_ sender: Any) {
    let zero = 0
    consoleLabel.text = String(zero)
    mutableNumber = ""
    numberArray.removeAll()
    
  }
  
  
  @IBAction func whenNumberButtonTouchUpInside(_ sender: UIButton) {
    if sender.tag <= 9, sender.tag >= 0{
    print("touched: \(sender.tag)")
    currentNumber = sender.tag
    }
    
}

  @IBAction func whenAddButtonTouchedUpInside(_ sender: Any) {
    
    operation = Operation.add
    
    guard let newInt = Int(consoleLabel.text!) else{
      print("cannot convert to int")
      return
    }
  
    numberArray.append(newInt)
    mutableNumber = ""
    consoleLabel.text = String(0)
    
  }
  
  private func performAddition(){
    
    guard let numberOnScreen = Int(consoleLabel.text ?? "0") else{
        print("could not convert string to int")
      return
    }
    
    var sum = numberOnScreen
    
    for i in numberArray {
      print(i)
      sum += i
    }
    
    print(sum)
    mutableNumber = ""
    currentNumber = sum
    numberArray.removeAll()
  }
  
  @IBAction func whenEqualButtonTappedUpInside(_ sender: Any) {
    
    switch operation {
    case .add:
      performAddition()
    default:
      print("do nothing")
    }
    
  }
  
  
  enum Operation {
    case add
    case subtract
    case mulitply
    case divide
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}



