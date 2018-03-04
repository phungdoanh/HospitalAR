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
    var hair = Hair.blond
    var skin = Skin.white
    var suit = Suit.red
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
}

enum Hair : String {
    case blond = "blond"
    case red = "red"
    case brown = "brown"
    case black = "black"
}

enum Skin : String {
    case white = "white"
    case light = "light"
    case tan = "tan"
    case dark = "dark"
}

enum Suit : String {
    case red = "red"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
}


