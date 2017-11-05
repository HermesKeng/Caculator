//
//  CurrencyViewController.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 05/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import UIKit

class CurrencyViewController: ViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        activeTextField.text = currencyList[row]
        sourcePickerView.isHidden = true
    }
    
    
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    var activeTextField: UITextField!
    @IBOutlet weak var sourcePickerView: UIPickerView!
    @IBAction func textfieldClick(_ sender: UITextField) {
        sourcePickerView.isHidden=false
    }
    var currencyList=["USD","EUR","HKD","TWD","RMB"]
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcePickerView.dataSource = self
        sourcePickerView.delegate = self
        sourceTextField.delegate = self
        sourceTextField.inputView = sourcePickerView
        sourceTextField.text = currencyList[0]
        goalTextField.inputView = sourcePickerView
        goalTextField.text = currencyList[0]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        sourcePickerView.isHidden=false
        activeTextField = textField
        return false
    }

   

}
