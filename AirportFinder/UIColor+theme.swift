//
//  UIColor+theme.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import UIKit

extension UIColor {
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let background = UIColor(r: 235, g: 235, b: 235)
    static let blue = UIColor(r: 95, g: 201, b: 243)
    static let darkBlue = UIColor(r: 71, g: 171, b: 213)
    static let gray = UIColor(r: 145, g: 145, b: 145)
}
