//
//  CAGradientLayer+Tools.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/17/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    static func layerWithColors(colors: [CGColor]) -> CAGradientLayer {
        let gl = CAGradientLayer()
        gl.colors = colors
        gl.locations = [ 0.0, 1.0 ]
        gl.opacity = 0.0
        return gl
    }
    
    static func greenLayer() -> CAGradientLayer {
        return layerWithColors([UIColorFromHex(0x2ac879).CGColor, UIColorFromHex(0x2a8e6b).CGColor])
    }
    
    static func orangeLayer() -> CAGradientLayer {
        return layerWithColors([UIColorFromHex(0xfe9458).CGColor, UIColorFromHex(0xfd6a51).CGColor])
    }
    
    static func blueLayer() -> CAGradientLayer {
        let layer = layerWithColors([UIColorFromHex(0x25bfed).CGColor, UIColorFromHex(0x2962a8).CGColor])
        layer.opacity = 1.0
        return layer
    }
}