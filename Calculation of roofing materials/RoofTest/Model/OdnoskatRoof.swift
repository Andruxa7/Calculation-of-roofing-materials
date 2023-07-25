//
//  OdnoskatRoof.swift
//  RoofTest
//
//  Created by Andrii Stetsenko on 21.02.2022.
//

import Foundation
import UIKit

struct OdnoskatRoof: Roof {
    
    var name: String = "Односкатная"
    var imageType: UIImage? = UIImage(named: RoofTypeImage.odnoskat.rawValue)
    var imageData: UIImage? = UIImage(named: RoofDataImage.odnoskat_data.rawValue)
    var currentDataOfRoof: [RoofTypeImage : [String]] = [RoofTypeImage.odnoskat : ["X", "L"]]
    
    var parameters: [String : Float] = [:]
    var result = [(String, String)]()
    
    func type() -> RoofTypeImage {
        return .odnoskat
    }
    
    /* если количество параметров совпадает с нужным и все они больше 0 то
    параметры введены */
    func allParametersEntered() -> Bool {
        let values = parameters.values
        let zeroValues = values.filter({$0 == 0.0})
        
        return values.count == RoofConstants.kData[.odnoskat]?.count && zeroValues.count == 0
    }
    
    mutating func calculate() {
        
        result.removeAll()
        
        let x = parameters[RoofConstants.kX] ?? 0
        let l = parameters[RoofConstants.kL] ?? 0
        
        let square_ = x * l
        let torceva_ = (l * 2) + x
        let kapelnik_ = x
        let snegoderzhatel_ = x
        let samorez_ = Int(min(square_ * 10, Float(Int.max)))
        
        addToResultOdnoskat(square: square_, torceva: torceva_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
    }
    
    // odnoskat
    private mutating func addToResultOdnoskat(square: Float, torceva: Float, kapelnik: Float, snegoderzhatel: Float, samorez: Int) {
        result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        result.append(("Саморезы", "\(samorez) шт"))
    }
}
