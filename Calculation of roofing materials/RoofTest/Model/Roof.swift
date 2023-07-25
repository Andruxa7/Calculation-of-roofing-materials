//
//  Roof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 18.02.2022.
//

import Foundation
import UIKit

enum RoofTypeImage: String {
    case odnoskat
    case dviskat
    case mansarda
    case valmova
    case shatrovaya
}

enum RoofDataImage: String {
    case odnoskat_data
    case dviskat_data
    case mansarda_data
    case valmova_data
    case shatrovaya_data
}

protocol Roof {
    var name: String { get set }
    var imageType: UIImage? { get set }
    var imageData: UIImage? { get set }
    var currentDataOfRoof: [RoofTypeImage : [String]] { get set }
    var parameters: [String : Float] { get set }
    var result: [(String, String)] { get set }
    
    func type() -> RoofTypeImage
    func allParametersEntered() -> Bool
    mutating func calculate()
}

struct RoofConstants {
    static let kX  = "X"
    static let kX1 = "X1"
    static let kX2 = "X2"
    static let kX3 = "X3"
    static let kL  = "L"
    static let kL1 = "L1"
    static let kL2 = "L2"
    static let kL3 = "L3"
    static let kL4 = "L4"
    
    static let kData = [RoofTypeImage.odnoskat   : ["X", "L"],
                        RoofTypeImage.dviskat    : ["X", "L1", "L2"],
                        RoofTypeImage.mansarda   : ["X", "L1", "L2", "L3", "L4"],
                        RoofTypeImage.valmova    : ["X1", "X2", "X3", "L1", "L2", "L3", "L4"],
                        RoofTypeImage.shatrovaya : ["X1", "X2", "L1", "L2"]]
}

