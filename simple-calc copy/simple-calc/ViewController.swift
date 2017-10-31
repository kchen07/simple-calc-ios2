//
//  ViewController.swift
//  simple-calc
//
//  Created by Kelley Lu Chen on 10/23/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var inputString = ""
    var operationType = ""
    private var history = [String]()
    

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier! == "historySegue") {
        
        let dest = segue.destination as! HistoryViewController
        dest.history = self.history
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        let value = sender.titleLabel?.text
        inputString += value!
        textField.text = inputString
    }
    
    @IBAction func count(_ sender: Any) {
        if (operationType == "" || operationType == "count") {
            operationType = "count"
            inputString += "count"
            textField.text = inputString
        } else {
            clearContent()
        }
    }
    
    @IBAction func average(_ sender: Any) {
        if (operationType == "" || operationType == "average") {
            operationType = "average"
            inputString += "avg"
            textField.text = inputString
        } else {
            clearContent()
        }
    }
    
    @IBAction func factorial(_ sender: Any) {
        let input = textField.text
        var res = 1
        let first_val = UInt.init(input!)!
        for index in 1...first_val{
            res *= Int(index)
        }
        let newEq = "\(input!) = \(res)"
        history.append(newEq)
        inputString = String(res)
        textField.text = inputString
        clearContent()
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        let value = sender.titleLabel?.text
        inputString += value!
        textField.text = inputString
    }
    
    
    @IBAction func equalsPressed(_ sender: Any) {
        let input = textField.text
        if (operationType == "count") {
            let numbers = input?.components(separatedBy: "count")
            var count = 0
            for number in numbers! {
                if (number != "") {
                    count += 1
                }
            }
            let newEq = "\(input!) = \(count)"
            history.append(newEq)
            textField.text = String(count)
        } else if (operationType == "average") {
            var numbers = input?.components(separatedBy: "avg")
            var sum = 0.0
            for index in 0...((numbers?.count)! - 1) {
                sum += Double(numbers![index])!
            }
            let res = sum / Double((numbers?.count)!)
            let newEq = "\(input!) = \(res)"
            history.append(newEq)
            textField.text = String(res)
        } else { // Math operation
            var result = 0.0
            if (input?.contains("+"))! {
                var numbers = input?.components(separatedBy: "+")
                if ((numbers?.count)! < 2) {
                    clearContent()
                } else {
                    result = Double(numbers![0])!
                    for index in 1...((numbers?.count)! - 1) {
                        result += Double(numbers![index])!
                    }
                }
            } else if (input?.contains("-"))! {
                var numbers = input?.components(separatedBy: "-")
                if ((numbers?[1] == "")) {
                    clearContent()
                } else {
                    result = Double(numbers![0])!
                    for index in 1...((numbers?.count)! - 1) {
                        result -= Double(numbers![index])!
                    }
                }
            } else if (input?.contains("*"))! {
                var numbers = input?.components(separatedBy: "*")
                if ((numbers?[1] == "")) {
                    clearContent()
                } else {
                    result = Double(numbers![0])!
                    for index in 1...((numbers?.count)! - 1) {
                        result *= Double(numbers![index])!
                    }
                }
            } else if (input?.contains("/"))!{
                var numbers = input?.components(separatedBy: "/")
                if ((numbers?[1] == "")) {
                    clearContent()
                } else {
                    result = Double(numbers![0])!
                    for index in 1...((numbers?.count)! - 1) {
                        result /= Double(numbers![index])!
                    }
                }
            } else if (input?.contains("%"))!{
                var numbers = input?.components(separatedBy:"%")
                if ((numbers?[1] == "")) {
                    clearContent()
                } else {
                    let first_val = Double(numbers![0])
                    let second_val = Double(numbers![1])
                    result = Double((first_val?.truncatingRemainder(dividingBy: Double(second_val!)))!)
                }
            } else {
                result = 0.0
            }
            let newHistory = "\(input!) = \(result)"
            history.append(newHistory)
            textField.text = String(result)
        }
        clearContent()
    }
    // Clear button pressed
    @IBAction func clear(_ sender: Any) {
        clearContent()
        clearDisplay()
    }
    
    // Clears everything the program is saving about current operation
    func clearContent() {
        inputString = ""
        operationType = ""
    }
    
    // Clears display
    func clearDisplay() {
        textField.text = inputString
    }
}

