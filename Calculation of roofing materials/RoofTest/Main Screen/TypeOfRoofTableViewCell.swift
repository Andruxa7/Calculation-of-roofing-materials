//
//  TypeOfRoofTableViewCell.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 22.02.2022.
//

import UIKit

class TypeOfRoofTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var stickerView: UIView!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureImage.layer.cornerRadius = 9.0
        pictureImage.layer.masksToBounds = true

        stickerView.layer.cornerRadius = 7.0
        stickerView.layer.shadowRadius = 1.0
        stickerView.layer.shadowOpacity = 0.6
        stickerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

        stickerView.backgroundColor = UIColor.init(displayP3Red: 0.0, green: 255.0, blue: 0.0, alpha: 0.6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
