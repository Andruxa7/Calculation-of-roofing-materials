//
//  ValmovaRoof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 08.03.2022.
//

import Foundation
import UIKit

struct ValmovaRoof: Roof {
    
    var name: String = "Вальмовая"
    var imageType: UIImage? = UIImage(named: RoofTypeImage.valmova.rawValue)
    var imageData: UIImage? = UIImage(named: RoofDataImage.valmova_data.rawValue)
    var currentDataOfRoof: [RoofTypeImage : [String]] = [RoofTypeImage.valmova   : ["X1", "X2", "X3", "L1", "L2", "L3", "L4"]]
    
    var parameters: [String : Float] = [:]
    var result = [(String, String)]()
    
    func type() -> RoofTypeImage {
        return .valmova
    }
    
    /* если количество параметров совпадает с нужным и все они больше 0 то
    параметры введены */
    func allParametersEntered() -> Bool {
        let values = parameters.values
        let zeroValues = values.filter({$0 == 0.0})
        
        return values.count == RoofConstants.kData[.valmova]?.count && zeroValues.count == 0
    }
    
    mutating func calculate() {
        
        result.removeAll()
        
        let x1 = parameters[RoofConstants.kX1] ?? 0
        let x2 = parameters[RoofConstants.kX2] ?? 0
        let x3 = parameters[RoofConstants.kX3] ?? 0
        let l1 = parameters[RoofConstants.kL1] ?? 0
        let l2 = parameters[RoofConstants.kL2] ?? 0
        let l3 = parameters[RoofConstants.kL3] ?? 0
        let l4 = parameters[RoofConstants.kL4] ?? 0
        
        let s1 = (l3 * x2)/2
        let s2 = (l2 * x2)/2
        let sH1 = l1
        let sM1 = (x1 + x3)/2
        let s3 = sH1 * sM1
        let sH2 = l4
        let sM2 = (x1 + x3)/2
        let s4 = sH2 * sM2
        let clear_square_ = s1 + s2 + s3 + s4
        let square_ = roundToNSigns(x: (clear_square_ + ceil(clear_square_/10) + 1), toSigns: 2)
        
        let b1 = (x3 - x1)/2
        let b2 = x2/2
        let b3 = (x3 - x1)/2
        let b4 = x2/2
        let konek_ = x1 + sqrt(l4*l4 + b1*b1) + sqrt(l3*l3 + b2*b2) + sqrt(l1*l1 + b3*b3) + sqrt(l2*l2 + b4*b4)
        
        let kapelnik_ = (x2 + x3) * 2
        let snegoderzhatel_ = (x2 + x3) * 2
        let ventLenta_ = Int(konek_)
        let samorez_ = Int(min(square_ * 10, Float(Int.max)))

        addToResultValmova(square: square_, konek: konek_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, ventLenta: ventLenta_, samorez: samorez_)
    }
    
    // valmova
    private mutating func addToResultValmova(square: Float, konek: Float, kapelnik: Float, snegoderzhatel: Float, ventLenta: Int, samorez: Int) {
        result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        result.append(("Конек", "\(konek.format(f: ".2")) м"))
        result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        result.append(("Вентлента конька", "\(ventLenta.format(f: ".2")) м"))
        result.append(("Саморезы", "\(samorez) шт"))
    }
}
