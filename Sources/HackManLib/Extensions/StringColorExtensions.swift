//
//  File.swift
//  
//
//  Created by Devran on 06.06.19.
//

import Foundation

extension StringLiteralType {
    public enum TerminalColor: String {
        case black = "\u{001B}[0;30m"
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case magenta = "\u{001B}[0;35m"
        case cyan = "\u{001B}[0;36m"
        case white = "\u{001B}[0;37m"
        case `default` = "\u{001B}[0;0m"
    }
    
    func colored(_ color: TerminalColor) -> String {
        return "\(color.rawValue)\(self)\(TerminalColor.default.rawValue)"
    }
}
