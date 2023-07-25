//
//  DataController.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 22.02.2022.
//

import Foundation
import UIKit

enum SegueIDs: String {
    case CalculateScreenSegue
    case ResultScreenSegue
}

class DataController {
    
    func getRoofs() -> [Roof] {
        return [OdnoskatRoof(), DviskatRoof(), MansardaRoof(), ValmovaRoof(), ShatrovayaRoof()]
    }
}
