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
    @IBOutlet var FoogleLogo: UILabel!
    @IBOutlet var SupportLabel: UILabel!
    @IBOutlet var ExitButton: UIButton!
    var layedOut = false

    
    override func viewDidLayoutSubviews() {
        if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c"
           || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE"  || ViewController.modelName == "Simulator")
        {
            OrderInfoLabel.frame = CGRect.init(x: 16, y: 49, width: 288, height: 107)
            OrderInfoLabel.adjustsFontSizeToFitWidth = true
            ZipCodeTitleLabel.frame = CGRect.init(x: 199, y: 279, width: 121, height: 30)
            ZipCodeLabel.frame = CGRect.init(x: 208, y: 315, width: 96, height: 21)
            NoticeLogo.frame = CGRect.init(x: 28, y: 435, width: 281, height: 113)
            SupportLabel.frame = CGRect.init(x: 28, y: 480, width: 281, height: 113)
            NoticeLogo.numberOfLines = 4
            NoticeLogo.adjustsFontSizeToFitWidth = true
            BackDrop.frame = CGRect.init(x: 0, y: 0, width: 320, height: 568)
        }
        if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus")
        {
            BackDrop.frame = CGRect.init(x: 0, y: 0, width: 414, height: 736)
            FoogleLogo.frame = CGRect.init(x: 16, y: 672, width: 97, height: 44)
            NoticeLogo.frame = CGRect.init(x: 23, y: 509, width: 340, height: 76)
            SupportLabel.frame = CGRect.init(x: 23, y: 623, width: 340, height: 21)
            OrderInfoLabel.frame = CGRect.init(x: -20, y: 49, width: 455, height: 107)
        }
            if(ViewController.isIpad)
            {
                if(!layedOut)
                {
                    OrderInfoLabel.isHidden = true
                    for view in self.view.subviews as [UIView]
                    {
                        view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY - 100, width: view.frame.width, height: view.frame.height)
                        if let img = view as? UIImageView {
                            img.frame = self.view.frame
                        }
                        if let btn = view as? UIButton
                        {
                            if(btn.clipsToBounds == false)
                            {
                                view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY + 63, width: view.frame.width, height: view.frame.height)
                            }
                        }
                        if let txt = view as? UILabel
                        {
                            if(txt == NoticeLogo)
                            {
                               NoticeLogo.adjustsFontSizeToFitWidth = true
                               view.frame = CGRect.init(x: 23, y: 380, width: 281, height: 76)
                            }
                            if(txt == SupportLabel)
                            {
                                view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY - 35, width: view.frame.width, height: view.frame.height)
                            }
                            if(txt == ZipCodeTitleLabel)
                            {
                                view.frame = CGRect.init(x: view.frame.minX - 40, y: view.frame.midY, width: view.frame.width, height: view.frame.height)
                            }
                            if(txt == ZipCodeLabel)
                            {
                                view.frame = CGRect.init(x: view.frame.minX - 40, y: view.frame.midY, width: view.frame.width, height: view.frame.height)
                            }
                        }
                    }
                    layedOut = true
                }
            }
            if(ViewController.modelName == "iPhone X")
            {
               BackDrop.frame = self.view.frame
               FoogleLogo.frame = CGRect.init(x: 16, y: 745, width: 88, height: 25)
               ExitButton.frame = CGRect.init(x: 16, y: 44, width: 37, height: 36)
               OrderInfoLabel.frame = CGRect.init(x: -40, y: 64, width: 455, height: 107)
                
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NoticeLogo.isHidden = true
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
        for i in 0 ... ViewController.IngredientsArrayForMySQLtransfer.count - 1
        {
           
            if(ViewController.IngredientsArrayForMySQLtransfer[i].accessibilityHint != "removed")
            {
                postString += "ING\(numberofitemsthatarenotremoved)=\(ViewController.IngredientsArrayForMySQLtransfer[i].text!)&"
                lastinstanceofi = i
                numberofitemsthatarenotremoved = numberofitemsthatarenotremoved + 1
            }
        }
        postString += "AOI=\(lastinstanceofi)&"
        
        var numberofcoststhatarenotremoved = 0
        
        for i in 0 ... ViewController.CostsArrayForMySQLtransfer.count - 1
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
