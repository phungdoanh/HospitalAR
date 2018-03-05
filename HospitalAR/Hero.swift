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
    @objc dynamic var hairRaw = ""
    @objc dynamic var skinRaw = ""
    @objc dynamic var suitRaw = ""
    var hair: Hair? {
        get {
            return Hair(rawValue : hairRaw)
        }
        set {
           hairRaw = newValue!.rawValue
        }
    }
    
    var skin: Skin? {
        get {
            return Skin(rawValue : skinRaw)
        }
        set {
            skinRaw = newValue!.rawValue
        }
    }
    
    var suit: Suit? {
        get {
            return Suit(rawValue : suitRaw)
        }
        set {
            suitRaw = newValue!.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    enum Trait {
        enum Hair : String {
            case Blond, Red, Brown, Black
            
            var uiColor: UIColor {
                switch self {
                case .Blond:
                    return UIColor.init(red: 255/255.0, green: 210/255.0, blue: 105/255.0, alpha: 1)
                case .Red:
                    return UIColor.init(red: 207/255.0, green: 79/255.0, blue: 44/255.0, alpha: 1)
                case .Brown:
                    return UIColor.init(red: 133/255.0, green: 72/255.0, blue: 50/255.0, alpha: 1)
                case .Black:
                    return UIColor.black
                }
            }
            
            static let array = [Blond, Red, Brown, Black]
        }
        
        enum Skin : String {
            case White, Light, Tan, Dark
            
            var uiColor: UIColor {
                switch self {
                case .White: return UIColor.init(red: 255/255.0, green: 242/255.0, blue: 228/255.0, alpha: 1)
                case .Light: return UIColor.init(red: 255/255.0, green: 227/255.0, blue: 193/255.0, alpha: 1)
                case .Tan: return UIColor.init(red: 205/255.0, green: 152/255.0, blue: 122/255.0, alpha: 1)
                case .Dark: return UIColor.init(red: 141/255.0, green: 104/255.0, blue: 84/255.0, alpha: 1)
                }
            }
            
            static let array = [White, Light, Tan, Dark]
        }
        
       enum Suit : String {
            case Red, Green, Blue, Purple
            
            var uiColor: UIColor {
                switch self {
                case .Red: return UIColor.init(red: 210/255.0, green: 36/255.0, blue: 20/255.0, alpha: 1)
                case .Green: return UIColor.init(red: 70/255.0, green: 191/255.0, blue: 64/255.0, alpha: 1)
                case .Blue: return UIColor.init(red: 50/255.0, green: 55/255.0, blue: 191/255.0, alpha: 1)
                case .Purple: return UIColor.init(red: 167/255.0, green: 3/255.03, blue: 191/255.0, alpha: 1)
                }
            }
            
            static let array = [Red, Green, Blue, Purple]
        }
//        case H(Hair), Sk(Skin), Su(Suit)
//    }
}


