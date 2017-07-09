//
//  ViewController.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/8/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate, UISearchBarDelegate, UITextFieldDelegate{

    @IBOutlet var WebView: UIWebView!
    var currentURL:String = ""
    let webViewforData = WKWebView()
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
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    var LabelForInsertingIngredients = UILabel()
    let grayView = UIView()
    var arrayForDisplayItems = [UILabel]()
    var LabelforInsertingCost = UILabel()
    var ArrayforType = [String]()
    var arrayforDisplayingCost = [UILabel]()
    var arrayForDeleteButtons = [UIButton]()
    var servingsstring = ""
    var deleteButtonImage = UIImage(named: "MinusSign")
    var addButtonImage = UIImage(named: "PlusSign")
    let toolbar = UIToolbar()
    var buttonTag = 0
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Orderbutton.layer.cornerRadius = 10
        SearchBar.text = ""
        ActivityIndicatorForTextField.isHidden = true
        ActivityIndicatorForTextField.startAnimating()
        TextFieldToEnterMore.delegate = self
        TextFieldToEnterMore.placeholder = "Add Other or Missing"
        ActivityIndicatorforPriceLabel.isHidden = true
        ActivityIndicatorforPriceLabel.startAnimating()
        TextFieldToEnterMore.returnKeyType = UIReturnKeyType.done
        
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        SearchBar.spellCheckingType = .yes
        SearchBar.autocorrectionType = .yes
        
        TextFieldToEnterMore.inputAccessoryView = toolbar
        
