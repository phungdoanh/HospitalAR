//
//  HeroView.swift
//  HospitalAR
//
//  Created by Peter Andringa on 3/4/18.
//  Copyright © 2018 Andrea Gonzales. All rights reserved.
//

import Foundation
import SwiftSVG
import UIKit

class HeroView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Loading avatar...")
        let avatar = UIView(SVGNamed: "Avatar", completion: { svgLayer in
            print("SVG!!!")
            print(svgLayer)
            //            svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
            svgLayer.resizeToFit(self.bounds)
        })
        print("adding subview")
        print(avatar)
        self.addSubview(avatar)
        self.bringSubview(toFront: avatar)
    }
}
