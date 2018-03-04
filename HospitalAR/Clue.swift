//
//  Clue.swift
//  QRCodeReader
//
//  Created by Peter Andringa on 2/5/18.
//

import Foundation
import RealmSwift

class Clue : Object {
    @objc dynamic var id = 0
    @objc dynamic var clueTitle = ""
    @objc dynamic var clueText = ""
    @objc dynamic var hint = ""
    @objc dynamic var image = ""
    @objc dynamic var foundTitle = ""
    @objc dynamic var foundText = ""
    @objc dynamic var next: Clue?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CompletedClue : Object {
    @objc dynamic var id = 0
}
