//
//  ViewControllerForShippingInfo.swift
//  
//
//  Created by Rahul Kumar on 7/11/17.
//
//

import UIKit

class ViewControllerForShippingInfo: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var AddressLine1: UITextField!
    @IBOutlet weak var AddressLine2: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var ZipCodeTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet var ContinueButton: UIButton!
    @IBOutlet var FoogleBackground: UIImageView!
    
    @IBOutlet var FoogleLogo: UILabel!
    
    static var emailText = ""
    static var addressLine1Text = ""
    static var addressLine2Text = ""
    static var CityText = ""
    static var ZipCodeText = ""
    static var PhoneNumberText = ""
    static var CountryText = ""
    static var StateText = ""
    
    override func viewDidLayoutSubviews() {
        if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c"
            || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE")
        {
            FoogleLogo.isHidden = true
        }
        if(ViewController.isIpad)
        {
           FoogleLogo.isHidden = true
           var isEmailField = false
           for view in self.view.subviews as [UIView]
           {
            if let img = view as? UIImageView {
               img.frame = self.view.frame
            }
            else if let lbl = view as? UILabel {
               if(lbl.text == "Email Address")
               {
                print("reached")
                 view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY + 45, width: view.frame.width, height: view.frame.height)
               }
               else
               {
               view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY + 25, width: view.frame.width, height: view.frame.height)
               }
            }
            else
            {
             view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY + 12, width: view.frame.width, height: view.frame.height)
                if let lbl = view as? UITextField {
                    if !isEmailField
                    {
                        view.frame = CGRect.init(x: view.frame.minX, y: view.frame.midY + 12, width: view.frame.width, height: view.frame.height)
                        isEmailField = true
                    }
                }
            }
            }
        }
        if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS")
        {
            FoogleBackground.frame = self.view.frame
        }
        if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR"  || ViewController.modelName == "Simulator")
        {
            FoogleBackground.frame = self.view.frame
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        ContinueButton.layer.cornerRadius = 10
        
        //registerForKeyboardNotifications()
        self.CountryTextField.delegate = self
        self.EmailTextField.delegate = self
        self.AddressLine1.delegate = self
        self.AddressLine2.delegate = self
        self.CityTextField.delegate = self
        self.ZipCodeTextField.delegate = self
        self.CountryTextField.delegate = self
        self.StateTextField.delegate = self
        self.PhoneNumberTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Setup Information", message: "Foogle needs to collect this information to ship the recipe. ", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField
        {
        case EmailTextField:
            ViewControllerForShippingInfo.emailText = EmailTextField.text!
            textField.resignFirstResponder()
            break
            
        case AddressLine1:
            ViewControllerForShippingInfo.addressLine1Text = AddressLine1.text!
            textField.resignFirstResponder()
            break
            
        case AddressLine2:
            ViewControllerForShippingInfo.addressLine2Text = AddressLine2.text!
            textField.resignFirstResponder()
            break
            
        case CityTextField:
            ViewControllerForShippingInfo.CityText = CityTextField.text!
            textField.resignFirstResponder()
            break
            
        case ZipCodeTextField:
            ViewControllerForShippingInfo.ZipCodeText = ZipCodeTextField.text!
            textField.resignFirstResponder()
            break
            
        case PhoneNumberTextField:
            ViewControllerForShippingInfo.PhoneNumberText = PhoneNumberTextField.text!
            textField.resignFirstResponder()
            break
        case CountryTextField:
            ViewControllerForShippingInfo.CountryText = CountryTextField.text!
            textField.resignFirstResponder()
            break
        case StateTextField:
            ViewControllerForShippingInfo.StateText = StateTextField.text!
            textField.resignFirstResponder()
            break
            
            
        default:
            textField.resignFirstResponder()
        }
    }
    
    func runCheck()
    {
        
        
        
        
        
       if(ViewControllerForShippingInfo.emailText == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The e-mail address was left blank.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.EmailTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

       }
       else if(ViewControllerForShippingInfo.emailText.range(of: "@") == nil)
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The e-mail address is invalid.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.EmailTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
       }
       else if(ViewControllerForShippingInfo.addressLine1Text == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The address field is empty.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.AddressLine1.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

       }
       else if(ViewControllerForShippingInfo.CityText == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The City field is empty.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.CityTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

       }
       else if(ViewControllerForShippingInfo.ZipCodeText == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The zip code field is empty.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.ZipCodeTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
       }
       else if(ViewControllerForShippingInfo.StateText == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The state field is empty.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.StateTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
       }
       else if(ViewControllerForShippingInfo.CountryText == "")
       {
        let alert = UIAlertController(title: "Uh-Oh!", message: "The country field is empty.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.CountryTextField.backgroundColor = UIColor.red
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
       }
       else
       {
        UserDefaults.standard.set(ViewControllerForShippingInfo.emailText, forKey: "Email:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.addressLine1Text, forKey: "Address 1:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.addressLine2Text, forKey: "Address 2:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.CityText, forKey: "City:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.ZipCodeText, forKey: "Zip Code:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.PhoneNumberText, forKey: "Phone Number:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.CountryText, forKey: "Country:")
        UserDefaults.standard.set(ViewControllerForShippingInfo.StateText, forKey: "State:")

        dismiss(animated: true, completion: nil)
        ViewController.conditionforShippingAddressIsFulfilled = 1
        let boolForFirstTimeCompletion = true
        UserDefaults.standard.set(boolForFirstTimeCompletion, forKey: "Shipping Setup")
        
       }
    }

    @IBAction func OnContinuePress(_ sender: Any) {
        runCheck()
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
