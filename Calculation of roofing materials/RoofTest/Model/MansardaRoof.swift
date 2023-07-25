//
//  MansardaRoof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 08.03.2022.
//

import Foundation
import UIKit

struct MansardaRoof: Roof {
    
    var name: String = "Мансардная"
    var imageType: UIImage? = UIImage(named: RoofTypeImage.mansarda.rawValue)
    var imageData: UIImage? = UIImage(named: RoofDataImage.mansarda_data.rawValue)
    var currentDataOfRoof: [RoofTypeImage : [String]] = [RoofTypeImage.mansarda   : ["X", "L1", "L2", "L3", "L4"]]
    
    var parameters: [String : Float] = [:]
    var result = [(String, String)]()
    
    func type() -> RoofTypeImage {
        return .mansarda
    }
    
    /* если количество параметров совпадает с нужным и все они больше 0 то
    параметры введены */
    func allParametersEntered() -> Bool {
        let values = parameters.values
        let zeroValues = values.filter({$0 == 0.0})
        
        return values.count == RoofConstants.kData[.mansarda]?.count && zeroValues.count == 0
    }
    
    mutating func calculate() {
        
        result.removeAll()
        
        let x = parameters[RoofConstants.kX] ?? 0
        let l1 = parameters[RoofConstants.kL1] ?? 0
        let l2 = parameters[RoofConstants.kL2] ?? 0
        let l3 = parameters[RoofConstants.kL3] ?? 0
        let l4 = parameters[RoofConstants.kL4] ?? 0
        
        let square_ = (l1 + l2 + l3 + l4) * x
        let konek_ = x
        let torceva_ = (l1 + l2 + l3 + l4) * 2
        let kapelnik_ = x * 2
        let perelom_ = x * 2
        let snegoderzhatel_ = x * 2
        let samorez_ = Int(min(square_ * 10, Float(Int.max)))
        
        addToResultMansarda(square: square_, konek: konek_, torceva: torceva_, kapelnik: kapelnik_, perelom: perelom_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
    }
    
    // mansarda
    private mutating func addToResultMansarda(square: Float, konek: Float, torceva: Float, kapelnik: Float, perelom: Float, snegoderzhatel: Float, samorez: Int) {
        result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        result.append(("Конек", "\(konek.format(f: ".2")) м"))
        result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        result.append(("Планка перелома", "\(perelom.format(f: ".2")) м"))
        result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        result.append(("Саморезы", "\(samorez) шт"))
    }
}
