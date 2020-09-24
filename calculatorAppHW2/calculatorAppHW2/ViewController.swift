//
//  ViewController.swift
//  calculatorAppHW2
//
//  Created by Field Employee on 9/23/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculationTotal: UILabel!
    
    var num1 = 0
    var operation: State?
    var num2 = 0
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    enum State {
        case add, subtract, multiply, divide
    }
    
    @IBAction func totoalCalculation(_ sender: UIButton) {

        if sender.tag == 20 {
            calculationTotal.text = String(result)
        }
        
        switch sender.tag {
        case 1...9:
            calculationTotal.text = String(sender.tag)
            if (num1 != 0) {
                num2 = sender.tag

            } else {
                num1 = sender.tag
            }
        case 10:
            operation = .add
        case 11:
            operation = .subtract
        case 12:
            operation = .multiply
        case 13:
            operation = .divide
        default:
        return
        }

        if (operation != nil) {
            if 1...9 ~= sender.tag{
                switch operation {
            case .add:
                
              result =  num1 + num2
                if (num2 != 0) {
                calculationTotal.text = String(num2)
                    num1 = 0
                    num2 = 0
                }
            case .subtract:
                result = num1 - num2
                if (num2 != 0) {
                calculationTotal.text = String(num2)
                    num1 = 0
                    num2 = 0
                }
            case .multiply:
                
                result = num1 * num2
                if (num2 != 0) {
                calculationTotal.text = String(num2)
                    num1 = 0
                    num2 = 0
                }
            case .divide:
               
                result = num1 / num2
                if (num2 != 0) {
                calculationTotal.text = String(num2)
                    num1 = 0
                    num2 = 0
                }
            case .none:
                return
            
        }
        }
        }
        
       
    }
    
    @IBAction func emptyOut(_ sender: UIButton) {
        calculationTotal.text = "0"
    }
}

