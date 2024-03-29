//
//  ViewController.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/8/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import WebKit
import StoreKit


class ViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate, UISearchBarDelegate, UITextFieldDelegate, PayPalPaymentDelegate, WKScriptMessageHandler{

    @IBOutlet var WebView: UIWebView!
    var currentURL:String = ""
    var webViewforData = WKWebView()
    var stringforvalue:String = ""
    var boolForSubstring:Bool = false
    var incremetor:Int = 0
    var newPriceString:String = ""
    var NextQoute: Bool = false
    var UrlBeforeSent: String = ""
    var StringforIngredients: String = ""
    var Price:Double = 0.0
    var ChangeNewLabel:Bool = false
    var ArrayForIngredients = [String]()
    var NumberofTimesWebViewLoaded:Int = 0
    let CanGoBack = UIImage(named: "arrow_back_white_192x192")
    let canGoForward = UIImage(named: "arrow_forward_white_192x192")
    let CantGoBack = UIImage(named: "arrowBackWhenCantGoBack")
    let cantGoForward = UIImage(named: "arrowForwardWhenCantGoForward")
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    var LabelForInsertingIngredients = UILabel()
    let grayView = UIView()
    var arrayForDisplayItems = [UILabel]()
    var LabelforInsertingCost = UILabel()
    var ArrayforType = [String]()
    var arrayforCost = [Double]()
    var arrayforDisplayingCost = [UILabel]()
    var arrayForDeleteButtons = [UIButton]()
    var servingsstring = ""
    var addButtonImage = UIImage(named: "PlusSign")
    let toolbar = UIToolbar()
    var buttonTag = 0
    var titleOfRecipe = ""
    static var conditionforShippingAddressIsFulfilled = 0
    static var URLforOrderInfo = ""
    static var IngredientsArrayForMySQLtransfer = [UILabel]()
    static var CostsArrayForMySQLtransfer = [UILabel]()
    static var OriginalIngredientsArrayForMySQLtransfer = [String]()
    static var OriginalCostsArrayForMySQLtransfer = [Double]()
    var booleantoLayoutSearchBar = false
    var booleanToFindPrice = false
    var boolToFindPriceFromTextArea = false
    var booltogetNutrition = false
    static let modelName = UIDevice.current.modelName
    var forFirstTime = false
    static var isIpad = false
    var FirstTimeOn = UserDefaults.standard.object(forKey: "FirstTimeOn") as? Bool
    var MessageDismissedfor50 = UserDefaults.standard.object(forKey: "MessageDismissedfor50") as? Bool
    var InitialServings = true
    var isIphone5 = false
    
    


    
    
   var theBool: Bool!
   var myTimer: Timer!

    @IBOutlet var LoaderView: UIView!
    @IBOutlet var Masterview: UIView!
    @IBOutlet var Orderbutton: UIButton!
    //@IBOutlet var SmallSearchRecipes: UILabel!
    @IBOutlet var BigSearchRecipes: UILabel!
    @IBOutlet var WhiteBar: UIImageView!
    @IBOutlet var BackArrow: UIButton!
    @IBOutlet var ForwardArrow: UIButton!
    @IBOutlet var OrderView: UIView!
    @IBOutlet var PriceTextinOrderView: UILabel!
    @IBOutlet var ActivitySpinner: UIActivityIndicatorView!
    @IBOutlet var ActivityIndicatorforWeb: UIActivityIndicatorView!
    @IBOutlet var StackViewForIngredients: UIStackView!
    @IBOutlet var StackViewForCost: UIStackView!
    @IBOutlet var PaynowButton: UIButton!
    @IBOutlet var ServingsLabel: UILabel!
    @IBOutlet var SearchBar: UISearchBar!
    @IBOutlet var FoogleImageView: UIImageView!
    @IBOutlet var FoogleLogo: UILabel!
    @IBOutlet var TextFieldToEnterMore: UITextField!
    @IBOutlet var ActivityIndicatorForTextField: UIActivityIndicatorView!
    @IBOutlet var ActivityIndicatorforPriceLabel: UIActivityIndicatorView!
    @IBOutlet var StackViewForDeleteButtons: UIStackView!
    @IBOutlet var StepperOutlet: UIStepper!
    @IBOutlet var ShippingTaxesServicesLabel: UILabel!
    @IBOutlet var ServicePrice: UILabel!
    @IBOutlet var SettingsButton: UIButton!
    @IBOutlet var IngredientLabelOnOrderView: UILabel!
    
    @IBOutlet var CostLabelOnOrderView: UILabel!
    @IBOutlet var ShippingTaxesServicesOrderViewLabel: UILabel!

    @IBOutlet var BackgroundForFoogle: UIImageView!
    
    @IBOutlet var NutritionOutlet: UIButton!
    @IBOutlet var ConfirmButton: UIButton!
    
    
    
