//
//  ViewController.swift
//  Api-Demo-one
//
//  Created by MacStudent on 2020-01-17.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var show: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func selectCity(_ sender: UIButton) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityText.text!.replacingOccurrences(of: " ", with: "%20"))&appid=da57bbe02f6c0e658a3eef5185d7ece0")!
               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let error = error {
                       print(error)
                   } else {
                       if let urlContent = data{
                           do{
                               let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)  as? NSDictionary
                              // print(jsonResult)
                              // print(jsonResult?["name"] as! String)
                               if let description = ((jsonResult?["weather"] as? NSArray)?[0] as? NSDictionary)? ["description"] as? String{
                                   print(description)
                                DispatchQueue.main.async {
                                    self.show.text = description
                                }
                               }
                           } catch{
                               print(error)
                           }
                      
                       }
                   }
               }
               // start the task
               task.resume()
        
    }
    

}