//        let url = URL(string: "https://www.google.com")
//
//        let request = URLRequest(url: url!)
//        
//        WebView.loadRequest(request)
        //WebView.isHidden = true
        
        webViewforData.navigationDelegate = self
        SearchBar.delegate = self
        WebView.delegate = self
        //SmallSearchRecipes.isHidden = true
        
        self.OrderView.frame.origin.y = 667
        OrderView.layer.cornerRadius = 10
        //PaynowButton.layer.cornerRadius = 10
        
        ActivitySpinner.isHidden = true
        ActivitySpinner.startAnimating()
        LoaderView.isHidden = true
        LoaderView.layer.cornerRadius = 10
        //LoaderView.addBlurEffect()
        Orderbutton.isHidden = true
        
        
        //grayView.isHidden = true
        self.grayView.frame = self.view.bounds
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(grayView)
        self.grayView.addSubview(LoaderView)
        self.grayView.isHidden = true
        self.ActivityIndicatorforWeb.isHidden = true
        self.ActivityIndicatorforWeb.startAnimating()
        //StackViewForIngredients.removeFromSuperview()

    }
    
    func doneClicked(){
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if(textField.text != "")
        {
        ActivityIndicatorForTextField.isHidden = false
        PriceTextinOrderView.isHidden = true
        ActivityIndicatorforPriceLabel.isHidden = false
        let convertedtextfieldtext = textField.text as! String
        
        let Url = "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(convertedtextfieldtext)"
        print(Url)
        var stringforvalue = ""
        var newPriceString = ""
        var incremetor = 0
        var boolforSubstring = false
        
        let urlSet = CharacterSet.urlQueryAllowed
            .union(CharacterSet.punctuationCharacters)
        
        let UrlBeforeSent = Url.addingPercentEncoding(withAllowedCharacters: urlSet)!
        print(UrlBeforeSent)
        
        let foodPriceUrl = URL(string: UrlBeforeSent)
        let requestforPrice = URLRequest(url: foodPriceUrl!)
        self.webViewforData.load(requestforPrice)
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.webViewforData.evaluateJavaScript("document.getElementsByTagName('body')[0].innerHTML", completionHandler: { (value, error) in
                //print(value)
                stringforvalue = value as! String
                print(stringforvalue)
                
                if stringforvalue.range(of:"price:") != nil{
                    print("hi")
                    
                    
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
                            var labelForInsertingintoIngredients = UILabel()
                            labelForInsertingintoIngredients.text = convertedtextfieldtext
                            labelForInsertingintoIngredients.textColor = UIColor.gray
                            self.StackViewForIngredients.addArrangedSubview(labelForInsertingintoIngredients)
                            self.arrayForDisplayItems.append(labelForInsertingintoIngredients)
                            
                            var labelforInsertingintoPrice = UILabel()
                            labelforInsertingintoPrice.text = "$\(newPriceString)"
                            self.arrayForDisplayItems.append(labelforInsertingintoPrice)
                            
                            labelforInsertingintoPrice.textColor = UIColor.gray
                            self.StackViewForCost.addArrangedSubview(labelforInsertingintoPrice)
                            
                            var deleteButton = UIButton()
                            deleteButton.setTitle("-", for: UIControlState.normal)
                            deleteButton.setTitleColor(UIColor.red, for: UIControlState.normal)
                            deleteButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
                            deleteButton.addTarget(self, action: "removeFromStackView:", for: UIControlEvents.touchUpInside)
                            self.buttonTag = self.buttonTag + 1
                            deleteButton.tag = self.buttonTag
                            self.arrayForDeleteButtons.append(deleteButton)
                            self.StackViewForDeleteButtons.addArrangedSubview(deleteButton)
                            
                            var DoublefornewPriceString = Double(newPriceString)
                            var newtotalPrice = DoublefornewPriceString! + self.Price
                            self.Price = newtotalPrice
                            
                            self.PriceTextinOrderView.text = "Price: $\(newtotalPrice)"
                            
                            self.PriceTextinOrderView.isHidden = false
                            self.ActivityIndicatorforPriceLabel.isHidden = true
                            self.ActivityIndicatorForTextField.isHidden = true
                            textField.text = ""
                            boolforSubstring = true
                        }
                    }
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Sorry", message: "The Ingredient you entered did not yield a price.", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        self.ActivityIndicatorForTextField.isHidden = true
                        textField.text = ""
                        self.ActivityIndicatorforPriceLabel.isHidden = true
                        self.PriceTextinOrderView.isHidden = false
                    }
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            })
        }
        }
        

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
    }
    
    

    
    func checkArrowStatus()
    {
        if(WebView.canGoBack == true)
        {
            
            UIWebView.transition(with: self.BackArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.BackArrow.setImage(self.CanGoBack, for: UIControlState.normal)
            },
                              completion: nil)
        }
        
        if(WebView.canGoForward == true)
        {
            
            UIWebView.transition(with: self.ForwardArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.ForwardArrow.setImage(self.canGoForward, for: UIControlState.normal)
            },
                              completion: nil)
        }
        if(WebView.canGoBack == false)
        {
            
            UIWebView.transition(with: self.BackArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.BackArrow.setImage(self.CantGoBack, for: UIControlState.normal)
            },
                              completion: nil)
        }
        
        if(WebView.canGoForward == false)
        {
            
            UIWebView.transition(with: self.ForwardArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.ForwardArrow.setImage(self.cantGoForward, for: UIControlState.normal)
            },
                              completion: nil)
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
            ActivityIndicatorforWeb.isHidden = true
            checkArrowStatus()
        
            SearchBar.inputAccessoryView = toolbar
        
            let currenturl = (WebView.request?.url?.absoluteString)!
            print(currenturl)
        
            FoogleImageView.isHidden = true
            let newFrameForSearchBar = CGRect.init(x: 0, y: 60, width: SearchBar.layer.frame.width, height: SearchBar.layer.frame.height)
            SearchBar.frame = newFrameForSearchBar
            FoogleLogo.isHidden = true
        
            Orderbutton.isHidden = false
    }
    
    
    
    
    func FindIngredientPrice(Ingredient: String){
        
        //print("http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)")

        self.UrlBeforeSent = "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)"
        //print(self.UrlBeforeSent)
        
        let urlSet = CharacterSet.urlQueryAllowed
            .union(CharacterSet.punctuationCharacters)
        
        self.UrlBeforeSent = self.UrlBeforeSent.addingPercentEncoding(withAllowedCharacters: urlSet)!
        //print(self.UrlBeforeSent)
        
        let foodPriceUrl = URL(string: self.UrlBeforeSent)
        print ("ravi....\(foodPriceUrl)")
        let requestforPrice = URLRequest(url: foodPriceUrl!)
        self.webViewforData.load(requestforPrice)
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
        
        self.webViewforData.evaluateJavaScript("document.getElementsByTagName('body')[0].innerHTML", completionHandler: { (value, error) in
            //print(value)
            self.stringforvalue = value as! String
            print(self.stringforvalue)
            var stringforIndivPrice = ""
            var boolforIndivPrice = false
            var incrematorforIndivPrice = 0
            
            if self.stringforvalue.range(of:"price:") != nil{
            
                
                let range: Range<String.Index> = self.stringforvalue.range(of: "Cost per Serving: $")!
                let index: Int = self.stringforvalue.distance(from: self.stringforvalue.startIndex, to: range.lowerBound)
                self.incremetor = index + 19
                
                
                while self.boolForSubstring == false
                {
                    if(self.stringforvalue[self.incremetor] != "<")
                    {
                        self.newPriceString = self.newPriceString + self.stringforvalue[self.incremetor]
                        self.incremetor = self.incremetor + 1
                    }
                    else
                    {
                         self.boolForSubstring = true
                    }
                }
                //self.ActivitySpinner.stopAnimating()
                self.Price = Double(self.newPriceString)!
                print(self.Price)
                
                self.PriceTextinOrderView.text = "Price: $\(self.newPriceString)"
                self.ActivitySpinner.isHidden = true
                self.LoaderView.isHidden = true
                self.grayView.isHidden = true
                
                //self.OrderView.addSubview(self.StackViewForIngredients)
                let rangeforIndivPrice: Range<String.Index> = self.stringforvalue.range(of: "<br>$")!
                let indexforIndivPrice: Int = self.stringforvalue.distance(from: self.stringforvalue.startIndex, to: rangeforIndivPrice.lowerBound)
                incrematorforIndivPrice = indexforIndivPrice + 4
                var toCheckIfcontained = ""
                var toCheckIfItemWasParsed = 0
                
                print(self.stringforvalue)
                
                for item in self.ArrayForIngredients
                {
                    self.LabelForInsertingIngredients = UILabel()
                    self.LabelforInsertingCost = UILabel()
                    
                    self.LabelForInsertingIngredients.textColor = UIColor.gray
                    self.LabelforInsertingCost.textColor = UIColor.gray
                    
                    toCheckIfcontained = "\(self.ArrayforType[toCheckIfItemWasParsed])<br>"
                    print("\(self.ArrayforType[toCheckIfItemWasParsed])<br>")
                    if self.stringforvalue.range(of: toCheckIfcontained) != nil {
                        
                        self.LabelForInsertingIngredients.text = item
                    
                        self.arrayForDisplayItems.append(self.LabelForInsertingIngredients)
                    }
                    boolforIndivPrice = false
                        
                    
                    
                   if(self.stringforvalue[incrematorforIndivPrice] == "$")
                   {
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
                        }
                    }
                    }
                    incrematorforIndivPrice += 4
                    print(stringforIndivPrice)
                    self.LabelforInsertingCost.text = stringforIndivPrice
                    self.arrayforDisplayingCost.append(self.LabelforInsertingCost)
                    self.StackViewForCost.addArrangedSubview(self.LabelforInsertingCost)
                    
                    
                    
                    if self.stringforvalue.range(of: toCheckIfcontained) != nil {
                        print("inserted:\(item)")
                        self.StackViewForIngredients.addArrangedSubview(self.LabelForInsertingIngredients)
                        var deleteButton = UIButton()
                        deleteButton.setTitle("-", for: UIControlState.normal)
                        deleteButton.setTitleColor(UIColor.red, for: UIControlState.normal)
                        deleteButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
                        deleteButton.addTarget(self, action: "removeFromStackView:", for: UIControlEvents.touchUpInside)
                        deleteButton.tag = self.buttonTag
                        self.buttonTag = self.buttonTag + 1
                        self.arrayForDeleteButtons.append(deleteButton)
                        self.StackViewForDeleteButtons.addArrangedSubview(deleteButton)
                    }
                    stringforIndivPrice = ""
                    toCheckIfItemWasParsed = toCheckIfItemWasParsed + 1
                }
                
                //self.LabelForInsertingIngredients = UILabel()
                
                if !UIAccessibilityIsReduceTransparencyEnabled() {
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
                                        self.view.addSubview(self.OrderView)
                                        self.OrderView.addSubview(self.PaynowButton)
                                        self.OrderView.layoutIfNeeded()
                                        self.PaynowButton.clipsToBounds = true
                                        self.PaynowButton.layer.cornerRadius = 10
                                        self.OrderView.addSubview(self.ServingsLabel)
                                        self.ServingsLabel.clipsToBounds = true
                                })

                        
                } else {
                    self.view.backgroundColor = UIColor.black
                }
                
                
                let gesture = UITapGestureRecognizer(target: self, action: "someAction:")
                self.blurEffectView.addGestureRecognizer(gesture)
                

                
                UIView.animate(withDuration: 1, animations: {
                    self.OrderView.frame.origin.y = 70
                    
                })


                self.newPriceString = ""
                self.boolForSubstring = false
                self.NextQoute = false
                self.incremetor = 0
                self.UrlBeforeSent = ""
                
            }
            
        })
            
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Loaded")
    }

    @IBAction func OnOrderPress(_ sender: Any) {
        
        self.grayView.isHidden = false
        LoaderView.isHidden = false
        ActivitySpinner.isHidden = false
        var checkifrecipe = true
        
        
        currentURL = (WebView.request?.url?.absoluteString)!
        print(currentURL)
        ArrayForIngredients = [String]()
        
        let uRl = URL(string: "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/SERVER/index.php?url=" + currentURL)
        
        let task = URLSession.shared.dataTask(with: uRl!) { (data, response, error) in
            
            
            if error != nil {
                let alert = UIAlertController(title: "Uh-Oh!", message: "The Server is down right now.", preferredStyle: UIAlertControllerStyle.alert)
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
                        
                        if let servings = myJson["servings"] as? Int {
                            self.servingsstring = String(servings)
                            print("SERVINGS:\(self.servingsstring)")
                        }
                        self.ServingsLabel.text = "Servings:\(self.servingsstring)"
                        print(self.ServingsLabel.text)
                        //self.servingsstring = ""
                        
                        if let status = myJson["status"] as? String {
                            if(status == "failure")
                            {
                                let alert = UIAlertController(title: "Error", message: "This recipe cannot be extracted.", preferredStyle: UIAlertControllerStyle.alert)
                                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                                    self.grayView.isHidden = true
                                }
                                alert.addAction(cancelAction)
                                
                                self.present(alert, animated: true, completion: nil)

                            }
                        }
                        
                        if let Recipedifferentiater = myJson["text"] as? String
                        {
                        
                        if let stations = myJson["extendedIngredients"] as? [[String: AnyObject]] {
                            
                            for station in stations {
                                
                                if let name = station["originalString"] as? String{
                                    
//                                   let aisle = station["aisle"] as? String
//                                   
//                                    
//                                   if(aisle == "?")
//                                   {
//                                      print("This is not a recipe")
//                                      checkifrecipe = false
//                                    
//                                      let alert = UIAlertController(title: "Uh-Oh!", message: "This is not a recipe", preferredStyle: UIAlertControllerStyle.alert)
//                                      let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
//                                           self.grayView.isHidden = true
//                                      }
//                                      alert.addAction(cancelAction)
//                                    
//                                      self.present(alert, animated: true, completion: nil)
//                                      break
//                                   }
                                   var contructedstring = ""
                                    
                                   if let amount = station["amount"] as? Double
                                   {
                                      contructedstring = "\(amount)"
                                   }
                                   if let unitLong = station["unitLong"] as? String
                                   {
                                      contructedstring = contructedstring + " \(unitLong)"
                                   }
                                   if let name = station["name"] as? String
                                   {
                                      contructedstring = contructedstring + " \(name)"
                                      self.ArrayforType.append(name)
                                   }
                                
                                   print(contructedstring)
                                   self.ArrayForIngredients.append(contructedstring)
                                    
                                }
                                
                            }
                            }
                            
                        }
                        else
                        {
                            print("This is not a recipe")
                            checkifrecipe = false
                            
                            let alert = UIAlertController(title: "Uh-Oh!", message: "This is not a recipe", preferredStyle: UIAlertControllerStyle.alert)
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
                self.FindIngredientPrice(Ingredient: self.StringforIngredients)
                self.StringforIngredients = ""
            }
        }
        
        task.resume()
        
        
        

    }
    
    func someAction(_ sender:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.75, animations: {
            self.OrderView.frame.origin.y = self.Masterview.frame.origin.y + self.Masterview.frame.size.height
            
        })
        let when = DispatchTime.now() + 0.75 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.transition(with: self.Masterview,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
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
                                self.buttonTag = 0
            })
            
        }
        
    }
    
    
    
    @IBAction func onSettingsPress(_ sender: Any) {
        print(self.Price)
    }
    
    func removeFromStackView(_ sender:UIButton)
    {
        for i in 0 ... self.arrayForDeleteButtons.count - 1
        {
          if(sender.tag == i)
          {
            
            
            let attributedString = NSMutableAttributedString(string: self.arrayForDisplayItems[i].text!)
            
            attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.red, range: NSMakeRange(0, attributedString.length))
            
            self.arrayForDisplayItems[i].attributedText = attributedString
            
            let attributedStringforCost = NSMutableAttributedString(string: self.arrayforDisplayingCost[i].text!)
            attributedStringforCost.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedStringforCost.length))
            attributedStringforCost.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.red, range: NSMakeRange(0, attributedStringforCost.length))
            
            self.arrayforDisplayingCost[i].attributedText = attributedStringforCost
            //self.arrayforDisplayingCost[i].text = " "
            
            sender.setTitle("+", for: UIControlState.normal)
            sender.setTitleColor(UIColor.blue, for: UIControlState.normal)
            sender.addTarget(self, action: "addBackToStackView:", for: UIControlEvents.touchUpInside)
          }
        }
    }
    
    func addBackToStackView(_ sender:UIButton)
    {
        for i in 0 ... self.arrayForDeleteButtons.count - 1
        {
            if(sender.tag == i)
            {
                let originalString = NSMutableAttributedString(string: self.arrayForDisplayItems[i].text!)
                self.arrayForDisplayItems[i].attributedText = originalString
                
                let originalStringForCost = NSMutableAttributedString(string: self.arrayforDisplayingCost[i].text!)
                self.arrayforDisplayingCost[i].attributedText = originalStringForCost
                
                sender.setTitle("-", for: UIControlState.normal)
                sender.setTitleColor(UIColor.red, for: UIControlState.normal)
                sender.addTarget(self, action: "removeFromStackView:", for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    
    @IBAction func OnBackPress(_ sender: Any) {
        
       if(WebView.canGoBack)
       {
          WebView.goBack()
       }
    }
    
    
    @IBAction func OnForwardPress(_ sender: Any) {
        
        if(WebView.canGoForward)
        {
           WebView.goForward()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
