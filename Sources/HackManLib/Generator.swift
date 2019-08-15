//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation

protocol Generator {
    init()
    func generate(arguments: [String], options: [String])
}