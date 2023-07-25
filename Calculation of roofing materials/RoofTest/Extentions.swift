//
//  Extentions.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 21.02.2022.
//

import Foundation
import UIKit

//Округление до нужного количества знаков после запятой
func roundToNSigns(x: Float, toSigns: Int) -> Float {
    let y = Float(pow(10.0, Float(toSigns)))

    return Float(lroundf(Float(y) * Float(x)))/y
}

//===================================================================================================================================================

extension String {
    func decimalWithPoint() -> String? {
        // получить разделитель долей в зависимости от региона (чаще всего точка или запятая)
        let localDecimalSeparator = Locale.current.decimalSeparator ?? "."
        // заменить текущий разделитель на точку
        return self.replacingOccurrences(of: localDecimalSeparator, with: ".")
    }
}

//===================================================================================================================================================

extension Int {
    func asDouble() -> Double {
        return Double(self)
    }
}

//===================================================================================================================================================

extension UIViewController {
    
    func setTitle(title: String, aligment: NSTextAlignment) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = title
        label.textAlignment = aligment

        self.navigationItem.titleView = label
    }

    @objc func goBack() {
        let _ = navigationController?.popViewController(animated: true)
    }

    func showErrorWarning(_ msg: String) {
        let alert  = UIAlertController(title: "Внимание!", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}

//=================================================================================================================================================
extension UITextField {
    
    func addNextToolbar(onNext: (target: Any, action: Selector)? = nil) {
        let onNext = onNext ?? (target: self, action: #selector(nextButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Next", style: .plain, target: onNext.target, action: onNext.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    func addFinishToolbarWithDirection(from: (target: Any, action: Selector)? = nil,
                                       to: (target: Any, action: Selector)? = nil,
                                       finifh: (target: Any, action: Selector)? = nil) {
        
        let up = "▲"
        let down = "▼"
        let from = from ?? (target: self, action: #selector(nextButtonTapped))
        let to = to ?? (target: self, action: #selector(nextButtonTapped))
        let finifh = finifh ?? (target: self, action: #selector(nextButtonTapped))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let fixedSpace1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: self, action: nil)
        fixedSpace1.width = 15
        let fixedSpace2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: self, action: nil)
        fixedSpace2.width = 30
        let barButtonItemUp = UIBarButtonItem(title: up, style: .plain, target: from.target, action: from.action)
        let barButtonItemDown = UIBarButtonItem(title: down, style: .plain, target: to.target, action: to.action)
        let barButtonItemFinish = UIBarButtonItem(title: "Готово", style: .plain, target: finifh.target, action: finifh.action)
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [flexibleSpace, barButtonItemUp, fixedSpace1, barButtonItemDown, fixedSpace2, barButtonItemFinish]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func nextButtonTapped() { self.resignFirstResponder() }
    

    func setNumbericFromText() {
        var newValue: Float = 0.0
        
        if let temp1 = self.text {
            if let temp = Float(temp1) {
                newValue = roundToNSigns(x: temp, toSigns: 2)
            }
        }

        if newValue == 0 {
            self.text = ""
        } else {
            self.text = "\(Float(newValue).format(f: ".2"))"
        }

    }

    func setNumbricValue(_ newValue: Double) {
        if newValue == 0 {
            self.text = "0.00"
        } else {
            self.text = Double(newValue).format(f: ".2")
        }

    }

    func setIntNumbricValue(_ newValue: Double) {
        if newValue == 0 {
            self.text = "0"
        } else {
            self.text = Double(newValue).format(f: ".0")
        }

    }

    func numbericValue() -> Float {
        var value: Float = 0.0
        if let temp1 = self.text {
            if let temp = Float(temp1) {
                value = roundToNSigns(x: temp, toSigns: 2)
            }
        }
        return value
    }

    func numbericIntValue() -> Int {
        var value:Float = 0.0
        if let temp1 = self.text {
            if let temp = Float(temp1) {
                value = roundToNSigns(x: temp, toSigns: 0)
            }
        }
        return Int(value)
    }

}

//===================================================================================================================================================

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

