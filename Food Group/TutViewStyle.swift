//
//  TutViewStyle.swift
//  Food Group
//
//  Created by oopie doopie on 8/22/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import Foundation
import UIKit


class TutViewStyle: UIView
{
    //add style to generic UIView
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.backgroundColor = UIColor(rgba: "#D39B46").CGColor
    }
    
    
}