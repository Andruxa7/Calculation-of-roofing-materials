//
//  ShatrovayaRoof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 08.03.2022.
//

import Foundation
import UIKit

struct ShatrovayaRoof: Roof {
    
    var name: String = "Шатровая"
    var imageType: UIImage? = UIImage(named: RoofTypeImage.shatrovaya.rawValue)
    var imageData: UIImage? = UIImage(named: RoofDataImage.shatrovaya_data.rawValue)
    var currentDataOfRoof: [RoofTypeImage : [String]] = [RoofTypeImage.shatrovaya   : ["X1", "X2", "L1", "L2"]]
    
    var parameters: [String : Float] = [:]
    var result = [(String, String)]()
    
    func type() -> RoofTypeImage {
        return .shatrovaya
    }
    
    /* если количество параметров совпадает с нужным и все они больше 0 то
    параметры введены */
    func allParametersEntered() -> Bool {
        let values = parameters.values
        let zeroValues = values.filter({$0 == 0.0})
        
        return values.count == RoofConstants.kData[.shatrovaya]?.count && zeroValues.count == 0
    }
    
    mutating func calculate() {
        
        result.removeAll()
        
        let x1 = parameters[RoofConstants.kX1] ?? 0
        let x2 = parameters[RoofConstants.kX2] ?? 0
        let l1 = parameters[RoofConstants.kL1] ?? 0
        let l2 = parameters[RoofConstants.kL2] ?? 0
        
        let s1 = ((l1 * x1)/2) * 2
        let s2 = ((l2 * x2)/2) * 2
        let clear_square_ = s1 + s2
        let square_ = roundToNSigns(x: (clear_square_ + ceil(clear_square_/10) + 1), toSigns: 2)
        
        let halfX1 = x1/2
        let halfX2 = x2/2
        let k1 = (sqrt(l1*l1 + halfX1*halfX1)) * 2
        let k2 = (sqrt(l2*l2 + halfX2*halfX2)) * 2
        let konek_ = k1 + k2
        
        let kapelnik_ = (x1 + x2) * 2
        let snegoderzhatel_ = (x1 + x2) * 2
        let ventLenta_ = Int(konek_)
        let samorez_ = Int(min(square_ * 10, Float(Int.max)))

        addToResultShatrovaya(square: square_, konek: konek_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, ventLenta: ventLenta_, samorez: samorez_)
    }
    
    // shatrovaya
    private mutating func addToResultShatrovaya(square: Float, konek: Float, kapelnik: Float, snegoderzhatel: Float, ventLenta: Int, samorez: Int) {
        result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        result.append(("Конек", "\(konek.format(f: ".2")) м"))
        result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        result.append(("Вентлента конька", "\(ventLenta.format(f: ".2")) м"))
        result.append(("Саморезы", "\(samorez) шт"))
    }
}
