//
//  ViewController.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/8/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var WebView: UIWebView!
    var currentURL:String = ""
    
    @IBOutlet var Orderbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Orderbutton.layer.cornerRadius = 10
        
        
        let url = URL(string: "https://www.google.com")
        let request = URLRequest(url: url!)
        
        WebView.loadRequest(request)
        
        
    }

    @IBAction func OnOrderPress(_ sender: Any) {
    
        currentURL = (WebView.request?.url?.absoluteString)!
        print(currentURL)

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
