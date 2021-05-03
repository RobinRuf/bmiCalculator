//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Robin Ruf on 11.12.20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets / vars
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var clickHereButton: UIButton!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Beim Start der App wird der Button deaktiviert
        clickHereButton.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        clickHereButton.isEnabled = false
        
        addTargetToTextField()
    }

    // MARK: - Actions / funcs
    @IBAction func clickHereButton_Tapped(_ sender: UIButton) {
        checkBMI(value: calculateBMI())
    }
    
    func calculateBMI() -> Double {
        
        let height = Double(heightTextField.text!)!
        let weight = Double(weightTextField.text!)!
        
        let heightSquare = height * height
        let bmi = weight / heightSquare
        
        return bmi
    }
    
    // BMI wird berechnet
    func checkBMI(value: Double) {
        var message = ""
        
        // unter 20 = Untergewicht
        // 20 - 25 = Normalgewicht
        // 25 - 30 = Übergewicht
        // 30 - 40 = Adipositas (Fettleibigkeit)
        
        if value <= 19.9 {
            message = "Dein BMI beträgt " + String(format: "%.2f", value) + ", du bist Untergewichtig!"
        } else if value >= 20.0 && value <= 24.9 {
            message = "Dein BMI beträgt " + String(format: "%.2f", value) + ", du bist Normalgewichtig!"
        } else if value >= 25.0 && value <= 29.9 {
            message = "Dein BMI beträgt " + String(format: "%.2f", value) + ", du bist Übergewichtig!"
        } else if value >= 30.0 {
            message = "Dein BMI beträgt " + String(format: "%.2f", value) + ", du bist Adipös!"
        }
        
        alertResult(message: message)
        
    }
    
    // Alert zur Anzeige des BMI's
    func alertResult(message: String) {
        let alert = UIAlertController(title: "\(nameTextField.text!)", message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action) in }
        
        alert.addAction(action1)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addTargetToTextField() {
        nameTextField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        heightTextField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        
        nameTextField.addTarget(self, action: #selector(nameTextFieldChange), for: UIControl.Event.editingDidEnd)
        heightTextField.addTarget(self, action: #selector(heightTextFieldChange), for: UIControl.Event.editingDidEnd)
    }
    
    @objc func nameTextFieldChange() {
        let name = nameTextField.text!
        nameTextField.text = name.capitalizingFirstLetter()
    }
    
    @objc func heightTextFieldChange () {
        let heightAsString = heightTextField.text!
        
        let characterset = CharacterSet(charactersIn: ".,")
        
        if heightAsString.rangeOfCharacter(from: characterset) != nil {
            let heightAsDouble = Double(heightAsString)!
            heightTextField.text = "\(Int(heightAsDouble * 100.0))"
        } else {
            let heightAsDouble2 = Double(heightAsString)!
            heightTextField.text = "\(heightAsDouble2 / 100.0)"
        }
    }
    
    @objc func textFieldChanged() {
        if !(nameTextField.text!.isEmpty) && !(heightTextField.text!.isEmpty) && !(weightTextField.text!.isEmpty) {
            
            clickHereButton.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
            clickHereButton.isEnabled = true
        } else {
            
            clickHereButton.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
            clickHereButton.isEnabled = false
        }
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
 
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
