//
//  PetFoodPricesViewController.swift
//  PetCareApp
//
//  Created by Dustin on 11/1/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    let apiKey = "d1f0472d023ad9ed39cfbdf11b317f74"
  
    @IBOutlet weak var cityNameLabel: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func getCurrentWeather(_ sender: Any) {
        let cityName = cityNameLabel.text
        
        let urlAsString = "http://api.openweathermap.org/data/2.5/weather?q=" + cityName! + "&units=imperial&appid=" + apiKey
        
        print(urlAsString)
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            let weather:NSArray = jsonResult["weather"]! as! NSArray
            let p = (weather.count as Int)
            
            for i in 0..<p {
                if let forecast = weather[i] as? [String:AnyObject] {
                    DispatchQueue.main.async {
                        self.mainLabel.text = forecast["main"] as! String
                        self.descriptionLabel.text = forecast["description"] as! String
                    }
                }
            }
            
            let main:NSObject = jsonResult["main"] as! NSObject
            if let weatherInfo = main as? [String:AnyObject] {
                DispatchQueue.main.async {
                    let temp: Double = (weatherInfo["temp"] as? NSNumber) as! Double
                    self.tempLabel.text = String(temp)
                    self.tempLabel.text! += " °F"
                }
            }
            
            
        })
        
        jsonQuery.resume()
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
