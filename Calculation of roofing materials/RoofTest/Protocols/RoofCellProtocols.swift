//
//  RoofCellProtocols.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 09.04.2022.
//

import Foundation

protocol RoofCellDelegate: AnyObject {
    func roofParametersDidChange(_ params: [String : Float])
}
