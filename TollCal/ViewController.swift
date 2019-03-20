//
//  ViewController.swift
//  TollCal
//
//  Created by Juan Vargas on 3/13/19.
//  Copyright © 2019 Juan Vargas. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // Main Menu
    @IBOutlet weak var roundedCorner: UIButton?
    @IBOutlet weak var roundedCorner2: UIButton?
    
    // Orange County screen
    @IBOutlet var total55RC: UILabel?
    @IBOutlet var total55McKin: UILabel?
    @IBOutlet var total5515: UILabel?
    
    // Riverside County screen
    @IBOutlet var totalRCOC: UILabel?

    @IBOutlet var total15RC: UILabel?
    @IBOutlet var total15OC: UILabel?
    
    @IBOutlet var totalMcKRC: UILabel?
    @IBOutlet var totalMcKOC: UILabel?

    func calculatePrice()
    {
        let currentDay = getDay()
        let currentHour = getHour()
        
        let OCWPrice = getOCW(day: currentDay, hour: currentHour) // Riverside County to 55
        let OCEPrice = getOCE(day: currentDay, hour: currentHour) // 55 freeway to riverside county line
        
        let RCWPrice = getRCW(day: currentDay, hour: currentHour) // Riverside County Westbound I-15 N (Deep Corona) to County Line
        let RCEPrice = getRCE(day: currentDay, hour: currentHour) //County Line to I-15
        
        let RCW2Price = getRCW2(day: currentDay, hour: currentHour) // Mckinley to County Line
        let RCE2Price = getRCE2(day: currentDay, hour: currentHour) // County Line to McKinley
        
        
        
        
        total55RC?.text = "$" + String(format: "%.2f",(OCEPrice)) // Display 55 -> R.CO
        total55McKin?.text = "$" + String(format: "%.2f",(OCEPrice + RCE2Price)) // Display 55 -> McKin
        total5515?.text = "$" + String(format: "%.2f",(OCEPrice + RCEPrice)) // Display 55 -> I-15
        
        // R Co to 55
        totalRCOC?.text = "$" + String(format: "%.2f",(OCWPrice))
        
        // 15
        total15RC?.text = "$" + String(format: "%.2f",(RCWPrice))
        total15OC?.text = "$" + String(format: "%.2f",(RCWPrice + OCWPrice))
        
        // Mckinley
        totalMcKRC?.text = "$" + String(format: "%.2f",(RCW2Price))
        totalMcKOC?.text = "$" + String(format: "%.2f",(RCW2Price + OCWPrice))
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        roundedCorner?.layer.cornerRadius = 4
        roundedCorner2?.layer.cornerRadius = 4
        calculatePrice()
    }
    


    
    
    // Gets Day
    func getDay()->String
    {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let someDay = dateFormatter.string(from: date)
        return someDay
    }
    
    // Gets Hour
    func getHour()->Int
    {
        
        let someDate = Date()
        let someHour = Calendar.current.component(.hour, from: someDate)
        return someHour
    }
    
    
    //Orange County--> Westbound
    // Riverside County line to 55
    func getOCW(day: String, hour: Int) -> Double
    {
        var currentPrice: Double
        
        let sundayOCW = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.10, 2.10, 3.15, 3.15, 3.15, 3.55, 3.55, 3.55, 3.70, 3.70, 3.70,3.15,3.15,3.15,1.65,1.65]
        
        let mondayOCW = [1.65,1.65,1.65,1.65,3.00,4.85,5.05,5.55,5.05,4.00,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,1.65,1.65,1.65,1.65,1.65]
        
        let tuesdayOCW = [1.65,1.65,1.65,1.65,3.00,4.85,5.05,5.55,5.05,4.00,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,1.65,1.65,1.65,1.65,1.65]
        
        let wednesdayOCW = [1.65,1.65,1.65,1.65,3.00,4.85,5.05,5.55,5.05,4.00,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,1.65,1.65,1.65,1.65,1.65]
        
        let thursdayOCW = [1.65,1.65,1.65,1.65,3.00,4.85,5.05,5.55,5.05,4.00,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,2.45,1.65,1.65,1.65,1.65,1.65]
        
        let fridayOCW = [1.65,1.65,1.65,1.65,3.00,4.60,4.85,5.40,5.85,4.00,2.45,2.45,2.45,2.45,2.45,3.15,3.15,3.15,3.65,2.45,1.65,1.65,1.65,1.65]
        
        let saturdayOCW = [1.65,1.65,1.65,1.65,1.65,1.65,1.65,2.10,2.45,3.15,3.15,3.55,3.55,3.55,3.55,3.55,3.70,3.70,3.15,2.45,1.65,1.65,1.65,1.65]
        
        switch day
        {
        case "Monday":
            currentPrice = mondayOCW[hour - 1]
        
        case "Tuesday":
            currentPrice = tuesdayOCW[hour - 1]
        
        case "Wednesday":
            currentPrice = wednesdayOCW[hour - 1]
        
        case "Thursday":
            currentPrice = thursdayOCW[hour - 1]
        
        case "Friday":
            currentPrice = fridayOCW[hour - 1]
        
        case "Saturday":
            currentPrice = saturdayOCW[hour - 1]
        
        case "Sunday":
            currentPrice = sundayOCW[hour - 1]
            
        default:
            currentPrice = 0;
        }
        
        return currentPrice
    }
    
    
  // Orange County --> Eastbound
 // 55 freeway to riverside county line
