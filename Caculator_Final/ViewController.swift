//
//  ViewController.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 15/10/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*override func viewDidLoad() {
     super.viewDidLoad()
     // Do any additional setup after loading the view, typically from a nib.
     }
     
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }*/
    
    @IBOutlet weak var Display: UILabel!
    private var caculatorBrain=CaculatorBrain()
    
    var iskeyin=false
    var displayValue:Double{
        get{
            return Double(Display.text!)!
        }
        set{
            let isInt = floor(newValue) == newValue
            if(isInt){
                Display.text=String(format:"%.0f",newValue)
            }else{
                Display.text=String(round(newValue*1000000000)/1000000000)
            }
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        if iskeyin{
            caculatorBrain.setOperand(_operand: displayValue)
            iskeyin=false
        }
        if let operation=sender.currentTitle{
    
            caculatorBrain.performOperation(_symbol: operation)
        }
        if let result=caculatorBrain.result{
            displayValue=result
        }
    }

    @IBAction func DigitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("digit \(digit) pressed")
        
        if !iskeyin{
            Display.text=digit
            if(digit == "0"){
                caculatorBrain.setOperand(_operand: Double(digit)!)
                caculatorBrain.resetMultiplexer()
            }else{
                iskeyin=true
            }
        }else{
            if let currentNum=Display.text{
                if(Int32(currentNum)!<INT_MAX/10){
                    Display.text=currentNum+digit
                }
            }
        }
    }
}

