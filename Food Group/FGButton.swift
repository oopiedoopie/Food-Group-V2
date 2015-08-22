//
//  FGButtonStyle.swift
//  Food Group
//
//  Created by Eric Cauble on 8/19/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class FGButton: UIButton
{
    //add style to generic UIButton
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.0
        layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.cornerRadius = 0
        layer.backgroundColor = UIColor(rgba: "#39BCB1").CGColor
        //layer.borderColor = UIColor.orangeColor().CGColor
        layer.borderWidth = 0.0
    }
    
    
    
}
