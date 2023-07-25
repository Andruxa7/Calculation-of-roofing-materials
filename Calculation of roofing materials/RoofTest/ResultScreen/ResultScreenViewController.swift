//
//  ResultScreenViewController.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 09.04.2022.
//

import UIKit

class ResultScreenViewController: UIViewController {
    
    enum Identifire: String {
        case DataCell
        case HeaderCell
        case ResultCell
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var resultRoofImage: UIImageView!
    
   
    // MARK: - Properties
    
    var selectedRoof: Roof? = nil
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        self.setTitle(title: "Результат расчёта", aligment: .center)
        
        resultRoofImage.image = selectedRoof?.imageData
        resultRoofImage.layer.cornerRadius = 20.0
        resultRoofImage.layer.masksToBounds = true
    }
    
    
    // MARK: - IBActions
        
    @IBAction func backToRootAction(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: UIBarButtonItem) {
        createPdfFromView(aView: self.view, saveToDocumentsWithFileName: "documento.pdf")
        loadPDFAndShare()
    }
 
    
    // MARK: - Private functions
    
    func createPdfFromView(aView: UIView, saveToDocumentsWithFileName fileName: String) {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        
        aView.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
    }
    
    func loadPDFAndShare() {
        let fileManager = FileManager.default
        let documentoPath = (self.getDirectoryPath() as NSString).appendingPathComponent("documento.pdf")
        
        if fileManager.fileExists(atPath: documentoPath){
            let documento = NSData(contentsOfFile: documentoPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
}


// MARK: - Extensions

extension ResultScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let parametersRows = (selectedRoof?.parameters.count ?? 0)
        let resultRows = (selectedRoof?.result.count ?? 0)
        let headerRows = 1
        let numberOfRows = parametersRows + resultRows + headerRows
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let headerRows = 1
        
        switch indexPath.row {
        case 0...(selectedRoof?.parameters.count ?? 0) - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifire.DataCell.rawValue, for: indexPath) as! ResultOfDataTableViewCell
            
            let equel = " = "
            let unit = " м"
            let dataFromLable = selectedRoof?.currentDataOfRoof[RoofTypeImage(rawValue: (selectedRoof?.type())!.rawValue) ?? .odnoskat]
            let dataLableText = dataFromLable![indexPath.row]
            
            if let valueText = selectedRoof?.parameters[dataLableText] {
                cell.dataLabel.text = dataLableText + equel + "\(valueText)" + unit
            }
            
            return cell
            
        case (selectedRoof?.parameters.count ?? 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifire.HeaderCell.rawValue, for: indexPath) as! HeaderTableViewCell
            
            return cell
            
        case ((selectedRoof?.parameters.count ?? 0) + headerRows)...((selectedRoof?.result.count ?? 0) + (selectedRoof?.parameters.count ?? 0)):
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifire.ResultCell.rawValue, for: indexPath) as! ResultTableViewCell
            
            let a = indexPath.row
            print(a)
            
            cell.nameLabel.text = selectedRoof?.result[indexPath.row - ((selectedRoof?.parameters.count ?? 0) + headerRows)].0
            cell.amountLabel.text = selectedRoof?.result[indexPath.row - ((selectedRoof?.parameters.count ?? 0) + headerRows)].1  ?? "No Data"
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerRows = 1
        
        switch indexPath.row {
        case 0...(selectedRoof?.parameters.count ?? 0) - 1:
            return 44
        case (selectedRoof?.parameters.count ?? 0):
            return 80
        case ((selectedRoof?.parameters.count ?? 0) + headerRows)...((selectedRoof?.result.count ?? 0) + (selectedRoof?.parameters.count ?? 0)):
            return 44
        default:
            return 44
        }
    }
    
    // сделаем так что после появления ячейки внизу не будет лишних видимых ячеек (сетки). Добавим два метода Футера.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
