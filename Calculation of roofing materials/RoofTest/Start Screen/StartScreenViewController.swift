//
//  StartScreenViewController.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 18.02.2022.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var chooseButton: UIButton!
    

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        self.setTitle(title: "Расчёт металлочерепицы", aligment: .center)

        chooseButton.layer.cornerRadius = 7.0
        chooseButton.layer.shadowRadius = 1.0
        chooseButton.layer.shadowOpacity = 0.6
        chooseButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }

}
