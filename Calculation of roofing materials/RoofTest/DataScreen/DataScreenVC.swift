//
//  DataScreenVC.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 09.05.2022.
//

import UIKit

class DataScreenVC: UIViewController {

    // MARK: - Properties
    
    let cellIdentifier = "DataTVCell"
    var selectedRoof: Roof? = nil
    var activeTextField = UITextField()
    var countButton: UIButton!
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dataRoofImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        self.setTitle(title: "Укажите данные кровли", aligment: .center)
        
        countButton = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
        countButton.setTitle("Расчитать", for: .normal)
        countButton.addTarget(self, action: #selector(countButtonTapped(sender:)), for: .touchUpInside)
        countButton.setTitleColor(.systemBlue, for: .normal)
        countButton.setTitleColor(.gray, for: .disabled)
        countButton.isEnabled = false
        
        tableView.tableFooterView = countButton
        
        dataRoofImage.image = selectedRoof?.imageData
        dataRoofImage.layer.cornerRadius = 20.0
        dataRoofImage.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // make the first form text field the first responder
        firstTFBecomeFirstResponder()
        
        registerNotifications()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func dataTFieldChanged(_ sender: UITextField) {
        let index = IndexPath(row: sender.tag - 1, section: 0)
        
        guard let cell = tableView.cellForRow(at: index) as? DataTVCell,
              let key = cell.dataLabel.text else { return }
        
        if let value = Float(cell.dataTextField.text?.decimalWithPoint() ?? "") {
            selectedRoof?.parameters[key] = roundToNSigns(x: value, toSigns: 2)
        } else {
            selectedRoof?.parameters[key] = nil
        }
        
        countButton.isEnabled = selectedRoof?.allParametersEntered() ?? false
    }
    
    
    // MARK: - Private functions
    
    func currentRoof() -> [String]? {
        let currentRoof = selectedRoof?.currentDataOfRoof[RoofTypeImage(rawValue: (selectedRoof?.type())!.rawValue) ?? .odnoskat]
        return currentRoof
    }
    
    @objc func countButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
        
        if selectedRoof?.allParametersEntered() == true {
            selectedRoof?.calculate()
            performSegue(withIdentifier: SegueIDs.ResultScreenSegue.rawValue, sender: sender)
        } else {
            print("ERROR!!!!!!")
        }
        
    }
    
    @objc func nextButtonTapped() {
        moveField(textField: activeTextField, next: true)
    }
    
    @objc func priviousButtonTapped() {
        moveField(textField: activeTextField, next: false)
    }
    
    @objc func finishButtonTapped() {
        activeTextField.resignFirstResponder()
    }
    
    func moveField(textField: UITextField, next: Bool) {
        let nextTag = textField.tag + (next ? 1 : -1)
        
        if let nextResponder = tableView.viewWithTag(nextTag) as? UITextField {
            self.activeTextField = nextResponder
            nextResponder.becomeFirstResponder()
        }
    }
    
    
    // MARK: - Keyboard Notifications
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let buttonHeight = countButton.frame.size.height
        tableView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + buttonHeight
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        tableView.contentInset.bottom = 0
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultScreenViewController {
            if segue.identifier == SegueIDs.ResultScreenSegue.rawValue {
                resultVC.selectedRoof = self.selectedRoof
            }
        }
    }
    
}


// MARK: Extensions

extension DataScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let value = currentRoof()?.count {
            return value
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DataTVCell {
            let lableText = currentRoof()
            
            cell.dataLabel.text = lableText![indexPath.row]
            cell.dataTextField.tag = indexPath.row + 1
            cell.dataTextField.delegate = self
            
            if let value = selectedRoof?.parameters[cell.dataLabel.text ?? ""] {
                cell.dataTextField.text = "\(value)".decimalWithPoint()
                print(value)
            } else {
                cell.dataTextField.text = ""
            }
            
            cell.dataLabel.isHidden = false
            cell.equalLabel.isHidden = false
            cell.unitLabel.isHidden = false
            cell.dataTextField.isHidden = false
            
            cell.dataTextField.addFinishToolbarWithDirection(from: (target: self, action: #selector(priviousButtonTapped)),
                                                             to: (target: self, action: #selector(nextButtonTapped)),
                                                             finifh: (target: self, action: #selector(finishButtonTapped)))
            
            return cell
        }
        return UITableViewCell()
    }
}


extension DataScreenVC: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    // make the first UITextField (tag=1) the first responder
    // if no view is passed in, start w/ the self.view
    func firstTFBecomeFirstResponder(view: UIView? = nil) {
        for v in view?.subviews ?? self.view.subviews {
            if v is UITextField, v.tag == 1 {
                (v as! UITextField).becomeFirstResponder()
            }
            else if v.subviews.count > 0 { // recursive
                firstTFBecomeFirstResponder(view: v)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setNumbericFromText()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let validation = validation(withTextField: textField, range, and: string)
        return validation
    }
    
    // MARK: - TextFields private validation methods
    
    func filterStr(str: String) -> String {
        let localDecimalSeparator = Locale.current.decimalSeparator ?? "."
        let filter = str.replacingOccurrences(of: localDecimalSeparator, with: ".")
        return filter
    }
    
    func validation(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let numberLength = NSString(string: textField.text!).length + NSString(string: string).length - range.length
        
        if numberLength > 6 {
            return false
        } else {
            
            var tempStr = string
            
            if tempStr == "," {
                let filterString = filterStr(str: tempStr)
                tempStr = filterString
            }
            
            if textField.text == "" && tempStr == "." {
                textField.text = "0" + tempStr
            }
            
            //можно вводить только цифры и точку
            var validationSet = CharacterSet.decimalDigits
            validationSet.formUnion(CharacterSet.init(charactersIn: "."))

            var components = tempStr.components(separatedBy: validationSet.inverted)

            if components.count > 1 {
                return false
            }

            //проверяем если вводимый символ "."
            if tempStr == "." {
                components = textField.text!.components(separatedBy: ".")

                //можно поставить только одну точку
                if components.count > 1 {
                    return false
                } else {
                    textField.text = (textField.text ?? "") + tempStr
                    return false
                }

            }
            
            return true
        }
    }
}
