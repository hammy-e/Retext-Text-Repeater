//
//  StringRepeater.swift
//  Retext
//
//  Created by Abraham Estrada on 6/1/21.
//

import Foundation

struct Repeater {
    
    static func repeatString(_ string: String, repeats: Int) -> String {
        var newString = ""
        for _ in 0..<repeats {
            newString += string
        }
        return newString
    }
}
