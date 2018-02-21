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
    @objc dynamic var title = ""
    @objc dynamic var clueText = ""
    @objc dynamic var hint = ""
    @objc dynamic var image = ""
    @objc dynamic var foundText = ""
    @objc dynamic var next: Clue?
}
