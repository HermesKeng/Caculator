//
//  CurrencyViewController.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 05/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import UIKit

class CurrencyViewController: ViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate{
    
    //UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    //UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        activeTextField.text = currencyList[row]
        sourcePickerView.isHidden = true
    }
    
    @IBOutlet weak var stackBackground: UIView!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    var activeTextField: UITextField!
    @IBOutlet weak var sourcePickerView: UIPickerView!
   
    @IBOutlet weak var outputLabel: UILabel!
    var currencyExchanger : CurrencyExchanger!
    var currencyList=["🇺🇸USD","🇪🇺EUR","🇭🇰HKD","🇹🇼TWD","🇨🇳CNY"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyBoard()
        
        stackBackground.layer.cornerRadius = 10
        
        moneyTextField.delegate = self
        sourcePickerView.dataSource = self
        sourcePickerView.delegate = self
        sourceTextField.delegate = self
        sourceTextField.inputView = sourcePickerView
        sourceTextField.text = currencyList[0]
        goalTextField.inputView = sourcePickerView
        goalTextField.text = currencyList[0]
        currencyExchanger = CurrencyExchanger(money:0)
        // Do any additional setup after loading the view.
    }
    @IBAction func textfieldClick(_ sender: UITextField) {
        sourcePickerView.isHidden=false
    }
    @IBAction func convertBtnClick(_ sender: UIButton){
        if let money = moneyTextField.text{
            currencyExchanger.setMoney(dollars: Double(money)!)
            var transformedMoney=currencyExchanger.moneyTransform(fromCountry: sourceTextField.text!, toCountry: goalTextField.text!)
            outputLabel.text = String(transformedMoney)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == sourceTextField || textField == goalTextField){
            sourcePickerView.isHidden=false
            activeTextField = textField // To know which textfield you click by clicking the textfield
            return false // To avoid activate editing from textfield
        }else{
            print("call keyboard")
            return true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "" // each time update the textfield when you type in new number which is going to transform
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("call return")
        return true
    }
    //add Done button on the numpad keyboard
    func addDoneButtonOnKeyBoard(){
        let doneToolBar:UIToolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.flexibleSpace,target:nil,action:nil)
        let done : UIBarButtonItem = UIBarButtonItem(title:"Done",style:UIBarButtonItemStyle.done,target:self,action:#selector(self.doneButtonAction))

        doneToolBar.setItems([flexSpace,done], animated: false)
        doneToolBar.sizeToFit()
        self.moneyTextField.inputAccessoryView = doneToolBar
    }
    @objc func doneButtonAction()  {
        self.moneyTextField.resignFirstResponder()
    }
    
}
