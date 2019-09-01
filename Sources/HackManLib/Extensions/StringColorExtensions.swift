//
//  File.swift
//  
//
//  Created by Devran on 06.06.19.
//

import Foundation

extension StringLiteralType {
    func colored(_ color: TerminalColor) -> String {
        return "\(color.rawValue)\(self)\(TerminalColor.default.rawValue)"
    }
}
