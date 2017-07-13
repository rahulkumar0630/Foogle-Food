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
