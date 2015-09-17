//
//  VoteItem.swift
//  Food Group
//
//  Created by Eric Cauble on 8/22/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import Foundation
import MapKit

class VoteItem {
    var inviteeName : String?
    var location : MKMapItem?
    var votes : Int = 0
    var eventTitle : String?
    
     init(inviteeName : String, votes : Int){
        self.inviteeName = inviteeName
        self.votes = votes
    }
}