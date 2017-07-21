//
//  ViewControllerForSettingsTab.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 7/12/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit

class ViewControllerForSettingsTab: UIViewController {
    @IBOutlet var EmailLabel: UILabel!
    @IBOutlet var Address1Label: UILabel!
    @IBOutlet var AddressLine2: UILabel!
    @IBOutlet var PhoneNumber: UILabel!
    @IBOutlet var City: UILabel!
    @IBOutlet var ZipCode: UILabel!
    @IBOutlet var State: UILabel!
    @IBOutlet var Country: UILabel!
    @IBOutlet var SavedInfoLabel: UILabel!
    @IBOutlet var ZipCodeTitleLabel: UILabel!
    @IBOutlet var BackDrop: UIImageView!
    @IBOutlet var EmailTitleLabel: UILabel!
    @IBOutlet var AddressLine1TitleLabel: UILabel!
    @IBOutlet var Address2TitleLabel: UILabel!
    @IBOutlet var PhoneNumberTitle: UILabel!
    @IBOutlet var CityTitleLabel: UILabel!
    @IBOutlet var ZipCodeTitle: UILabel!
    @IBOutlet var StateTitleLabel: UILabel!
    @IBOutlet var CountryTitleLabel: UILabel!
    
    override func viewDidLayoutSubviews() {
        if(ViewController.modelName == "Simulator")
        {
            SavedInfoLabel.frame = CGRect.init(x: 18, y: 58, width: 285, height: 87)
            SavedInfoLabel.adjustsFontSizeToFitWidth = true
            ZipCodeTitleLabel.frame = CGRect.init(x: 229, y: 388, width: 75, height: 21)
            ZipCode.frame = CGRect.init(x: 235, y: 417, width: 83, height: 21)
            BackDrop.frame = CGRect.init(x: 0, y: 0, width: 320, height: 568)
            Country.frame = CGRect.init(x: 105, y: 534, width: 191, height: 21)
            PhoneNumber.frame = CGRect.init(x: 168, y: 342, width: 152, height: 21)
            CityTitleLabel.frame = CGRect.init(x: 31, y: 388, width: 35, height: 21)
            City.frame = CGRect.init(x: 31, y: 417, width: 192, height: 21)
            StateTitleLabel.frame = CGRect.init(x: 31, y: 446, width: 45, height: 21)
            State.frame = CGRect.init(x: 31, y: 475, width: 192, height: 21)
            CountryTitleLabel.frame = CGRect.init(x: 31, y: 504, width: 66, height: 21)
            Country.frame = CGRect.init(x: 32, y: 533, width: 191, height: 21)
            
        }
        if(ViewController.modelName == "iPhone 7 Plus")
        {
            BackDrop.frame = CGRect.init(x: 0, y: 0, width: 414, height: 736)
            SavedInfoLabel.frame  = CGRect.init(x: 52, y: 58, width: 312, height: 87)
            EmailTitleLabel.frame = CGRect.init(x: 31, y: 153, width: 46, height: 21)
            EmailLabel.frame = CGRect.init(x: 31, y: 182, width: 297, height: 21)
            AddressLine1TitleLabel.frame = CGRect.init(x: 31, y: 218, width: 116, height: 21)
            Address1Label.frame = CGRect.init(x: 31, y: 247, width: 297, height: 21)
            Address2TitleLabel.frame = CGRect.init(x: 31, y: 284, width: 118, height: 21)
            AddressLine2.frame = CGRect.init(x: 31, y: 313, width: 312, height: 21)
            PhoneNumberTitle.frame = CGRect.init(x: 31, y: 358, width: 120, height: 21)
            PhoneNumber.frame = CGRect.init(x: 31, y: 391, width: 192, height: 21)
            CityTitleLabel.frame = CGRect.init(x: 32, y: 449, width: 35, height: 21)
            City.frame = CGRect.init(x: 31, y: 489, width: 192, height: 21)
           ZipCodeTitle.frame = CGRect.init(x: 276, y: 448, width: 75, height: 21)
           ZipCode.frame = CGRect.init(x: 280, y: 489, width: 83, height: 21)
            StateTitleLabel.frame = CGRect.init(x: 32, y: 528, width: 45, height: 21)
            State.frame = CGRect.init(x: 31, y: 557, width: 192, height: 21)
            CountryTitleLabel.frame = CGRect.init(x: 31, y: 598, width: 66, height: 21)
            Country.frame = CGRect.init(x: 31, y: 627, width: 191, height: 21)
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let email = UserDefaults.standard.object(forKey: "Email:") as? String
        {
            EmailLabel.text = email
        }
        if let address1 = UserDefaults.standard.object(forKey: "Address 1:") as? String
        {
            Address1Label.text = address1
        }
        if let address2 = UserDefaults.standard.object(forKey: "Address 2:") as? String
        {
            AddressLine2.text = address2
        }
        if let city = UserDefaults.standard.object(forKey: "City:") as? String
        {
            City.text = city
        }
        if let zipcode = UserDefaults.standard.object(forKey: "Zip Code:") as? String
        {
            ZipCode.text = zipcode
        }
        if let phonenumber = UserDefaults.standard.object(forKey: "Phone Number:") as? String
        {
            PhoneNumber.text = phonenumber
        }
        if let country = UserDefaults.standard.object(forKey: "Country:") as? String
        {
            Country.text = country
        }
        if let state = UserDefaults.standard.object(forKey: "State:") as? String
        {
            State.text = state
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnExitPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
