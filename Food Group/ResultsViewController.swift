//
//  ResultsViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/19/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import PNChart

class ResultsViewController: UIViewController, PNChartDelegate{
    
    @IBOutlet weak var barChart: PNBarChart!
    @IBOutlet weak var eventTitle: UILabel!
    
    
    var searchItems : [VoteItem] = [VoteItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(searchItems.count > 0){
            eventTitle.text = String(self.searchItems[0].eventTitle!) + ": results"
        }
        
        barChart.delegate = self
        barChart.xLabels = ["Brixx Pizza", "El Jalisco", "La Parilla", "Zaxbys", "Chick-fil-A", "Pizza Inn"]
        barChart.yValues = [5, 2, 3, 1, 1, 1]
        barChart.isShowNumbers = true
        barChart.strokeChart()
        barChart.barBackgroundColor = UIColor.orangeColor()
    }
    
    
    
}