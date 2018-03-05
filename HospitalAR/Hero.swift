//
//  Hero.swift
//  HospitalAR
//
//  Created by Andrea Gonzales on 2/25/18.
//  Copyright © 2018 Andrea Gonzales. All rights reserved.
//

import Foundation
import RealmSwift

class Hero : Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    var completedClues = List<Int>()
    var hair = Hair.Blond
    var skin = Skin.White
    var suit = Suit.Red
//    var hair: Hair {
//        get {
//            if let a = Hair(rawValue: 1) {
//                return a
//            }
//            return .black
//        }
//    }
//    @obj dynamic var skin: Skin?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum Hair {
        case Blond, Red, Brown, Black
        
        var uiColor: UIColor {
            switch self {
                case .Blond: return UIColor.init(red: 255, green: 210, blue: 105, alpha: 1)
                case .Red: return UIColor.init(red: 207, green: 79, blue: 44, alpha: 1)
                case .Brown: return UIColor.init(red: 133, green: 72, blue: 50, alpha: 1)
                case .Black: return UIColor.black
            }
        }
        
        static let array = [Blond, Red, Brown, Black]
    }
    
    enum Skin {
        case White, Light, Tan, Dark
        
        var uiColor: UIColor {
            switch self {
                case .White: return UIColor.init(red: 255, green: 242, blue: 228, alpha: 1)
                case .Light: return UIColor.init(red: 255, green: 227, blue: 193, alpha: 1)
                case .Tan: return UIColor.init(red: 205, green: 152, blue: 122, alpha: 1)
                case .Dark: return UIColor.init(red: 141, green: 104, blue: 84, alpha: 1)
            }
        }
        
        static let array = [White, Light, Tan, Dark]
    }
    
    enum Suit {
        case Red, Green, Blue, Purple
        
        var uiColor: UIColor {
            switch self {
            case .Red: return UIColor.init(red: 210, green: 36, blue: 20, alpha: 1)
            case .Green: return UIColor.init(red: 70, green: 191, blue: 64, alpha: 1)
            case .Blue: return UIColor.init(red: 50, green: 55, blue: 191, alpha: 1)
            case .Purple: return UIColor.init(red: 167, green: 33, blue: 191, alpha: 1)
            }
        }
        
        static let array = [red, green, blue, purple]
    }
}


