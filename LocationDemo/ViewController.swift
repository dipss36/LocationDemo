//
//  ViewController.swift
//  LocationDemo
//
//  Created by SHRIDEVI SAWANT on 09/02/22.
//  Copyright © 2022 comviva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let lUtility = LocationUtility.instance
    
    @IBOutlet weak var infoL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startClicked(_ sender: Any) {
        if lUtility.startTracking() {
            print("Tracking Started")
            updateInfo()
        }
        else {
            print("Tracking not started..check permission")
        }
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        if lUtility.stopTracking() {
            print("Stopped tracking")
        }
        else {
            print("Could not stop")
        }
    }
    
    
    @IBAction func showMapClicked(_ sender: Any) {
        
        if let loc = lUtility.currentLocation {
            // launch map app
            let url = "http://maps.apple.com/?ll=\(loc.coordinate.latitude),\(loc.coordinate.longitude)&t=k"
            
            if let mapUrl = URL(string: url) {
            
                if UIApplication.shared.canOpenURL(mapUrl){
                    UIApplication.shared.open(mapUrl, options: [:], completionHandler: nil)
                }
                else {
                    print("MAP app is not found")
                }
            }
        }
    }
    @IBAction func showAddrClicked(_ sender: Any) {
        lUtility.getCurrentAddress { (addr) in
            self.infoL.text = "Current Address: \(addr)"
        }
    }
    
    @IBAction func showLocClicked(_ sender: Any) {
       // updateInfo()
        lUtility.getGeoCoord(address: "Bangalore") { (loc) in
            self.infoL.text = "Bangalore co-ord: \(loc.coordinate.latitude), \(loc.coordinate.longitude)"
        }
    }
    
    func updateInfo() {
        if let loc = lUtility.currentLocation {
            
            let latt = loc.coordinate.latitude
            let longi = loc.coordinate.longitude
            
            infoL.text = "Latt: \(latt), Longi: \(longi)"
        }
        else {
            print("No Location data")
        }
    }
}


