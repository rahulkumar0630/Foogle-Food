//
//  ViewControllerForOrderInfo.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 7/15/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit

class ViewControllerForOrderInfo: UIViewController {
    
    
    @IBOutlet var OrderNumberLabel: UILabel!
    @IBOutlet var AddressLabel: UILabel!
    @IBOutlet var CityLabel: UILabel!
    @IBOutlet var ZipCodeLabel: UILabel!
    @IBOutlet var StateLabel: UILabel!
    @IBOutlet var CountryLabel: UILabel!
    @IBOutlet var OrderInfoLabel: UILabel!
    @IBOutlet var ZipCodeTitleLabel: UILabel!
    
    @IBOutlet var NoticeLogo: UILabel!
    @IBOutlet var BackDrop: UIImageView!
    
    override func viewDidLayoutSubviews() {
        if(ViewController.modelName == "Simulator")
        {
            OrderInfoLabel.frame = CGRect.init(x: 16, y: 49, width: 288, height: 107)
            OrderInfoLabel.adjustsFontSizeToFitWidth = true
            ZipCodeTitleLabel.frame = CGRect.init(x: 199, y: 279, width: 121, height: 30)
            ZipCodeLabel.frame = CGRect.init(x: 208, y: 315, width: 96, height: 21)
            NoticeLogo.frame = CGRect.init(x: 28, y: 460, width: 281, height: 113)
            NoticeLogo.numberOfLines = 4
            NoticeLogo.adjustsFontSizeToFitWidth = true
            BackDrop.frame = CGRect.init(x: 0, y: 0, width: 320, height: 568)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var completedOrderString = ""
        
        for i in 0 ... 8
        {
            let randomOrderNumber = Int(arc4random_uniform(10))
            completedOrderString  = completedOrderString + String(randomOrderNumber)
        }
        OrderNumberLabel.text = completedOrderString
        
        var postString = ""
        
        postString += "OrderNumber=\(completedOrderString)&"

        if let email = UserDefaults.standard.object(forKey: "Email:")
        {
            postString += "email=\(email)&"
        }

        if let address1 = UserDefaults.standard.object(forKey: "Address 1:") as? String
        {
            AddressLabel.text = address1
            postString += "address=\(address1)&"
        }
        if let city = UserDefaults.standard.object(forKey: "City:") as? String
        {
            CityLabel.text = city
            postString += "city=\(city)&"
        }
        if let zipcode = UserDefaults.standard.object(forKey: "Zip Code:") as? String
        {
            ZipCodeLabel.text = zipcode
            postString += "zipcode=\(zipcode)&"
        }
        if let state = UserDefaults.standard.object(forKey: "State:") as? String
        {
            StateLabel.text = state
            postString += "state=\(state)&"
            
        }
        if let country = UserDefaults.standard.object(forKey: "Country:") as? String
        {
            CountryLabel.text = country
            postString += "country=\(country)&"
        }
        postString += "URL=\(ViewController.URLforOrderInfo)&"
        
        
        var lastinstanceofi = 0
        var numberofitemsthatarenotremoved = 0
        for i in 0 ... ViewController.OriginalIngredientsArrayForMySQLtransfer.count - 1
        {
           
            if(ViewController.IngredientsArrayForMySQLtransfer[i].accessibilityHint != "removed")
            {
                postString += "ING\(numberofitemsthatarenotremoved)=\(ViewController.OriginalIngredientsArrayForMySQLtransfer[i])&"
                lastinstanceofi = i
                numberofitemsthatarenotremoved = numberofitemsthatarenotremoved + 1
            }
        }
        postString += "AOI=\(lastinstanceofi)&"
        
        var numberofcoststhatarenotremoved = 0
        
        for i in 0 ... ViewController.OriginalCostsArrayForMySQLtransfer.count - 1
        {
            if(ViewController.CostsArrayForMySQLtransfer[i].accessibilityHint != "removed")
            {
                postString += "COST\(numberofcoststhatarenotremoved)=\(ViewController.OriginalCostsArrayForMySQLtransfer[i])&"
                numberofcoststhatarenotremoved = numberofcoststhatarenotremoved + 1
            }
        }
        print(postString)
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/EmailScript/phpToMySQLandEmail.php")! as URL)
        request.httpMethod = "POST"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        
        
    }
    @IBAction func OnExitButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
