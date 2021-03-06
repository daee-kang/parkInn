//
//  DisplayVC.swift
//  ParkInn
//
//  Created by Leonardo Batista on 3/22/20.
//  Copyright © 2020 ParkInn. All rights reserved.
//

import UIKit
import Charts

class DisplayVC: UIViewController {

    @IBOutlet weak var peakTGLabel: UILabel!
    @IBOutlet weak var peakTG: BarChartView!
    @IBOutlet weak var aveLabel: UILabel!
    @IBOutlet weak var amLabel: UILabel!
    @IBOutlet weak var avLotView: UIView!
    @IBOutlet weak var amLotView: UIView!
    @IBOutlet weak var averageProgress: CircularProgressView!
    @IBOutlet weak var amountProgress: CircularProgressView!
    @IBOutlet weak var showImage: UIImageView!

    
    var lot: Lot!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setParkAmount()
        setParkAve()
        setImage()
        setpeakTG()
 
        navigationItem.title = lot.name
 
    }
    
    func setParkAmount(){
        
        //Label
        amLabel.textColor = UIColor.darkGray
        amLabel.text = "Available Spots: \(lot.availableSpots)/\(lot.totalSpots)"
        
        amLotView.layer.borderColor = UIColor.gray.cgColor
        amLotView.backgroundColor = UIColor.white
        amLotView.layer.cornerRadius = 10.0
        
        amLotView.layer.shadowColor = UIColor.lightGray.cgColor
        amLotView.layer.shadowOpacity = 0.9
        amLotView.layer.shadowOffset = .zero
        amLotView.layer.shadowRadius = 3
        
        amLotView.layer.shadowPath = UIBezierPath(rect: amLotView.bounds).cgPath
        amLotView.layer.shouldRasterize = true
        
        //Circle Progress
        amountProgress.trackColor = UIColor.white
        amountProgress.progressColor = UIColor.PIColors.lightBlueCardHeader
        amountProgress.setProgressWithAnimation(duration: 2.0, value: Float(lot.availableSpots / lot.totalSpots))
        
        
    }
    
    func setParkAve(){
        
        aveLabel.textColor = UIColor.darkGray
        aveLabel.text = "Average Time Parked: \(lot.averageTimeParked.currentAverage) min"
        
        avLotView.layer.borderColor = UIColor.gray.cgColor
        avLotView.backgroundColor = UIColor.white
        avLotView.layer.cornerRadius = 10.0
               
        avLotView.layer.shadowColor = UIColor.lightGray.cgColor
        avLotView.layer.shadowOpacity = 0.9
        avLotView.layer.shadowOffset = .zero
        avLotView.layer.shadowRadius = 3
               
        avLotView.layer.shadowPath = UIBezierPath(rect: avLotView.bounds).cgPath
        avLotView.layer.shouldRasterize = true
        
        averageProgress.trackColor = UIColor.white
        averageProgress.progressColor = UIColor.PIColors.lightBlueCardHeader
        averageProgress.setProgressWithAnimation(duration: 2.0, value: Float(lot.averageTimeParked.currentAverage / 100))
        
    }
    
    func setImage(){
        if lot.imageURL != nil {
                let url = URL(string: lot.imageURL!)!
                showImage.load(url: url)
                }
                else {
                        // Display no image
                    }
        
        showImage.layer.cornerRadius = 10.0
        
    }
    
    func setpeakTG(){
       peakTG.noDataText = "You need to provide data for the chart."

        var dataEntries: [BarChartDataEntry] = []

        for peakTime in lot.peakTimes {
            if peakTime.hour > 4 && peakTime.hour < 20 {
                let dataEntry = BarChartDataEntry(x: Double(peakTime.hour), y: Double(peakTime.count))
                dataEntries.append(dataEntry)
            }
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Reservations Per Hour")
        chartDataSet.drawValuesEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)

        peakTG.data = chartData

        peakTG.drawGridBackgroundEnabled = false
        peakTG.autoScaleMinMaxEnabled = true
        peakTG.xAxis.drawGridLinesEnabled = false
        peakTG.xAxis.labelPosition = .bottom
        peakTG.leftAxis.enabled = false
        peakTG.rightAxis.enabled = false
        peakTG.legend.enabled = false

        let months = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
        peakTG.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        peakTG.xAxis.granularity = 1

        peakTG.rightAxis.drawZeroLineEnabled = true

        peakTG.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)

        //        chartDataSet.colors = [.white]

        peakTG.backgroundColor = UIColor.PIColors.lightBlueCardHeader
        chartDataSet.colors = [UIColor.white]
        
        peakTG.layer.cornerRadius = 10.0
        peakTG.clipsToBounds = true
       
        peakTGLabel.text = "Popular Times"
        peakTGLabel.textColor = UIColor.darkGray
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
