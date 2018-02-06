//
//  Clue.swift
//  QRCodeReader
//
//  Created by Peter Andringa on 2/5/18.
//

import Foundation

class Clue {
    let id: String
    init(url: String){
        let regex = try! NSRegularExpression(pattern: "\\/clue\\/([0-9]+)")
        if let match = regex.matches(in: url, options: [], range: NSRange(location: 0, length: url.count)).first {
            id = (url as NSString).substring(with: match.range);
        }else{
            id = "Invalid Code"
        }
    }
}
