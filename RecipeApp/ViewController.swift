//
//  ViewController.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/8/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

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

    
    @IBOutlet var Orderbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Orderbutton.layer.cornerRadius = 10
        
        
        let url = URL(string: "https://www.google.com")

        let request = URLRequest(url: url!)
        
        WebView.loadRequest(request)
        
        webViewforData.navigationDelegate = self
        
    }
    
    
    
    
    func FindIngredientPrice(Ingredient: String){
        
        //print("http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)")

        self.UrlBeforeSent = "http://ec2-13-58-166-251.us-east-2.compute.amazonaws.com/test.html?Data=\(Ingredient)"
        //print(self.UrlBeforeSent)
        
        self.UrlBeforeSent = self.UrlBeforeSent.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(self.UrlBeforeSent)
        
        let foodPriceUrl = URL(string: self.UrlBeforeSent)

        let requestforPrice = URLRequest(url: foodPriceUrl!)
        self.webViewforData.load(requestforPrice)
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
        
        self.webViewforData.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (value, error) in
            //print(value)
            self.stringforvalue = value as! String
            
            if self.stringforvalue.range(of:"price:") != nil{
            
                
                let range: Range<String.Index> = self.stringforvalue.range(of: "price:")!
                let index: Int = self.stringforvalue.distance(from: self.stringforvalue.startIndex, to: range.lowerBound)
                self.incremetor = index
                
                
                while self.boolForSubstring == false
                {
                    if(self.stringforvalue[self.incremetor] != "\"")
                    {
                        self.incremetor = self.incremetor + 1
                    }
                    if(self.stringforvalue[self.incremetor] == "\"")
                    {
                        //self.newPriceString = self.newPriceString + self.stringforvalue[self.incremetor]
                        self.NextQoute = true
                        self.incremetor = self.incremetor + 2
                        
                        while self.boolForSubstring == false
                        {
                            
                            if(self.stringforvalue[self.incremetor] != "\"")
                            {
                                self.newPriceString = self.newPriceString + self.stringforvalue[self.incremetor]
                                self.incremetor = self.incremetor + 1
                            }
                            else
                            {
                                self.boolForSubstring = true
                            }
                        }
                    }
                }
                //self.Price = Double(self.newPriceString)!
                print(self.newPriceString)
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
                    self.StringforIngredients = "\(self.StringforIngredients) \(item)."
                    break
                }
                self.StringforIngredients = "\(self.StringforIngredients) \(item) |"
            }
            self.StringforIngredients = self.StringforIngredients.trimmingCharacters(in: .whitespacesAndNewlines)
            print(self.StringforIngredients)
            self.FindIngredientPrice(Ingredient: self.StringforIngredients)
            self.StringforIngredients = ""
            
        }
        
        task.resume()
        
        
        

    }
    
    
    @IBAction func OnBackPress(_ sender: Any) {
        WebView.goBack()
    }
    
    
    @IBAction func OnForwardPress(_ sender: Any) {
        WebView.goForward()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
