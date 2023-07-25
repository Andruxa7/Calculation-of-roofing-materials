//
//  MainScreenTableVC.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 18.02.2022.
//

import UIKit

class MainScreenTableVC: UITableViewController {
    
    // MARK: - Properties
    
    let identifier = "TypeOfRoofTableViewCell"
    var roofs: [Roof] = []


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        self.setTitle(title: "Выберите форму крыши", aligment: .center)

        roofs = DataController().getRoofs()
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roofs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TypeOfRoofTableViewCell {
            let roof = roofs[indexPath.row]
            
            cell.nameLabel.text = roof.name
            cell.pictureImage.image = roof.imageType

            return cell
        }
        
        return UITableViewCell()
    }

    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIDs.CalculateScreenSegue.rawValue, sender: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    // сделаем так что после появления ячейки внизу не будет лишних видимых ячеек (сетки). Добавим два метода Футера.
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDs.CalculateScreenSegue.rawValue {
            guard let vc = segue.destination as? DataScreenVC else { return }
            guard let index = sender as? Int else { return }
            vc.selectedRoof = roofs[index]
        }
    }

}
