//
//  ViewController.swift
//  Tipsy
//
//  Created by Abdihakin Elmi on 10/28/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet  var myview: UIView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipTexField: UITextField!
    @IBOutlet weak var totalPerPerson: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var splitLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 0
    var billTotal = 0.0
    var finalResult = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.isHidden = true
        tipTexField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myview.layer.cornerRadius = 24
        backButton.layer.cornerRadius = 24
        calculateButton.layer.cornerRadius = 24
    }
    // hide keyboard when view is tapped
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        /// handling code
        billAmount.resignFirstResponder()
        tipTexField.resignFirstResponder()
    }
    
    // getting the number of people to split the tip
    /// - Parameter sender: UIStepper
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    // calculate Button
    @IBAction func didTabCalculate(){
        if let text = billAmount.text, !text.isEmpty, let tibText = tipTexField.text, !tibText.isEmpty {
            myview.isHidden = false
            view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            self.myview.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.myview.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.myview.transform = .identity
                self.myview.alpha = 1
            }
            
            ///Get the text the user typed in the tipTextField
            let title = tipTexField.text!
            /// convert the string to double
            let titleAsAnswer = Double(title)!
            ///Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
            tip = titleAsAnswer / 100
    
            ///Get the text the user typed in the billTextField
            let bill = billAmount.text!
            
            ///If the text is not an empty String ""
            if bill != "" {
                
                ///Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
                ///e.g. 125.50
                billTotal = Double(bill)!
                
                ///Multiply the bill by the tip percentage and divide by the number of people to split the bill.
                let result = billTotal * (1 + tip) / Double(numberOfPeople)
                
                ///Round the result to 2 decimal places and turn it into a String.
                _ = String(format: "%.2f", result)
                finalResult = String(format: "%.2f", result)
                
                let tip = tipTexField.text!
                totalPerPerson.text = finalResult
                splitLabel.text = "Split between \(numberOfPeople) people, with \(tip)% tip."
            }
            /// show toast message
        } else {
            showToast(message: "Add bill please", font: UIFont.systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func didtabBack(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.myview.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.myview.alpha = 0
        } completion: { (completion) in
            if completion {
                self.myview.isHidden = true
                self.view.backgroundColor = .systemBackground
                self.billAmount.text = ""
                self.tipTexField.text = ""
                self.splitNumberLabel.text = "0"
                self.billAmount.becomeFirstResponder()
            }
        }
    }
}
// Toast extention
extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - self.view.frame.size.height/4, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
