//
//  ResultsViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/19/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import PNChart

class ResultsViewController: UIViewController{
    
    @IBOutlet weak var barChart: PNBarChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chartSize = self.barChart.frame.size
        let chartWidth = chartSize.width
        let chartHeight = chartSize.height
        println(chartWidth)
        println(chartHeight)
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        barChart.xLabels = ["Brixx Pizza", "El Jalisco", "La Parilla", "Zaxbys", "Chick-fil-A", "Pizza Inn"]
        barChart.yValues = [5, 2, 3, 1, 1, 1]
        barChart.isShowNumbers = true
        barChart.strokeChart()
        barChart.barBackgroundColor = UIColor.orangeColor()
    }
    
    
    
}