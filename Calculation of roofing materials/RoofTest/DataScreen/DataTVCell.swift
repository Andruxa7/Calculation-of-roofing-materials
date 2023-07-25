//
//  DataTVCell.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 09.05.2022.
//

import UIKit

class DataTVCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

}