    var environment:String = PayPalEnvironmentProduction
    {
        willSet(newEnvironment) {
            if (newEnvironment != environment)
            {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    override func viewDidLayoutSubviews() {
        
        
        if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c"
            || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE")
        {
            //OrderView.frame = CGRect.init(x: 9, y: 600, width: 303, height: 498)
            FoogleImageView.frame = self.view.frame
            FoogleLogo.frame = CGRect.init(x: 56, y: 220, width: 207, height: 77)
            BigSearchRecipes.frame = CGRect.init(x: 28, y: 15, width: 262, height: 45)
            ActivityIndicatorforWeb.frame = CGRect.init(x: 149, y: 27, width: 20, height: 20)
            if(booleantoLayoutSearchBar == false)
            {
                SearchBar.frame = CGRect.init(x: 0, y: 296, width: 319, height: 44)
                booleantoLayoutSearchBar = true
            }
            SettingsButton.frame = CGRect.init(x: 271, y: 20, width: 30, height: 30)
            LoaderView.frame = CGRect.init(x: 104, y: 247, width: 112, height: 74)
            ActivitySpinner.frame = CGRect.init(x: 46, y: 28, width: 20, height: 20)
            WebView.frame = CGRect.init(x: 0, y: 78, width: 320, height: 435)
            //self.OrderView.frame = CGRect.init(x: 9, y: 801, width: 301, height: 500)
            IngredientLabelOnOrderView.frame = CGRect.init(x: 5, y: 42, width: 115, height: 28)
            CostLabelOnOrderView.frame = CGRect.init(x: 207, y: 42, width: 73, height: 28)
            StackViewForIngredients.frame = CGRect.init(x: 8, y: 103, width: 199, height: 339)
            StackViewForCost.frame = CGRect.init(x: 227, y: 103, width: 55, height: 339)
            StackViewForDeleteButtons.frame = CGRect.init(x: 278, y: 103, width: 24, height: 339)
            ShippingTaxesServicesOrderViewLabel.frame = CGRect.init(x: 8, y: 440, width: 209, height: 21)
            ServicePrice.frame = CGRect.init(x: 227, y: 440, width: 55, height: 21)
            PaynowButton.frame = CGRect.init(x: 207, y: 460, width: 86, height: 33)
            ConfirmButton.frame = CGRect.init(x: 207, y: 460, width: 86, height: 33)
            TextFieldToEnterMore.frame = CGRect.init(x: 5, y: 73, width: 193, height: 30)
            Orderbutton.frame = CGRect.init(x: 196, y: 521, width: 108, height: 39)
            BackgroundForFoogle.frame = self.view.frame
            BackArrow.frame = CGRect.init(x: 16, y: 516, width: 47, height: 48)
            ForwardArrow.frame = CGRect.init(x: 63, y: 516, width: 47, height: 48)
            PriceTextinOrderView.frame = CGRect.init(x: 73, y: 12, width: 156, height: 21)
            ActivityIndicatorforPriceLabel.frame = CGRect.init(x: 141, y: 13, width: 20, height: 20)
            ActivityIndicatorForTextField.frame = CGRect.init(x: 233, y: 78, width: 20, height: 20)
            NutritionOutlet.frame = CGRect.init(x: 13, y: 16, width: 97, height: 32)
            ServingsLabel.frame = CGRect.init(x: ServingsLabel.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            StepperOutlet.frame = CGRect.init(x: ServingsLabel.frame.midX, y: PaynowButton.frame.minY + 3, width: StepperOutlet.frame.width - 5, height: ServingsLabel.frame.height)
            isIphone5 = true
        
        }
        
        if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus")
        {
            //self.OrderView.frame.origin.y = 800
            
            FoogleLogo.frame = CGRect.init(x: 104, y: 253, width: 207, height: 77)
            FoogleImageView.frame = CGRect.init(x: 0, y: 0, width: 414, height: 736)
            SettingsButton.frame = CGRect.init(x: 360, y: 20, width: 34, height: 35)
            BigSearchRecipes.frame = CGRect.init(x: 76, y: 15, width: 262, height: 45)
            ActivityIndicatorforWeb.frame = CGRect.init(x: 198, y: 28, width: 20, height: 20)
            BackgroundForFoogle.frame = CGRect.init(x: 0, y: 0, width: 414, height: 736)
            Orderbutton.frame = CGRect.init(x: 289, y: 689, width: 105, height: 39)
            BackArrow.frame = CGRect.init(x: 9, y: 684, width: 47, height: 48)
            ForwardArrow.frame = CGRect.init(x: 56, y: 684, width: 47, height: 48)
            WebView.frame = CGRect.init(x: 0, y: 97, width: 414, height: 579)
            PaynowButton.frame = CGRect.init(x: 265, y: 625, width: 110, height: 33)
            ConfirmButton.frame = CGRect.init(x: 265, y: 625, width: 110, height: 33)
            PriceTextinOrderView.frame = CGRect.init(x: 117, y: 13, width: 156, height: 21)
            ActivityIndicatorforPriceLabel.frame = CGRect.init(x: 182, y: 13, width: 20, height: 20)
            CostLabelOnOrderView.frame = CGRect.init(x: 259, y: 42, width: 73, height: 28)
            ActivityIndicatorForTextField.frame = CGRect.init(x: 285, y: 78, width: 20, height: 20)
            StackViewForIngredients.frame = CGRect.init(x: 8, y: 103, width: 231, height: 482)
            StackViewForCost.frame = CGRect.init(x: 259, y: 103, width: 79, height: 482)
            StackViewForDeleteButtons.frame = CGRect.init(x: 346, y: 103, width: 24, height: 482)
            ShippingTaxesServicesOrderViewLabel.frame = CGRect.init(x: 8, y: 593, width: 217, height: 21)
            ServicePrice.frame = CGRect.init(x: 259, y: 592, width: 79, height: 21)
            LoaderView.frame = CGRect.init(x: 151, y: 328, width: 112, height: 74)
            ServingsLabel.frame = CGRect.init(x: ServingsLabel.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            StepperOutlet.frame = CGRect.init(x: StepperOutlet.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            
        }
        
        if(ViewController.modelName == "iPad 2" || ViewController.modelName == "iPad 3" || ViewController.modelName == "iPad 4" || ViewController.modelName == "iPad Air" || ViewController.modelName == "iPad Air 2" || ViewController.modelName == "iPad 5" || ViewController.modelName == "iPad Mini" || ViewController.modelName == "iPad Mini 2" || ViewController.modelName == "iPad Mini 3" || ViewController.modelName == "iPad Mini 4" || ViewController.modelName == "iPad Pro 9.7 Inch" || ViewController.modelName == "iPad Pro 12.9 Inch" || ViewController.modelName == "iPad Pro 12.9 Inch 2. Generation" || ViewController.modelName == "iPad Pro 10.5 Inch")
        {
            FoogleImageView.frame = self.view.frame
            FoogleLogo.frame = CGRect.init(x: 56, y: 220, width: 207, height: 77)
            BigSearchRecipes.frame = CGRect.init(x: 28, y: 15, width: 262, height: 45)
            ActivityIndicatorforWeb.frame = CGRect.init(x: 149, y: 27, width: 20, height: 20)
            if(booleantoLayoutSearchBar == false)
            {
                SearchBar.frame = CGRect.init(x: 0, y: 296, width: 319, height: 44)
                booleantoLayoutSearchBar = true
            }
            SettingsButton.frame = CGRect.init(x: 271, y: 20, width: 30, height: 30)
            LoaderView.frame = CGRect.init(x: 104, y: 247, width: 112, height: 74)
            ActivitySpinner.frame = CGRect.init(x: 46, y: 28, width: 20, height: 20)
            WebView.frame = CGRect.init(x: 0, y: 78, width: 320, height: 425)
            //self.OrderView.frame = CGRect.init(x: 9, y: 801, width: 301, height: 500)
            IngredientLabelOnOrderView.frame = CGRect.init(x: 5, y: 42, width: 115, height: 28)
            CostLabelOnOrderView.frame = CGRect.init(x: 207, y: 42, width: 73, height: 28)
            StackViewForIngredients.frame = CGRect.init(x: 8, y: 103, width: 199, height: 275)
            StackViewForCost.frame = CGRect.init(x: 227, y: 103, width: 55, height: 275)
            StackViewForDeleteButtons.frame = CGRect.init(x: 278, y: 103, width: 24, height: 275)
            ShippingTaxesServicesOrderViewLabel.frame = CGRect.init(x: 8, y: 400, width: 209, height: 21)
            ServicePrice.frame = CGRect.init(x: 227, y: 400, width: 55, height: 21)
            PaynowButton.frame = CGRect.init(x: 207, y: 400, width: 86, height: 33)
            ConfirmButton.frame = CGRect.init(x: 207, y: 400, width: 86, height: 33)
            TextFieldToEnterMore.frame = CGRect.init(x: 5, y: 73, width: 193, height: 30)
            Orderbutton.frame = CGRect.init(x: 196, y: 440, width: 108, height: 35)
            BackgroundForFoogle.frame = CGRect.init(x: 0, y: 10, width: 320, height: 480)
            print("FRAME:\(self.view.frame)")
            BackArrow.frame = CGRect.init(x: 16, y: 430, width: 47, height: 48)
            BackArrow.backgroundColor = UIColor.black
            ForwardArrow.frame = CGRect.init(x: 63, y: 430, width: 47, height: 48)
            ForwardArrow.backgroundColor = UIColor.black
            PriceTextinOrderView.frame = CGRect.init(x: 73, y: 12, width: 156, height: 21)
            ActivityIndicatorforPriceLabel.frame = CGRect.init(x: 141, y: 13, width: 20, height: 20)
            ActivityIndicatorForTextField.frame = CGRect.init(x: 233, y: 78, width: 20, height: 20)
            NutritionOutlet.frame = CGRect.init(x: 13, y: 21, width: 97, height: 28)
            ServingsLabel.frame = CGRect.init(x: ServingsLabel.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            StepperOutlet.frame = CGRect.init(x: StepperOutlet.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            
            ViewController.isIpad = true
        }
        if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS" || ViewController.modelName == "Simulator")
        {
            FoogleImageView.frame = self.view.frame
            BigSearchRecipes.frame = CGRect.init(x: 56, y: 35, width: 262, height: 45)
            SettingsButton.frame = CGRect.init(x: 325, y: 35, width: 34, height: 35)
            ActivityIndicatorforWeb.frame = CGRect.init(x: 177, y: 45, width: 20, height: 20)
            BackgroundForFoogle.frame = self.view.frame
            WebView.frame = CGRect.init(x: 0, y: 118, width: 375, height: 613)
            NutritionOutlet.frame = CGRect.init(x: 16, y: 35, width: 97, height: 35)
            BackArrow.frame = CGRect.init(x: 16, y: 739, width: 47, height: 48)
            ForwardArrow.frame = CGRect.init(x: 56, y: 739, width: 47, height: 48)
            Orderbutton.frame = CGRect.init(x: 251, y: 744, width: 108, height: 39)
            LoaderView.frame = CGRect.init(x: 131, y: 336, width: 112, height: 74)
            OrderView.frame = CGRect.init(x: 9, y: 1000, width: 357, height: 677)
            StackViewForIngredients.frame = CGRect.init(x: 8, y: 103, width: 231, height: 486)
            StackViewForCost.frame = CGRect.init(x: 259, y: 103, width: 79, height: 486)
            StackViewForDeleteButtons.frame = CGRect.init(x: 314, y: 103, width: 24, height: 486)
            ShippingTaxesServicesOrderViewLabel.frame = CGRect.init(x: 8, y: 597, width: 217, height: 21)
            ServicePrice.frame = CGRect.init(x: 259, y: 597, width: 79, height: 21)
            PaynowButton.frame = CGRect.init(x: 239, y: 627, width: 110, height: 33)
            ConfirmButton.frame = CGRect.init(x: 239, y: 627, width: 110, height: 33)
            CostLabelOnOrderView.frame = CGRect.init(x: 256, y: 42, width: 73, height: 28)
            OrderView.frame = CGRect.init(x: 9, y: 1000, width: 357, height: 677)
            ServingsLabel.frame = CGRect.init(x: ServingsLabel.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            StepperOutlet.frame = CGRect.init(x: StepperOutlet.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            ActivityIndicatorForTextField.frame = CGRect.init(x: 270, y: 78, width: 20, height: 20)





        }
        if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR"){
            
            FoogleLogo.frame = CGRect.init(x: 104, y: 336, width: 207, height: 77)
            SearchBar.frame = CGRect.init(x: 0, y: 426, width: 414, height: 44)
            FoogleImageView.frame = self.view.frame
            SettingsButton.frame = CGRect.init(x: 360, y: 40, width: 34, height: 35)
            NutritionOutlet.frame = CGRect.init(x: NutritionOutlet.frame.minX, y: 40, width: NutritionOutlet.frame.width, height: NutritionOutlet.frame.height)
            BigSearchRecipes.frame = CGRect.init(x: 76, y: 35, width: 262, height: 45)
            ActivityIndicatorforWeb.frame = CGRect.init(x: 198, y: 48, width: 20, height: 20)
            BackgroundForFoogle.frame = self.view.frame
            Orderbutton.frame = CGRect.init(x: 289, y: 825, width: 105, height: 39)
            BackArrow.frame = CGRect.init(x: 9, y: 820, width: 47, height: 48)
            ForwardArrow.frame = CGRect.init(x: 56, y: 820, width: 47, height: 48)
            WebView.frame = CGRect.init(x: 0, y: 115, width: 414, height: 690)
            PaynowButton.frame = CGRect.init(x: 265, y: 700, width: 110, height: 33)
            ConfirmButton.frame = CGRect.init(x: 265, y: 625, width: 110, height: 33)
            PriceTextinOrderView.frame = CGRect.init(x: 8, y: 13, width: 380, height: 21)
            ActivityIndicatorforPriceLabel.frame = CGRect.init(x: 188, y: 14, width: 20, height: 20)
            CostLabelOnOrderView.frame = CGRect.init(x: 259, y: 42, width: 73, height: 28)
            ActivityIndicatorForTextField.frame = CGRect.init(x: 272, y: 78, width: 20, height: 20)
            StackViewForIngredients.frame = CGRect.init(x: 8, y: 103, width: 231, height: 550)
            StackViewForCost.frame = CGRect.init(x: 259, y: 103, width: 79, height: 550)
            StackViewForDeleteButtons.frame = CGRect.init(x: 346, y: 103, width: 24, height: 550)
            ShippingTaxesServicesOrderViewLabel.frame = CGRect.init(x: 8, y: 668, width: 217, height: 21)
            ServicePrice.frame = CGRect.init(x: 259, y: 668, width: 79, height: 21)
            LoaderView.frame = CGRect.init(x: 151, y: 411, width: 112, height: 74)
            ActivitySpinner.frame = CGRect.init(x: 46, y: 27, width: 20, height: 20)
            OrderView.frame = CGRect.init(x: 9, y: 1000, width: 396, height: 750)
            ServingsLabel.frame = CGRect.init(x: ServingsLabel.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
            StepperOutlet.frame = CGRect.init(x: StepperOutlet.frame.minX, y: PaynowButton.frame.minY + 3, width: ServingsLabel.frame.width, height: ServingsLabel.frame.height)
           

            
        }
        
        
        
        if(self.FirstTimeOn == nil)
        {
            let FirstTimePromo = UIAlertController(title: "Welcome!", message: "Please use this code for 50% off your first order: FOOGLEFIRST. To use this code, simply enter this code \"Add Other of Missing\" text field after you have pressed \"Order\" for the recipe you want.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            UserDefaults.standard.set(false, forKey: "FirstTimeOn")
            self.FirstTimeOn =  UserDefaults.standard.bool(forKey: "FirstTimeOn")
            print(self.FirstTimeOn)
            FirstTimePromo.dismiss(animated: false, completion: nil)
            
        }
        FirstTimePromo.addAction(cancelAction)
        
        
        self.present(FirstTimePromo, animated: true, completion: nil)
        
        }

    
        
    }

    var webConfig:WKWebViewConfiguration { 
        get {
            var webCfg:WKWebViewConfiguration = WKWebViewConfiguration()
            var userController:WKUserContentController = WKUserContentController()
            userController.add(self, name: "loginSuccess")
            
            webCfg.userContentController = userController;
            
            return webCfg;
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.backgroundColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        
        // Do any additional setup after loading the view, typically from a nib.
        var userController:WKUserContentController = WKUserContentController()
        userController.add(self, name: "loginSuccess")
        webViewforData = WKWebView(frame: self.view.frame, configuration: webConfig)
        
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Foogle Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .both;

        Orderbutton.layer.cornerRadius = 10
        NutritionOutlet.clipsToBounds = true
        NutritionOutlet.layer.cornerRadius = 10
        NutritionOutlet.isHidden = true
        SearchBar.text = ""
        ActivityIndicatorForTextField.isHidden = true
        ActivityIndicatorForTextField.startAnimating()
        TextFieldToEnterMore.delegate = self
        TextFieldToEnterMore.placeholder = "Add Other or Missing"
        ActivityIndicatorforPriceLabel.isHidden = true
        ActivityIndicatorforPriceLabel.startAnimating()
        TextFieldToEnterMore.returnKeyType = UIReturnKeyType.done
        
        self.NutritionOutlet.setTitleColor(UIColor.gray, for: .disabled)
        self.Orderbutton.setTitleColor(UIColor.gray, for: .disabled)
        
        self.NutritionOutlet.isEnabled = false
        self.Orderbutton.isEnabled = false
        
        
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        SearchBar.spellCheckingType = .yes
        SearchBar.autocorrectionType = .yes
        
        TextFieldToEnterMore.inputAccessoryView = toolbar
        
        webViewforData.navigationDelegate = self
        SearchBar.delegate = self
        WebView.delegate = self
        //SmallSearchRecipes.isHidden = true
        
        self.OrderView.frame.origin.y = 667
        OrderView.layer.cornerRadius = 10
        OrderView.removeFromSuperview()
        
        ActivitySpinner.isHidden = true
        ActivitySpinner.startAnimating()
        LoaderView.isHidden = true
        LoaderView.layer.cornerRadius = 10
        //LoaderView.addBlurEffect()
        Orderbutton.isHidden = true
        ConfirmButton.isHidden = true
        ConfirmButton.clipsToBounds = true
        ConfirmButton.layer.cornerRadius = 10
        
        
        //grayView.isHidden = true
        self.grayView.frame = self.view.bounds
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(grayView)
        self.grayView.addSubview(LoaderView)
        self.grayView.isHidden = true
        self.ActivityIndicatorforWeb.isHidden = true
        self.ActivityIndicatorforWeb.startAnimating()
        //StackViewForIngredients.removeFromSuperview()
        
        StepperOutlet.minimumValue = 1
        StepperOutlet.maximumValue = 25
        StepperOutlet.autorepeat = true
        StepperOutlet.isHidden = false
        ServingsLabel.isHidden = false
        self.ShippingTaxesServicesLabel.textColor = UIColor.gray
        self.ServicePrice.textColor = UIColor.gray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)

    }
    
    @objc func doneClicked(){
        self.view.endEditing(true)
    }

    
    func checkZipCode()
    {
        let zipcodeRetriever = UIAlertController(title: "First Time Setup!", message: "Please enter you zipcode to see if we deliver in your location.", preferredStyle: UIAlertController.Style.alert)
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.keyboardType = UIKeyboardType.numberPad
            print("generating the TextField")
            textField.placeholder = "Enter an item"
            tField = textField
        }
        zipcodeRetriever.addTextField(configurationHandler: configurationTextField)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.checkZipCodeinDB(UserZipCode: tField.text!)
            zipcodeRetriever.dismiss(animated: false, completion: nil)
        }
        zipcodeRetriever.addAction(cancelAction)

        
        self.present(zipcodeRetriever, animated: true, completion: nil)
        
    }
    
    func checkZipCodeinDB(UserZipCode: String)
    {
        var isValid = false
        let zipcodeURL = URL(string: "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/Zipcodes.json")
        
        print("USER: \(UserZipCode)")
        let task = URLSession.shared.dataTask(with: zipcodeURL!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Uh-Oh!", message: "The Server is down right now.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    self.grayView.isHidden = true
                }
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if let mydata = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(myJson)
                        
                        var count = 0
                        
                        DispatchQueue.main.async {

                        if let zipcodes = myJson["zipcodes"] as? [String]
                        {
                            print(zipcodes)
                            
                            while(!(isValid) && count < zipcodes.count)
                            {
                                if(UserZipCode == zipcodes[count])
                                {
                                    isValid = true
                                }
                                else
                                {
                                    isValid = false
                                }
                                count =  count + 1
                            }
                            
                            if(isValid)
                            {
                                let Congrats = UIAlertController(title: "Congratulations!", message: "Your Zipcode is one of the designated locations for delivery. You can try again if you didn't enter your zipcode properly. Please press Order again", preferredStyle: UIAlertController.Style.alert)
                            
                                let tryagain = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
                                    self.checkZipCode()
                                }
                                Congrats.addAction(tryagain)

                                let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                                    UserDefaults.standard.set(isValid, forKey: "AskForZipCode")
                                    
                                    var postString = "zipcode=\(UserZipCode)"
                                    let request = NSMutableURLRequest(url: NSURL(string: "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/EmailScript/phpToMySQLandEmail.php")! as URL)
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

                                Congrats.addAction(cancelAction)

                                
                                self.present(Congrats, animated: true, completion: nil)

                            }
                            else
                            {
                                let zipCodeNotAvaliable = UIAlertController(title: "We Are So Sorry", message: "Your Zipcode is not one of the designated locations for delivery, but feel free to use our Nutrition button, which can get nutrition off any recognizable recipe! You can try again if you didn't enter your zipcode properly.", preferredStyle: UIAlertController.Style.alert)
                                
                                let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                                    UserDefaults.standard.set(isValid, forKey: "AskForZipCode")
                                    var postString = "zipcode=\(UserZipCode)"
                                    
                                    let request = NSMutableURLRequest(url: NSURL(string: "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/EmailScript/phpToMySQLandEmail.php")! as URL)
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
                                let tryagain = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
                                    self.checkZipCode()
                                }
                                zipCodeNotAvaliable.addAction(cancelAction)
                                zipCodeNotAvaliable.addAction(tryagain)
                                
                                self.present(zipCodeNotAvaliable, animated: true, completion: nil)

                            }
                        }
                    }
                    }
                    catch {
                        // catch error
                    }
                }
            }
        }
        task.resume()

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        ActivityIndicatorForTextField.isHidden = false
        PriceTextinOrderView.isHidden = true
        ActivityIndicatorforPriceLabel.isHidden = false
        let convertedtextfieldtext = textField.text as! String
        
        let Url = "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/test.html?Data=\(convertedtextfieldtext)"
        print(Url)
        
        let urlSet = CharacterSet.urlQueryAllowed
            .union(CharacterSet.punctuationCharacters)
        
        let UrlBeforeSent = Url.addingPercentEncoding(withAllowedCharacters: urlSet)!
        print(UrlBeforeSent)
        
        let foodPriceUrl = URL(string: UrlBeforeSent)
        let requestforPrice = URLRequest(url: foodPriceUrl!)
        self.webViewforData.load(requestforPrice)
        boolToFindPriceFromTextArea = true

        return true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchBar.resignFirstResponder()
        print("hi")
        let stringforURL = SearchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) as! String
        //print(stringforURL)
        

        let urlSearch = URL(string: "https://www.google.com/search?ei=h3JeWeuwAYjRmAHG4aPgCg&q=\(stringforURL)+recipe&oq=spaghetti+&gs_l=mobile-gws-serp.1.0.41j0i67k1j0i46i67k1j46i67k1l2.25403.26647.0.27706.11.11.0.1.1.0.887.3922.2-5j4j1j0j1.11.0....0...1.1.64.mobile-gws-serp..6.5.1193.3..0j46j0i131k1j0i46k1.LMr8hsAQS2o")
        let request = URLRequest(url: urlSearch!)
        WebView.loadRequest(request)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc(webViewDidStartLoad:) func webViewDidStartLoad(_ webView: UIWebView)
    {
         ActivityIndicatorforWeb.isHidden = false
         BigSearchRecipes.isHidden = true
         SearchBar.placeholder = "Foogle"
         //checkArrowStatus()
    }
    

    
    func checkArrowStatus()
    {
        if(WebView.canGoBack == true)
        {
            
            UIWebView.transition(with: self.BackArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.BackArrow.setImage(self.CanGoBack, for: UIControl.State.normal)
            })
        }
        
        else if(WebView.canGoForward == true)
        {
            
            UIWebView.transition(with: self.ForwardArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.ForwardArrow.setImage(self.canGoForward, for: UIControl.State.normal)
            })
        }
        else if(WebView.canGoBack == false)
        {
            
            UIWebView.transition(with: self.BackArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.BackArrow.setImage(self.CantGoBack, for: UIControl.State.normal)
            })
        }
        