// Effective Jan 1 2019
    func getOCE(day: String, hour: Int) -> Double
    {
        var currentPrice: Double

            
        let sundayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.00, 2.00, 3.15, 3.15, 3.65, 3.65, 3.65, 3.15, 3.15, 3.15, 3.15 ,3.15,3.15,2.45 ,1.65, 1.65]
        
        let mondayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.50, 5.05, 5.40, 5.25, 5.20, 5.40 ,3.75, 2.45, 2.45 ,1.65, 1.65]
        
        let tuesdayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.50, 5.05, 5.40, 5.25, 5.20, 5.40 ,3.75, 2.45, 2.45 ,1.65, 1.65]
        
        let wednesdayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.50, 5.05, 7.00, 6.75, 6.90, 3.85 ,3.75, 2.45, 2.45 ,1.65, 1.65]
        
        let thursdayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.75, 5.95, 6.00, 8.80, 9.20, 4.75 ,5.50, 3.50, 2.45 ,1.65, 1.65]

        let fridayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.75, 5.90, 6.35, 9.65, 9.45, 6.90, 6.40 ,5.95, 5.50, 3.50 ,2.45, 1.65]
        
        let saturdayOCE = [1.65, 1.65, 1.65, 1.65, 1.65, 1.65, 2.45, 2.45, 2.45, 2.45, 2.45, 2.45, 3.65, 3.65, 3.65, 3.65, 3.65, 3.65, 3.15 ,2.45, 2.45, 2.45 ,1.65, 1.65]
    
        
        switch day
        {
        case "Monday":
            currentPrice = mondayOCE[hour - 1]
            
        case "Tuesday":
            currentPrice = tuesdayOCE[hour - 1]
            
        case "Wednesday":
            currentPrice = wednesdayOCE[hour - 1]
            
        case "Thursday":
            currentPrice = thursdayOCE[hour - 1]
            
        case "Friday":
            currentPrice = fridayOCE[hour - 1]
            
        case "Saturday":
            currentPrice = saturdayOCE[hour - 1]
            
        case "Sunday":
            currentPrice = sundayOCE[hour - 1]
            
        default:
            currentPrice = 0;
        }
        
        return currentPrice
        
    }
    
