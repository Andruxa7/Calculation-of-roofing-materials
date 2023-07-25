//
//  ResultOfDataTableViewCell.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 20.04.2022.
//

import UIKit

class ResultOfDataTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dataLabel: UILabel!
    

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
