//
//  WeatherViewController.swift
//  GoodMorning
//
//  Created by Ben Sweett on 2014-12-17.
//  Copyright (c) 2014 Ben Sweett. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewController : UIViewController {
    
    var timer: NSTimer! = NSTimer()
    
    @IBOutlet var loadingIndicator : UIActivityIndicatorView! = nil
    @IBOutlet var loading : UILabel!
    @IBOutlet var nextViewButton: UIBarButtonItem!
    @IBOutlet var previousViewButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedLocationError:", name:"LocationError", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedWeatherError", name:"WeatherError", object: nil)
        
        //self.loadingIndicator.startAnimating()
    }

    override func viewDidAppear(animated: Bool) {
        // Set weather images and info from weather manager
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func receivedWeatherError(notification: NSNotification){
        self.loading.text = "Response from Weather API was invalid"
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("clearError"), userInfo: nil, repeats: false)
    }
    
    func receivedLocationError(notification: NSNotification){
        self.loading.text = "Cannot find your location"
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("clearError"), userInfo: nil, repeats: false)
    }
    
    func clearError() {
        self.loading.text = ""
        timer.invalidate()
        timer = nil
    }

}