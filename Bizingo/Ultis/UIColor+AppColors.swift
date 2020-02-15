//
//  UIColor+AppColors.swift
//  Bizingo
//
//  Created by Bia on 15/02/20.
//  Copyright © 2020 Beatriz Plutarco. All rights reserved.
//

import UIKit

extension UIColor {
    open class var darkTriangle: UIColor {
        return UIColor.init(named: "DarkTriangle") ?? UIColor.black
    }
       
    open class var triangle: UIColor {
        return UIColor.init(named: "Triangle") ?? UIColor.black
    }
       
    open class var playerOne: UIColor {
        return UIColor.init(named: "PieceOne") ?? UIColor.black
    }
    
    open class var pieceOne: UIColor {
        return UIColor.init(named: "PieceOne") ?? UIColor.black
    }
    
    open class var pieceOneCap: UIColor {
        return UIColor.init(named: "PieceOneCap") ?? UIColor.black
    }
       
    open class var playerTwo: UIColor {
        return UIColor.init(named: "PieceTwoCap") ?? UIColor.black
    }
    
    open class var pieceTwo: UIColor {
        return UIColor.init(named: "PieceTwo") ?? UIColor.black
    }
    
    open class var pieceTwoCap: UIColor {
        return UIColor.init(named: "PieceTwoCap") ?? UIColor.black
    }
    
    open class var walkFree: UIColor {
        return UIColor.init(named: "WalkFree") ?? UIColor.black
    }
}