        else if(WebView.canGoForward == false)
        {
            
            UIWebView.transition(with: self.ForwardArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.ForwardArrow.setImage(self.cantGoForward, for: UIControl.State.normal)
            })
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
            ActivityIndicatorforWeb.isHidden = true
        
            SearchBar.inputAccessoryView = toolbar
        
            let currenturl = (WebView.request?.url?.absoluteString)!
            FoogleImageView.isHidden = true
        

            if(!(currenturl.contains("google")) || (currenturl.contains("https://www.google.com/amp/")))
            {
            
                UIView.transition(with: self.NutritionOutlet, duration: 0.2, options: .transitionCrossDissolve,
                                  animations: {
                                    self.NutritionOutlet.isEnabled = true
                })
                UIView.transition(with: self.Orderbutton, duration: 0.1, options: .transitionCrossDissolve,
                                  animations: {
                                    self.Orderbutton.isEnabled = true
                })
    
            }
            else
            {
            
                UIView.transition(with: self.NutritionOutlet, duration: 0.5, options: .transitionCrossDissolve,
                                  animations: {
                                    self.NutritionOutlet.isEnabled = false
                })
                UIView.transition(with: self.Orderbutton, duration: 0.5, options: .transitionCrossDissolve,
                                  animations: {
                                    self.Orderbutton.isEnabled = false
                })
            }
        