// Riverside County Westbound I-15 N (Deep Corona) to County Line
// Effective Feb 11 2019
func getRCW(day: String, hour: Int) -> Double
{
   
    var currentPrice: Double
    
    let sundayRCW = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.80,2.85,2.85,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90]
    
    let mondayRCW = [1.90,1.90,1.90,1.90,5.05,17.40,17.40,12.40,8.55,5.05,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90]
    
    let tuesdayRCW = [1.90,1.90,1.90,1.90,5.05,15.40,15.70,11.70,8.55,5.15,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90]
    
    let wednesdayRCW = [1.90,1.90,1.90,1.90,5.05,15.70,17.70,12.70,8.55,5.15,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90]
    
    let thursdayRCW = [1.90,1.90,1.90,1.90,5.05,13.70,14.70,11.70,6.65,5.15,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90]
   
    let fridayRCW = [1.90,1.90,1.90,1.90,2.85,5.15,6.65,6.65,5.15,2.85,2.85,2.80,2.85,2.85,2.85,2.80,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90]
    
    let saturdayRCW = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,2.85,2.85,2.85,2.85,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90,1.90,1.90,1.90]
    
    switch day
    {
    case "Monday":
        currentPrice = mondayRCW[hour - 1]
        
    case "Tuesday":
        currentPrice = tuesdayRCW[hour - 1]
        
    case "Wednesday":
        currentPrice = wednesdayRCW[hour - 1]
        
    case "Thursday":
        currentPrice = thursdayRCW[hour - 1]
        
    case "Friday":
        currentPrice = fridayRCW[hour - 1]
        
    case "Saturday":
        currentPrice = saturdayRCW[hour - 1]
        
    case "Sunday":
        currentPrice = sundayRCW[hour - 1]
        
    default:
        currentPrice = 0;
    }
    
    return currentPrice
    
    }
    
    
    //County Line to I-15
    // Effective Feb 11 2019
    func getRCE(day: String, hour: Int) -> Double
    {
        var currentValue: Double
        
        
        let sundayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,2.80,2.80,1.90,1.90,1.90,1.90,1.90,1.90]
        
        let mondayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,2.85,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90,1.90]
        
        let tuesdayRCE  = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,5.15,2.80,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90]
       
        let wednesdayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,5.05,5.15,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90]
        
        let thursdayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,5.05,5.15,2.80,2.85,2.85,2.85,2.85,1.90,1.90,1.90]
       
        let fridayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.85,2.85,5.15,2.80,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90]
        
        let saturdayRCE = [1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,1.90,2.80,2.85,2.85,2.85,2.85,2.80,2.85,2.85,2.85,2.85,2.85,1.90,1.90,1.90]
        
        switch day
        {
        case "Monday":
            currentValue = mondayRCE[hour - 1]
            
        case "Tuesday":
            currentValue = tuesdayRCE[hour - 1]
            
        case "Wednesday":
            currentValue = wednesdayRCE[hour - 1]
            
        case "Thursday":
            currentValue = thursdayRCE[hour - 1]
            
        case "Friday":
            currentValue = fridayRCE[hour - 1]
            
        case "Saturday":
            currentValue = saturdayRCE[hour - 1]
            
        case "Sunday":
            currentValue = sundayRCE[hour - 1]
            
        default:
            currentValue = 0;
        }
        
        return currentValue
        
    }
    
    // Mckinley to County Line
    // Effective Feb 11 2019
    func getRCW2(day: String, hour: Int) -> Double
    {
        
        var currentValue: Double
        
        let sundayRCW2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.20,4.05,4.05,4.05,4.05,4.05,2.20,2.20,2.15,1.50,1.50,1.50,1.50,1.50]
        
        let mondayRCW2 = [1.50,1.50,1.50,1.50,7.85,19.90,18.55,13.20,8.45,5.15,4.05,2.20,2.20,2.20,2.20,2.20,2.20,2.20,1.50,1.50,1.50,1.50,1.50,1.50]
        
        let tuesdayRCW2 = [1.50,1.50,1.50,1.50,7.85,19.45,18.15,13.20,8.45,6.70,4.05,2.15,2.15,2.20,2.20,2.20,2.20,2.15,1.50,1.50,1.50,1.50,1.50,1.50]
        
        let wednesdayRCW2 = [1.50,1.50,1.50,1.50,7.85,18.45,16.15,13.95,8.45,6.70,2.20,2.20,2.20,2.20,2.20,2.20,2.20,2.20,1.50,1.50,1.50,1.50,1.50,1.50]
        
        let thursdayRCW2 = [1.50,1.50,1.50,1.50,7.85,18.20,16.15,12.20,9.20,6.70,4.05,2.20,2.20,2.20,2.20,2.20,2.20,2.20,2.15,1.50,1.50,1.50,1.50,1.50]
        
        let fridayRCW2 = [1.50,1.50,1.50,1.50,3.95,9.20,8.45,6.70,4.05,2.20,2.20,2.20,2.20,2.20,2.20,2.20,4.05,2.20,1.50,1.50,1.50,1.50,1.50]
        
        let saturdayRCW2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.20,2.20,2.20,2.20,2.20,4.05,4.05,4.05,3.95,4.05,2.20,1.50,1.50,1.50,1.50,1.50]
        
        switch day
        {
        case "Monday":
            currentValue = mondayRCW2[hour - 1]
            
        case "Tuesday":
            currentValue = tuesdayRCW2[hour - 1]
            
        case "Wednesday":
            currentValue = wednesdayRCW2[hour - 1]
            
        case "Thursday":
            currentValue = thursdayRCW2[hour - 1]
            
        case "Friday":
            currentValue = fridayRCW2[hour - 1]
            
        case "Saturday":
            currentValue = saturdayRCW2[hour - 1]
            
        case "Sunday":
            currentValue = sundayRCW2[hour - 1]
            
        default:
            currentValue = 0;
        }
        
        return currentValue
    }
    
    // County Line to McKinley
    func getRCE2(day: String, hour: Int) -> Double
    {
      var currentValue: Double
        
      let sundayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.20,2.20,2.20,2.20,2.20,2.20,2.20,2.20,2.20,1.50,1.50,1.50]
    
      let mondayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,1.50,1.50,2.20,2.20,4.05,6.70,6.70,5.15,5.15,5.15,2.20,2.15,1.50,1.50,1.50]
    
      let tuesdayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.15,1.50,1.50,1.50,2.20,3.95,6.70,5.15,6.70,5.15,5.15,4.05,2.20,1.50,1.50,1.50]
        
      let wednesdayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.15,2.20,2.20,2.15,2.20,4.05,6.70,7.55,5.15,5.15,5.15,3.95,2.20,1.50,1.50,1.50]
        
      let thursdayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.15,2.15,2.20,2.20,2.20,5.15,8.85,10.60,7.90,5.15,5.15,4.05,2.20,2.20,1.50,1.50]
        
      let fridayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.15,2.20,2.20,3.95,5.15,11.40,17.70,17.70,11.40,6.70,5.15,4.05,2.20,2.20,1.50]
        
      let saturdayRCE2 = [1.50,1.50,1.50,1.50,1.50,1.50,1.50,1.50,2.20,2.20,2.20,4.05,3.95,4.05,5.15,5.15,5.15,5.15,4.05,4.05,2.20,2.20,2.20,2.20]
        
        switch day
        {
        case "Monday":
            currentValue = mondayRCE2[hour - 1]
            
        case "Tuesday":
            currentValue = tuesdayRCE2[hour - 1]
            
        case "Wednesday":
            currentValue = wednesdayRCE2[hour - 1]
            
        case "Thursday":
            currentValue = thursdayRCE2[hour - 1]
            
        case "Friday":
            currentValue = fridayRCE2[hour - 1]
            
        case "Saturday":
            currentValue = saturdayRCE2[hour - 1]
            
        case "Sunday":
            currentValue = sundayRCE2[hour - 1]
            
        default:
            currentValue = 0;
        }
        
        return currentValue
        
    }
    

}


