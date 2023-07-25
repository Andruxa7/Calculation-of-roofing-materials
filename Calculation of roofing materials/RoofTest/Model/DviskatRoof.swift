//
//  DviskatRoof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 22.02.2022.
//

import Foundation
import UIKit

struct DviskatRoof: Roof {
    
    var name: String = "Двускатная"
    var imageType: UIImage? = UIImage(named: RoofTypeImage.dviskat.rawValue)
    var imageData: UIImage? = UIImage(named: RoofDataImage.dviskat_data.rawValue)
    var currentDataOfRoof: [RoofTypeImage : [String]] = [RoofTypeImage.dviskat   : ["X", "L1", "L2"]]
    
    var parameters: [String : Float] = [:]
    var result = [(String, String)]()
    
    func type() -> RoofTypeImage {
        return .dviskat
    }
    
    /* если количество параметров совпадает с нужным и все они больше 0 то
    параметры введены */
    func allParametersEntered() -> Bool {
        let values = parameters.values
        let zeroValues = values.filter({$0 == 0.0})
        
        return values.count == RoofConstants.kData[.dviskat]?.count && zeroValues.count == 0
    }
    
    mutating func calculate() {
        
        result.removeAll()
        
        let x = parameters[RoofConstants.kX] ?? 0
        let l1 = parameters[RoofConstants.kL1] ?? 0
        let l2 = parameters[RoofConstants.kL2] ?? 0
        
        let square_ = (l1 + l2) * x
        let konek_ = x
        let torceva_ = (l1 + l2) * 2
        let kapelnik_ = x * 2
        let snegoderzhatel_ = x * 2
        let samorez_ = Int(min(square_ * 10, Float(Int.max)))
        
        addToResultDviskat(square: square_, konek: konek_, torceva: torceva_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
    }
    
    // dviskat
    private mutating func addToResultDviskat(square: Float, konek: Float, torceva: Float, kapelnik: Float, snegoderzhatel: Float, samorez: Int) {
        result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        result.append(("Конек", "\(konek.format(f: ".2")) м"))
        result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        result.append(("Саморезы", "\(samorez) шт"))
    }
}
