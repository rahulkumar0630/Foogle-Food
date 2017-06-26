//
//  ViewController.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/8/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate {

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
    var NumberofTimesWebViewLoaded:Int = 0
    let CanGoBack = UIImage(named: "arrow_back_white_192x192")
    let canGoForward = UIImage(named: "arrow_forward_white_192x192")
    let CantGoBack = UIImage(named: "arrowBackWhenCantGoBack")
    let cantGoForward = UIImage(named: "arrowForwardWhenCantGoForward")
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))

    @IBOutlet var Masterview: UIView!
    @IBOutlet var Orderbutton: UIButton!
    @IBOutlet var SmallSearchRecipes: UILabel!
    @IBOutlet var BigSearchRecipes: UILabel!
    @IBOutlet var WhiteBar: UIImageView!
    @IBOutlet var BackArrow: UIButton!
    @IBOutlet var ForwardArrow: UIButton!
    @IBOutlet var OrderView: UIView!
    @IBOutlet var PriceTextinOrderView: UILabel!
    @IBOutlet var ActivitySpinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Orderbutton.layer.cornerRadius = 10
        
        
        let url = URL(string: "https://www.google.com")

        let request = URLRequest(url: url!)
        
        WebView.loadRequest(request)
        
        webViewforData.navigationDelegate = self
        WebView.delegate = self
        SmallSearchRecipes.isHidden = true
        
        self.OrderView.frame.origin.y = 667
        OrderView.layer.cornerRadius = 10
        
        ActivitySpinner.isHidden = true
        ActivitySpinner.scale(factor: 1.5)



        
    }
    
    @objc(webViewDidStartLoad:) func webViewDidStartLoad(_ webView: UIWebView)
    {
         NumberofTimesWebViewLoaded = NumberofTimesWebViewLoaded + 1
        
            if(NumberofTimesWebViewLoaded == 2)
            {
                var newFrame = CGRect.init(x: 0, y: 86, width: WebView.frame.width, height: WebView.frame.height + 31)
                WebView.frame = newFrame
                BigSearchRecipes.isHidden = true
                WhiteBar.isHidden = true
                SmallSearchRecipes.isHidden = false
            }
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
        
            checkArrowStatus()
    }
    
    
    
    func FindIngredientPrice(Ingredient: String){
        
        //print("http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)")

        self.UrlBeforeSent = "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)"
        //print(self.UrlBeforeSent)
        
        let urlSet = CharacterSet.urlQueryAllowed
            .union(CharacterSet.punctuationCharacters)
        
        self.UrlBeforeSent = self.UrlBeforeSent.addingPercentEncoding(withAllowedCharacters: urlSet)!
        print(self.UrlBeforeSent)
        
        let foodPriceUrl = URL(string: self.UrlBeforeSent)

        let requestforPrice = URLRequest(url: foodPriceUrl!)
        self.webViewforData.load(requestforPrice)
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
        
        self.webViewforData.evaluateJavaScript("document.getElementsByTagName('body')[0].innerHTML", completionHandler: { (value, error) in
            //print(value)
            self.stringforvalue = value as! String
            
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
                self.ActivitySpinner.stopAnimating()
                self.Price = Double(self.newPriceString)!
                print(self.Price)
                
                self.PriceTextinOrderView.text = "Price: \(self.newPriceString)"
                self.ActivitySpinner.removeFromSuperview()
                
                UIView.animate(withDuration: 0.6, animations: {
                    self.OrderView.frame.origin.y = 315
                    
                })


                
//                let alert = UIAlertController(title: "Price",
//                                              message: self.newPriceString,
//                                              preferredStyle: UIAlertControllerStyle.alert)
//                
//                let cancelAction = UIAlertAction(title: "OK",
//                                                 style: .cancel, handler: nil)
//                
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true)
//                
                
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
        
        //self.FindIngredientPrice(Ingredient: "3 pounds beef")
        
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
        self.view.backgroundColor = UIColor.clear
            //always fill the view
            blurEffectView.frame = self.view.bounds
                //CGRect.init(x: 0, y: 86, width: self.WebView.frame.width, height: self.WebView.frame.height)
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        UIView.transition(with: self.Masterview,
                             duration: 1,
                             options: .transitionCrossDissolve,
                             animations: {
            self.ActivitySpinner.isHidden = false
            self.ActivitySpinner.startAnimating()
            self.view.addSubview(self.blurEffectView)
            self.blurEffectView.addSubview(self.ActivitySpinner)
            self.view.addSubview(self.OrderView)
            
                                
            })
        } else {
            self.view.backgroundColor = UIColor.black
        }
    
        currentURL = (WebView.request?.url?.absoluteString)!
        print(currentURL)
        var ArrayForIngredients = [String]()
        
        let uRl = URL(string: "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/SERVER/index.php?url=" + currentURL)
        
        let task = URLSession.shared.dataTask(with: uRl!) { (data, response, error) in
            
            
            if error != nil {
                print("Error")
            }
            else {
                if let mydata = data {
                    do {
                        
                        let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
                        if let stations = myJson["extendedIngredients"] as? [[String: AnyObject]] {
                            
                            for station in stations {
                                
                                if let name = station["originalString"] as? String{
                                    
                                   let aisle = station["aisle"] as? String
                                   
                                    
                                   if(aisle == "?")
                                   {
                                      print("This is not a recipe")
                                      break
                                   }
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
                                   }
                                
                                   print(contructedstring)
                                   ArrayForIngredients.append(contructedstring)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    catch {
                        // catch error
                    }
                }
            }
            
            for item in ArrayForIngredients {
                
                if(item == ArrayForIngredients[ArrayForIngredients.count - 1])
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
        
        task.resume()
        
        
        

    }
    
    
    @IBAction func onSettingsPress(_ sender: Any) {
        print(self.Price)
        //print(self.OrderView.frame.origin.y)
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
    
    @IBAction func OnExitOrderPress(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.OrderView.frame.origin.y = self.Masterview.frame.origin.y + self.Masterview.frame.size.height
            
        })
        UIView.transition(with: self.Masterview,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                self.blurEffectView.removeFromSuperview()
                            
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