                if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c" || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE" || ViewController.isIpad)
                {
                    SearchBar.frame = CGRect.init(x: 0, y: 46, width: 319, height: 44)
                }
                else
                {
                    let newFrameForSearchBar = CGRect.init(x: 0, y: 63, width: SearchBar.layer.frame.width, height: 30)
                    SearchBar.frame = newFrameForSearchBar
                }
                if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus")
                {
                    SearchBar.frame = CGRect.init(x: 0, y: 70, width: 414, height: 27)
                }
                if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS" || ViewController.modelName == "Simulator")
                {
                    SearchBar.frame = CGRect.init(x: 0, y: 77, width: 375, height: 44)
                }
                if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR")
                {
                    SearchBar.frame = CGRect.init(x: 0, y: 92, width: SearchBar.frame.width, height: 20)
                }
        
            FoogleLogo.isHidden = true
            Orderbutton.isHidden = false
            NutritionOutlet.isHidden = false
    }
    
    
    func FindIngredients(Servings: Int, AlsoFindNutrition: Bool)
    {
        self.grayView.isHidden = false
        LoaderView.isHidden = false
        ActivitySpinner.isHidden = false
        var checkifrecipe = true
        var recipeservings = 0
        
        currentURL = (WebView.request?.url?.absoluteString)!
        ViewController.URLforOrderInfo = currentURL
        print(currentURL)
        ArrayForIngredients = [String]()
        
        let uRl = URL(string: "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/SERVER/index.php?url=" + currentURL)
        
        print(uRl)
        
        
        let task = URLSession.shared.dataTask(with: uRl!) { (data, response, error) in
            
            
            if error != nil {
                let alert = UIAlertController(title: "Uh-Oh!", message: "The Server is down right now.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    self.grayView.isHidden = true
                }
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("we have reached liftoff")
                if let mydata = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(myJson)

                        if let body = myJson["body"] as? String {
                            print("reached body")
                        }

                        //self.StepperOutlet.value = Double(self.servingsstring)!
                        
                        if let status = myJson["status"] as? String {
                            if(status == "failure")
                            {
                                let alert = UIAlertController(title: "Error", message: "This recipe cannot be extracted.", preferredStyle: UIAlertController.Style.alert)
                                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                                    self.grayView.isHidden = true
                                }
                                alert.addAction(cancelAction)
                                
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        }
                        
                        if let title = myJson["title"] as? String
                        {
                            self.titleOfRecipe = title
                            print("in title area")
                        }
                        let Recipedifferentiater = myJson["instructions"] as? String
                        
                        if Recipedifferentiater != "null"
                        {
                            if let servings = myJson["servings"] as? Int {

                                self.servingsstring = String(servings)
                                    if(self.InitialServings == true)
                                    {
                                        print("SERVINGS:\(servings)")
                                        DispatchQueue.main.async {
                                            
                                            if(self.isIphone5)
                                            {
                                                self.ServingsLabel.text = "SER: \(servings)"
                                            }
                                            else
                                            {
                                                self.ServingsLabel.text = "Servings: \(servings)"
                                            }
                                        }
                                        self.StepperOutlet.value = Double(servings)
                                        self.InitialServings = false
                                    }
                                print("STEP VALUE:\(self.StepperOutlet.stepValue)")
                                recipeservings = servings
    
                            }
                          
                            
                            if let stations = myJson["extendedIngredients"] as? [[String: AnyObject]] {
                                print("we are in the ingredient loop")
                            
                                for station in stations {
                                    
                                    if let name = station["originalString"] as? String{
                                        
                                        print(name)
                                        var constructedstring = ""
                                        
                                        if var amount = station["amount"] as? Double
                                        {
                                            
                                          if(Servings != 0)
                                          {
                                            var servingsfraction = self.rationalApproximation(of: amount)
                                            servingsfraction.num = Servings
                                            servingsfraction.den = recipeservings
                                            print("\(servingsfraction.num)/\(servingsfraction.den)")
                                            
                                            var amountfraction = self.rationalApproximation(of: amount)
                                            var NumForServings = servingsfraction.num * amountfraction.num
                                            var DemforServings =  servingsfraction.den * amountfraction.den
                                        
                                            
                                            var newamount = NumForServings/DemforServings
                                            var doublefromNum = Double(NumForServings)
                                            var doublefromDen = Double(DemforServings)
                                            
                                            if(newamount == 0)
                                            {
                                                let preciseDecimal = String(format: "%.3f", Double(doublefromNum/doublefromDen))
                                                let amountfraction = self.rationalApproximation(of: Double(preciseDecimal)!)
                                                

                                            let fractionString = "\(amountfraction.num)/\(amountfraction.den)"
                                                constructedstring = "\(fractionString)"
                                            }
                                            else
                                            {
                                                let preciseDecimal = String(format: "%.3f", Double(doublefromNum/doublefromDen))
                                                let preciseDecimalNoTrailing = String(format: "%g", Double(preciseDecimal)!)
                                                constructedstring = "\(preciseDecimalNoTrailing)"
                                            }
                                          }
                                          else
                                          {
                                                
                                                if(amount < 1.0)
                                                {
                                                    let fraction = self.rationalApproximation(of: amount)
                                                    var fractionString = "\(fraction.num)/\(fraction.den)"
                                                    constructedstring = "\(fractionString)"
                                                }
                                                else
                                                {
                                                    let roundedamount = round(amount * 100) / 100
                                                    constructedstring = "\(roundedamount)"
                                                }
                                            }
                                        }
                                        if let unitShort = station["unit"] as? String
                                        {
                                            constructedstring = constructedstring + " \(unitShort)"
                                        }
                                        if let name = station["name"] as? String
                                        {
                                            constructedstring = constructedstring + " \(name)"
                                            self.ArrayforType.append(name)
                                        }
                                        
                                        print("APPENDING: \(constructedstring)")
                                        self.ArrayForIngredients.append(constructedstring)
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                        else
                        {
                            print("This is not a recipe")
                            checkifrecipe = false
                            
                            let alert = UIAlertController(title: "Uh-Oh!", message: "Foogle could not recognize this webpage to be a recipe.", preferredStyle: UIAlertController.Style.alert)
                            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                                self.grayView.isHidden = true
                            }
                            alert.addAction(cancelAction)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    catch {
                        // catch error
                    }
                }
            }
            if(checkifrecipe == true)
            {
                for item in self.ArrayForIngredients {

                   if(item == self.ArrayForIngredients[self.ArrayForIngredients.count - 1])
                    {
                        self.StringforIngredients = "\(self.StringforIngredients) \(item)"
                        break
                    }
                    self.StringforIngredients = "\(self.StringforIngredients) \(item) %0A"
               }
                self.StringforIngredients = self.StringforIngredients.trimmingCharacters(in: .whitespacesAndNewlines)
                print(self.StringforIngredients)
                if(AlsoFindNutrition == false)
                {
                    self.FindIngredientPrice(Ingredient: self.StringforIngredients)
                    self.StringforIngredients = ""
                }
                else if(AlsoFindNutrition == true)
                {
                    self.StringforIngredients = self.StringforIngredients.trimmingCharacters(in: .whitespacesAndNewlines)
                    let urlSet = CharacterSet.urlQueryAllowed
                        .union(CharacterSet.punctuationCharacters)
                    
                    self.StringforIngredients = self.StringforIngredients.addingPercentEncoding(withAllowedCharacters: urlSet)!
                    
                    print(self.StringforIngredients)
                    let NutritionURL = URL(string: "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/Nutrition/index.php?Ingredients=" + self.StringforIngredients)
                    print(NutritionURL)
                    let requestforPrice = URLRequest(url: NutritionURL!)
                    self.StringforIngredients = ""
                    self.grayView.isHidden = false
                    self.LoaderView.isHidden = false
                    self.ActivitySpinner.isHidden = false
                    
                    if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus")
                    {
                        self.webViewforData.frame = CGRect.init(x: 9, y: -900, width: self.view.frame.width - 18, height: self.view.frame.height - 90)
                    }
                    else if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c"
                        || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE" || ViewController.isIpad)
                    {
                        self.webViewforData.frame = CGRect.init(x: 9, y: -900, width: self.view.frame.width - 18, height: self.view.frame.height - 70)
                    }
                    else
                    {
                        self.webViewforData.frame = CGRect.init(x: 9, y: -900, width: self.view.frame.width - 18, height: 587)
                    }
                    if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS" || ViewController.modelName == "Simulator")
                    {
                        self.webViewforData.frame = CGRect.init(x: 9, y: -900, width: self.view.frame.width - 18, height: 677)
                        
                    }
                    if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR")
                    {
                        self.webViewforData.frame = CGRect.init(x: 9, y: -900, width: self.view.frame.width - 18, height: 750)
                        
                    }
                    
                    self.webViewforData.load(requestforPrice)
                    self.StringforIngredients = ""
                    self.booltogetNutrition = true
                }
                
            }
        }
        
        task.resume()
    }
    
    @IBAction func OnOrderPress(_ sender: Any) {
        
        let toCheckZip = UserDefaults.standard.object(forKey: "AskForZipCode")
        
        if toCheckZip == nil
        {
            checkZipCode()
        }
        else
        {
            
            let userisNotinDesignatedZip = UserDefaults.standard.object(forKey: "AskForZipCode") as? Bool
            
            if userisNotinDesignatedZip! == false
            {
                let alert = UIAlertController(title: "Sorry", message: "Your Zip Code is not in the designated delivery area at this time.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    self.grayView.isHidden = true
                }
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                FindIngredients(Servings: 0, AlsoFindNutrition: false)
            }
        }
        
    }
    
    
    func FindIngredientPrice(Ingredient: String){
        

        self.UrlBeforeSent = "http://ec2-18-188-107-168.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)"
        
        let urlSet = CharacterSet.urlQueryAllowed
            .union(CharacterSet.punctuationCharacters)
        
        self.UrlBeforeSent = self.UrlBeforeSent.addingPercentEncoding(withAllowedCharacters: urlSet)!
        print(self.UrlBeforeSent)
        
        let foodPriceUrl = URL(string: self.UrlBeforeSent)
        let requestforPrice = URLRequest(url: foodPriceUrl!)
        DispatchQueue.main.async {

            self.webViewforData.load(requestforPrice)
            self.webViewforData.isHidden = true
            //self.Masterview.addSubview(self.webViewforData)
        }
        

        
        booleanToFindPrice = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
        
        if(self.booltogetNutrition == true)
        {
            self.webViewforData.evaluateJavaScript("document.body.style.zoom = 2.6;")
            if !UIAccessibility.isReduceTransparencyEnabled {
                self.view.backgroundColor = UIColor.clear
                //always fill the view
                self.blurEffectView.frame = self.view.bounds
                //CGRect.init(x: 0, y: 86, width: self.WebView.frame.width, height: self.WebView.frame.height)
                self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.webViewforData.isHidden = false
                self.ActivitySpinner.isHidden = true
                self.LoaderView.isHidden = true
                self.grayView.isHidden = true
                print("Showing Nutrition")
                self.webViewforData.clipsToBounds = true
                self.webViewforData.layer.cornerRadius = 10
                UIView.transition(with: self.Masterview,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.view.addSubview(self.blurEffectView)
                                    self.Masterview.addSubview(self.webViewforData)
                })
                let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    UIView.animate(withDuration: 1, animations: {
                            self.webViewforData.frame.origin.y = 70
                
                    })
                }
                if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS" || ViewController.modelName == "Simulator")
                {
                    let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        UIView.animate(withDuration: 1, animations: {
                            self.webViewforData.frame.origin.y = 110
                            
                        })
                    }
                }
                if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR")
                {
                    let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        UIView.animate(withDuration: 1, animations: {
                            self.webViewforData.frame.origin.y = 110
                            
                        })
                    }
                }
                let removedgesture = UITapGestureRecognizer(target: self, action: "resetValues:")
                blurEffectView.removeGestureRecognizer(removedgesture)
                let gesture = UITapGestureRecognizer(target: self, action: "resetvaluesForNutrition:")
                blurEffectView.addGestureRecognizer(gesture)
                
            } else {
                self.view.backgroundColor = UIColor.black
                
            }
            self.booltogetNutrition = false
        }
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("Script Handler Active")
           let messageBody = message.body as! [String:AnyObject]
           let APIDoneRequest = messageBody["Status"] as! String
           print(APIDoneRequest)
                if(booleanToFindPrice)
                {
            
                    self.webViewforData.evaluateJavaScript("document.getElementsByTagName('body')[0].innerHTML", completionHandler: { (value, error) in
                        //print(value)
                        self.stringforvalue = value as! String
                        print(self.stringforvalue)
                        var stringforIndivPrice = ""
                        var boolforIndivPrice = false
                        var incrematorforIndivPrice = 0
                        let removedgesture = UITapGestureRecognizer(target: self, action: "resetvaluesForNutrition:")
                        self.blurEffectView.removeGestureRecognizer(removedgesture)
                            if(self.ArrayForIngredients.count == 0)
                            {
                                let alert = UIAlertController(title: "Uh-Oh!", message: "Foogle could not recognize this webpage to be a recipe.", preferredStyle: UIAlertController.Style.alert)
                                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                                self.grayView.isHidden = true
                                }
                                alert.addAction(cancelAction)
                            
                                self.present(alert, animated: true, completion: nil)
                            }
                            else if self.stringforvalue.range(of:"price:") != nil{
            
            
                                let rangeforIndivPrice: Range<String.Index> = self.stringforvalue.range(of: "<br>$")!
                                let indexforIndivPrice: Int = self.stringforvalue.distance(from: self.stringforvalue.startIndex, to: rangeforIndivPrice.lowerBound)
                                incrematorforIndivPrice = indexforIndivPrice + 4
                                var toCheckIfcontained = ""
                                var toCheckIfItemWasParsed = 0
                                var firstItemScrewUp = true
                                
                                print(self.stringforvalue)
            
                                for item in self.ArrayForIngredients
                                {
                                    print("Ingredient:\(item)")
                                    
                                    self.LabelForInsertingIngredients = UILabel()
                                    self.LabelforInsertingCost = UILabel()
            
                                    self.LabelForInsertingIngredients.textColor = UIColor.gray
                                    self.LabelforInsertingCost.textColor = UIColor.gray
                                    
        
            
                                    toCheckIfcontained = "\(self.ArrayforType[toCheckIfItemWasParsed])<br>"
                                    print("Containment check:\(toCheckIfcontained)")
                                    
                                    if self.stringforvalue.range(of: toCheckIfcontained) != nil || firstItemScrewUp == true {
            
                                        self.LabelForInsertingIngredients.text = item
            
                                        self.arrayForDisplayItems.append(self.LabelForInsertingIngredients)
            
                                        boolforIndivPrice = false
            
            
                                            if(self.stringforvalue[incrematorforIndivPrice] == "$")
                                                {
                                                        incrematorforIndivPrice += 1
                                                        while boolforIndivPrice == false
                                                        {
                                                                if(self.stringforvalue[incrematorforIndivPrice] != "<")
                                                                {
                                                                        stringforIndivPrice = stringforIndivPrice + self.stringforvalue[incrematorforIndivPrice]
                                                                        incrematorforIndivPrice = incrematorforIndivPrice + 1
                                                                }
                                                                else
                                                                {
                                                                    boolforIndivPrice = true
                                                                    self.LabelforInsertingCost.text = "$\(stringforIndivPrice)"
                                                                    let IndivPriceConvertedIntoDouble = Double(stringforIndivPrice)
                                                                    let roundedIndivPrice = round(100 * IndivPriceConvertedIntoDouble!) / 100
                                                                    self.Price += roundedIndivPrice
                                                                    print("INDIVPRICE:\(roundedIndivPrice)")
                                                                    self.arrayforCost.append(roundedIndivPrice)
                                                                    self.arrayforDisplayingCost.append(self.LabelforInsertingCost)
                                                                    self.StackViewForCost.addArrangedSubview(self.LabelforInsertingCost)
                                                                    print("inserted:\(item)")
                                                                    self.StackViewForIngredients.addArrangedSubview(self.LabelForInsertingIngredients)
                                                                    var deleteButton = UIButton()
                                                                    deleteButton.setTitle("x", for: UIControl.State.normal)
                                                                    deleteButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
                                                                    deleteButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
                                                                    deleteButton.addTarget(self, action: "removeFromStackView:", for: UIControl.Event.touchUpInside)
                                                                    deleteButton.tag = self.buttonTag
                                                                    print("\(item):\(self.buttonTag)")
                                                                    self.buttonTag = self.buttonTag + 1
                                                                    self.arrayForDeleteButtons.append(deleteButton)
                                                                    self.StackViewForDeleteButtons.addArrangedSubview(deleteButton)
                                                                }
                                                    }
                                        }
                                        incrematorforIndivPrice += 4
                                        print(stringforIndivPrice)
            
                                    }
                                    stringforIndivPrice = ""
                                    toCheckIfItemWasParsed = toCheckIfItemWasParsed + 1
                            }
            
                            let serviceCharge = (round(100 * (self.Price * 0.14))  / 100) + 2.00
            
                            self.ServicePrice.text = "$\(String(format: "%.2f", serviceCharge))"
            
    
            
                            self.Price += serviceCharge
                            self.Price = round(1000.0 * self.Price) / 1000.0
            
                            self.PriceTextinOrderView.text = "Price: $\(String(format: "%.2f", self.Price))"
                            print(self.Price)
                            self.ActivitySpinner.isHidden = true
                            self.LoaderView.isHidden = true
                            self.grayView.isHidden = true
                            self.ConfirmButton.isHidden = true
                            self.StepperOutlet.isHidden = true
                            self.ServingsLabel.isHidden = true
            
                                if !UIAccessibility.isReduceTransparencyEnabled {
                                self.view.backgroundColor = UIColor.clear
                                //always fill the view
                                self.blurEffectView.frame = self.view.bounds
                                //CGRect.init(x: 0, y: 86, width: self.WebView.frame.width, height: self.WebView.frame.height)
                                self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            
                                UIView.transition(with: self.Masterview,
                                                  duration: 0.5,
                                    options: .transitionCrossDissolve,
                                    animations: {
                                        self.view.addSubview(self.blurEffectView)
                                        
                    
                                })
                                    self.view.addSubview(self.OrderView)
                                    self.OrderView.addSubview(self.PaynowButton)
                                    self.OrderView.layoutIfNeeded()
                                    self.PaynowButton.clipsToBounds = true
                                    self.PaynowButton.layer.cornerRadius = 10
                                    self.OrderView.addSubview(self.ServingsLabel)
                                    self.ServingsLabel.clipsToBounds = true
                                    
                                    self.blurEffectView.removeGestureRecognizer(removedgesture)
                                    let gesture = UITapGestureRecognizer(target: self, action: "resetValues:")
                                    self.blurEffectView.addGestureRecognizer(gesture)
                                
                                if(self.FirstTimeOn == false && self.MessageDismissedfor50 != false)
                                {
                                    let FirstTimePromo = UIAlertController(title: "50% Off", message: "Apply the code FOOGLEFIRST in the \"Add Other or Missing\" text field on the top left corner of this page for 50% off.", preferredStyle: UIAlertController.Style.alert)
                                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in


                                        FirstTimePromo.dismiss(animated: false, completion: nil)

                                    }
                                    let DismissAction = UIAlertAction(title: "DISMISS", style: .default) { (action) in
                                        UserDefaults.standard.set(false, forKey: "MessageDismissedfor50")
                                        self.MessageDismissedfor50 =  UserDefaults.standard.bool(forKey: "FirstTimeOn")

                                        FirstTimePromo.dismiss(animated: false, completion: nil)

                                    }
                                    FirstTimePromo.addAction(cancelAction)
                                    FirstTimePromo.addAction(DismissAction)




                                    self.present(FirstTimePromo, animated: true, completion: nil)
                                }
            
                            } else {
                                self.view.backgroundColor = UIColor.black
                            }
                            if(ViewController.modelName == "iPhone 5" || ViewController.modelName == "iPhone 5c"
                                || ViewController.modelName == "iPhone 5s" || ViewController.modelName == "iPhone SE" )
                            {
                                self.OrderView.frame = CGRect.init(x: 9, y: 600, width: 303, height: 498)
                            }
                            else if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus")
                            {
                                self.OrderView.frame = CGRect.init(x: 11, y: 900, width: 390, height: 666)
                            }
                            else if(ViewController.isIpad)
                            {
                                self.OrderView.frame = CGRect.init(x: 9, y: 900, width: 303, height: 666)

                            }
                            
            
                            if(!(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus") && ViewController.isIpad == false)
                            {
                                let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                UIView.animate(withDuration: 0.75, animations: {
                                    self.OrderView.frame.origin.y = 70
                                
                                })
                                }
                            }
                            else if (ViewController.isIpad)
                            {
                                let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    UIView.animate(withDuration: 1, animations: {
                                        self.OrderView.frame.origin.y = 40
                                        
                                    })
                                }
                            }
                            else if(ViewController.modelName == "iPhone 7 Plus" || ViewController.modelName == "iPhone 6s Plus" || ViewController.modelName == "iPhone 6 Plus" || ViewController.modelName == "iPhone 8 Plus")
                            {
                                let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    UIView.animate(withDuration: 0.75, animations: {
                                        self.OrderView.frame.origin.y = 60
                                        
                                    })
                                }
                            }
                            else
                            {
                                let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                UIView.animate(withDuration: 1, animations: {
                                    self.OrderView.frame.origin.y = 53
                                    
                                })
                                }
                            }
                            if(ViewController.modelName == "iPhone X" || ViewController.modelName == "iPhone XS" || ViewController.modelName == "Simulator")
                            {
                                let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    UIView.animate(withDuration: 1, animations: {
                                        self.OrderView.frame.origin.y = 110
                                        
                                    })
                                }
                            }
                            if(ViewController.modelName == "iPhone XS Max" || ViewController.modelName == "iPhone XR")
                            {
                                
                                    let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        UIView.animate(withDuration: 1, animations: {
                                            self.OrderView.frame.origin.y = 110
                                            
                                        })
                                    }
                                
                            }
            
            
                            self.newPriceString = ""
                            self.boolForSubstring = false
                            self.NextQoute = false
                            self.incremetor = 0
                            self.UrlBeforeSent = ""
                            
                        }
                        
                        //print("CHECK in Ingred: \(self.toCheckIfAPIisReady())")
                    })
                    booleanToFindPrice = false
            
                  }
                  if(boolToFindPriceFromTextArea)
                  {
                    let convertedtextfieldtext = TextFieldToEnterMore.text as! String
                    
                    if(TextFieldToEnterMore.text == "FOOGLEFIRST" && self.FirstTimeOn == false)
                    {
                        let FirstTimePromo = UIAlertController(title: "Congrats!", message: "This Order is now 50% off! If you decide that this Order is not your first order, you can still use this code.", preferredStyle: UIAlertController.Style.alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                            self.Price = self.Price/2
                            self.Price = round(100.0 * self.Price) / 100.0
                            self.PriceTextinOrderView.text = "Price: $\(self.Price)"
                            self.PriceTextinOrderView.isHidden = false
                            self.ActivityIndicatorforPriceLabel.isHidden = true
                            self.ActivityIndicatorForTextField.isHidden = true
                            self.TextFieldToEnterMore.text = ""
                            
                            FirstTimePromo.dismiss(animated: false, completion: nil)
                            
                        }
                        FirstTimePromo.addAction(cancelAction)
                        
                        
                        self.present(FirstTimePromo, animated: true, completion: nil)
                    }
                    else if(TextFieldToEnterMore.text != "")
                    {
                    var stringforvalue = ""
                    var newPriceString = ""
                    var incremetor = 0
                    var boolforSubstring = false
                    
                    self.webViewforData.evaluateJavaScript("document.getElementsByTagName('body')[0].innerHTML", completionHandler: { (value, error) in
                        //print(value)
                        stringforvalue = value as! String
                        print(stringforvalue)
                        
                        if stringforvalue.range(of:"price:") != nil{
                            
                            let range: Range<String.Index> = stringforvalue.range(of: "Cost per Serving: $")!
                            let index: Int =  stringforvalue.distance(from: stringforvalue.startIndex, to: range.lowerBound)
                            incremetor = index + 19
                            
                            
                            while boolforSubstring == false
                            {
                                if(stringforvalue[incremetor] != "<")
                                {
                                    newPriceString = newPriceString + stringforvalue[incremetor]
                                    print(newPriceString)
                                    incremetor = incremetor + 1
                                }
                                else
                                {
                                    
                                    let labelforInsertingintoPrice = UILabel()
                                    labelforInsertingintoPrice.text = "$\(newPriceString)"
                                    labelforInsertingintoPrice.textColor = UIColor.gray
                                    self.StackViewForCost.addArrangedSubview(labelforInsertingintoPrice)
                                    self.arrayforDisplayingCost.append(labelforInsertingintoPrice)
                                    
                                    let labelForInsertingintoIngredients = UILabel()
                                    labelForInsertingintoIngredients.text = convertedtextfieldtext
                                    labelForInsertingintoIngredients.textColor = UIColor.gray
                                    self.StackViewForIngredients.addArrangedSubview(labelForInsertingintoIngredients)
                                    self.arrayForDisplayItems.append(labelForInsertingintoIngredients)
                                    
                                    let deleteButton = UIButton()
                                    deleteButton.setTitle("x", for: UIControl.State.normal)
                                    deleteButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
                                    deleteButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
                                    deleteButton.addTarget(self, action: "removeFromStackView:", for: UIControl.Event.touchUpInside)
                                    deleteButton.tag = self.buttonTag
                                    print("\(self.buttonTag)")
                                    self.buttonTag = self.buttonTag + 1
                                    self.arrayForDeleteButtons.append(deleteButton)
                                    self.StackViewForDeleteButtons.addArrangedSubview(deleteButton)
                                    
                                    let DoublefornewPriceString = Double(newPriceString)
                                    let roundedDoublefornewPriceString = round(100 * DoublefornewPriceString!) / 100
                                    self.Price = roundedDoublefornewPriceString + self.Price
                                    
                                    self.arrayforCost.append(roundedDoublefornewPriceString)
                                    self.PriceTextinOrderView.text = "Price: $\(String(format: "%.2f", self.Price))"
                                    
                                    self.PriceTextinOrderView.isHidden = false
                                    self.ActivityIndicatorforPriceLabel.isHidden = true
                                    self.ActivityIndicatorForTextField.isHidden = true
                                    self.TextFieldToEnterMore.text = ""
                                    boolforSubstring = true
                                }
                            }
                            
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Sorry", message: "The Ingredient you entered did not yield a price.", preferredStyle: UIAlertController.Style.alert)
                            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                                self.ActivityIndicatorForTextField.isHidden = true
                                self.TextFieldToEnterMore.text = ""
                                self.ActivityIndicatorforPriceLabel.isHidden = true
                                self.PriceTextinOrderView.isHidden = false
                            }
                            alert.addAction(cancelAction)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    })
                    
                  }
                    boolToFindPriceFromTextArea = false
        }
        
        // now use the name and token as you see fit!
    }

    
    @objc func resetValues(_ sender:UITapGestureRecognizer){
        self.InitialServings = true
        UIView.animate(withDuration: 0.75, animations: {
            self.OrderView.frame.origin.y = self.Masterview.frame.origin.y + self.Masterview.frame.size.height
            
        })
        let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.transition(with: self.Masterview, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.blurEffectView.removeFromSuperview()
                
                  for i in 0 ... self.arrayForDisplayItems.count - 1
                {
                   self.arrayForDisplayItems[i].removeFromSuperview()
                }
                
                for i in 0 ... self.arrayForDeleteButtons.count - 1
                {
                  self.arrayForDeleteButtons[i].removeFromSuperview()
                }
                
                for i in 0 ... self.arrayforDisplayingCost.count - 1
                {
                   self.arrayforDisplayingCost[i].removeFromSuperview()
                }
                   self.arrayForDisplayItems = [UILabel]()
                   self.arrayforDisplayingCost = [UILabel]()
                   self.ArrayForIngredients = [String]()
                   self.ArrayforType = [String]()
                   self.arrayforCost = [Double]()
                   self.buttonTag = 0
                   self.Price = 0.0
                   self.ConfirmButton.isHidden = true
                   self.PaynowButton.isHidden = false
            

            })
            
            
        }
        
    }
    
    @objc func resetvaluesForNutrition(_ sender:UITapGestureRecognizer)
    {
        print("CLICKED")
        UIView.animate(withDuration: 0.75, animations: {
            self.webViewforData.frame.origin.y = -900
            
        })
        let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.transition(with: self.Masterview, duration: 0.5, options: .transitionCrossDissolve, animations: {
                 self.blurEffectView.removeFromSuperview()
                 self.webViewforData.removeFromSuperview()
            })
        }
    }
    

    typealias Rational = (num : Int, den : Int)

    func rationalApproximation(of x0 : Double, withPrecision eps : Double = 1.0E-6) -> Rational {
        var x = x0
        var a = x.rounded(.down)
        
        var (h1, k1, h, k) = (1, 0, Int(a), 1)

        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = x.rounded(.down)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        return (h, k)
    }
    
    func reducedfraction(num: Int, den: Int) -> Rational
    {
        var newFraction = Float(num) / Float(den)
        var doubleForReturn = Double(newFraction)
        
        return rationalApproximation(of: doubleForReturn)
        
    }
    
    
    
    @IBAction func onSettingsPress(_ sender: Any) {
        print(self.Price)
        performSegue(withIdentifier: "SegueToSettings", sender: self)
    }
    
    @objc func removeFromStackView(_ sender:UIButton)
    {
        
        for i in 0 ... self.arrayForDeleteButtons.count - 1
        {
          if(sender.tag == i)
          {
            sender.removeTarget(self, action: "addBackToStackView:", for: UIControl.Event.touchUpInside)
            let attributedString = NSMutableAttributedString(attributedString: self.arrayForDisplayItems[i].attributedText!)
            
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributedString.length))
            
            self.arrayForDisplayItems[i].attributedText = attributedString
            self.arrayForDisplayItems[i].accessibilityHint = "removed"
            
            let attributedStringforCost = NSMutableAttributedString(string: self.arrayforDisplayingCost[i].text!)
            attributedStringforCost.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedStringforCost.length))
            attributedStringforCost.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributedStringforCost.length))
            
            self.arrayforDisplayingCost[i].attributedText = attributedStringforCost
            self.arrayforDisplayingCost[i].accessibilityHint = "removed"
            
            print("\(self.Price) - \(self.arrayforCost[i])")
            
            self.Price = self.Price - self.arrayforCost[i]
            let roundedSelfPrice = round(100 * self.Price) / 100
            let absofroundedSelfPrice = abs(roundedSelfPrice)
            self.PriceTextinOrderView.text = "Price: $\(String(format: "%.2f", absofroundedSelfPrice))"

            sender.setTitle("+", for: UIControl.State.normal)
            sender.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            sender.addTarget(self, action: "addBackToStackView:", for: UIControl.Event.touchUpInside)
          }
        }
    }
    
    @objc func addBackToStackView(_ sender:UIButton)
    {
        for i in 0 ... self.arrayForDeleteButtons.count - 1
        {
            if(sender.tag == i)
            {
                sender.removeTarget(self, action: "removeFromStackView", for: UIControl.Event.touchUpInside)
                let originalString = NSMutableAttributedString(string: self.arrayForDisplayItems[i].text!)
                self.arrayForDisplayItems[i].attributedText = originalString
                self.arrayForDisplayItems[i].accessibilityHint = "added"
                
                let originalStringForCost = NSMutableAttributedString(string: self.arrayforDisplayingCost[i].text!)
                self.arrayforDisplayingCost[i].attributedText = originalStringForCost
                self.arrayforDisplayingCost[i].accessibilityHint = "added"
                
                print("\(self.Price) + \(self.arrayforCost[i])")
                self.Price = self.Price + self.arrayforCost[i]
                let roundedSelfPrice = round(100 * self.Price) / 100
                let absofroundedSelfPrice = abs(roundedSelfPrice)
                
                self.PriceTextinOrderView.text = "Price: $\(String(format: "%.2f", absofroundedSelfPrice))"
                
                sender.setTitle("x", for: UIControl.State.normal)
                sender.setTitleColor(UIColor.red, for: UIControl.State.normal)
                sender.addTarget(self, action: "removeFromStackView:", for: UIControl.Event.touchUpInside)

            }
        }
    }
    
    
    @IBAction func OnBackPress(_ sender: Any) {
        currentURL = (WebView.request?.url?.absoluteString)!

       if(WebView.canGoBack)
       {
          WebView.goBack()
       }
    }
    
    
    @IBAction func OnForwardPress(_ sender: Any) {
        currentURL = (WebView.request?.url?.absoluteString)!

        if(WebView.canGoForward)
        {
           WebView.goForward()
        }
    }
    
    @IBAction func OnNutritionPress(_ sender: Any) {
        
        var textFieldEmpty = false
        
        let ServingsReciever = UIAlertController(title: "Servings", message: "Please choose the amount of servings. The nutrition will display according to the amount of servings.", preferredStyle: UIAlertController.Style.alert)
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            textField.keyboardType = UIKeyboardType.numberPad
            print("generating the TextField")
            textField.placeholder = "Enter Servings"
            tField = textField
        }

        ServingsReciever.addTextField(configurationHandler: configurationTextField)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            if(tField.text != "")
            {
                self.FindIngredients(Servings: Int(tField.text!)!, AlsoFindNutrition: true)
            }
            else
            {
                let RedoReciever = UIAlertController(title: "Error", message: "Please chose the amount of servings you want.", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    RedoReciever.dismiss(animated: false, completion: nil)
                    
                }
                RedoReciever.addAction(okAction)
                
                self.present(RedoReciever, animated: true, completion: nil)
            }
            ServingsReciever.dismiss(animated: false, completion: nil)
        }
        ServingsReciever.addAction(cancelAction)
        
        
        self.present(ServingsReciever, animated: true, completion: nil)
        
    }
    
    @IBAction func ServingsStepper(_ sender: UIStepper) {
        if(self.isIphone5)
        {
            self.ServingsLabel.text = "SER: \(Int(sender.value).description)"

        }
        else
        {
            self.ServingsLabel.text = "Servings: \(Int(sender.value).description)"

        }
        self.PaynowButton.isHidden = true
        self.ConfirmButton.isHidden = false
        
    }
    
    @IBAction func OnConfirmPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.OrderView.frame.origin.y = self.Masterview.frame.origin.y + self.Masterview.frame.size.height
            
        })
        let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
        self.blurEffectView.removeFromSuperview()
            
        for i in 0 ... self.arrayForDisplayItems.count - 1
        {
            self.arrayForDisplayItems[i].removeFromSuperview()
        }
        
        for i in 0 ... self.arrayForDeleteButtons.count - 1
        {
            self.arrayForDeleteButtons[i].removeFromSuperview()
        }
        
        for i in 0 ... self.arrayforDisplayingCost.count - 1
        {
            self.arrayforDisplayingCost[i].removeFromSuperview()
        }
        self.arrayForDisplayItems = [UILabel]()
        self.arrayforDisplayingCost = [UILabel]()
        self.ArrayForIngredients = [String]()
        self.ArrayforType = [String]()
        self.arrayforCost = [Double]()
        self.buttonTag = 0
        self.Price = 0.0
        self.PaynowButton.isHidden = false
        self.ConfirmButton.isHidden = true
        print(self.StepperOutlet.value)
        self.grayView.isHidden = false
        self.LoaderView.isHidden = false
        self.ActivitySpinner.isHidden = false
        self.FindIngredients(Servings: Int(self.StepperOutlet.value), AlsoFindNutrition: false)

            
        }
        
    }
    
    func initiatePayPalController()
    {
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
                
        let nameFromSearchBartext = SearchBar.text as! String
        let priceFromLabel = String(round(100 * self.Price) / 100)
        
        
        // Optional: include multiple items
        let item1 = PayPalItem(name: "Base Item + Service Charge", withQuantity: 1, withPrice: NSDecimalNumber(string: priceFromLabel), withCurrency: "USD", withSku: "Meal")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: self.titleOfRecipe, intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self as! PayPalPaymentDelegate)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }

    }
    
    override func viewDidAppear(_ conditionforShippingAddressIsFulfilled: Bool) {
        
        if let shippingSetup = UserDefaults.standard.object(forKey: "Shipping Setup") as? Bool
        {
          if(shippingSetup == true)
          {
            initiatePayPalController()
            UserDefaults.standard.set(false, forKey: "Shipping Setup")
          }
        }
    

    }
    
    
    
    @IBAction func OnPayPress(_ sender: Any) {
        resultText = ""
        if let shippingSetup = UserDefaults.standard.object(forKey: "Shipping Setup") as? Bool
        {
            initiatePayPalController()
        }
        else
        {
            performSegue(withIdentifier: "ViewControllerForShippingInfo", sender: self)
        }
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            self.resultText = completedPayment.description
            ViewController.IngredientsArrayForMySQLtransfer = self.arrayForDisplayItems
            ViewController.CostsArrayForMySQLtransfer = self.arrayforDisplayingCost
            ViewController.OriginalIngredientsArrayForMySQLtransfer = self.ArrayForIngredients
            ViewController.OriginalCostsArrayForMySQLtransfer = self.arrayforCost
            UserDefaults.standard.set(true, forKey: "FirstTimeOn")
            self.FirstTimeOn =  UserDefaults.standard.bool(forKey: "FirstTimeOn")
            
            self.performSegue(withIdentifier: "SegueToOrderInfo", sender: self)
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
