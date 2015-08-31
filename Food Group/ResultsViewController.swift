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
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        barChart.delegate = self
=======
<<<<<<< Updated upstream
<<<<<<< HEAD
        
=======
>>>>>>> master
        let chartSize = self.barChart.frame.size
        let chartWidth = chartSize.width
        let chartHeight = chartSize.height
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
>>>>>>> parent of b1ed0e1... small changes
=======
        
>>>>>>> Stashed changes
        barChart.xLabels = ["Brixx Pizza", "El Jalisco", "La Parilla", "Zaxbys", "Chick-fil-A", "Pizza Inn"]
        barChart.yValues = [5, 2, 3, 1, 1, 1]
        barChart.isShowNumbers = true
        barChart.sizeToFit()
        barChart.strokeChart()
        barChart.barBackgroundColor = UIColor.orangeColor()
        barChart.strokeChart()
        barChart.delegate = self
        self.view.addSubview(barChart)


    }
    
    
    
}