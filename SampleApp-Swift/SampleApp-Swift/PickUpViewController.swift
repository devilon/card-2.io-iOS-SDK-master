//
//  PickUpViewController.swift
//  RBCInstaBank
//
//  Created by Kevin Peters on 2015-08-14.
//  Copyright © 2015 Punskyy, Roman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PickUpViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var lightTimeProgressView: LightProgressView!
    @IBOutlet weak var timeProgressView: DateProgressView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var labelline: UILabel!
    @IBOutlet weak var ETA: UILabel!
    
    var timer = NSTimer()
    var seconds = 0
    
    @IBOutlet weak var confirmLocationBtn: UIButton!
    @IBOutlet weak var signDeliverybtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lightTimeProgressView.hidden = true
        timeProgressView.hidden = true
        ETA.hidden = true
        signDeliverybtn.hidden = true
        
        let date: NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let tempDate: String = dateFormatter.stringFromDate(date)
        
        self.deliveryTime.text = tempDate
        
        timeProgressView.animateProgressView(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as CLLocation!
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    

    @IBAction func confirmPressed(sender: AnyObject) {
        label1.hidden = true
        label2.hidden = true
        label3.hidden = true
        labelline.hidden = true
        deliveryTime.hidden = true
        lightTimeProgressView.hidden = false
        timeProgressView.hidden = false
        confirmLocationBtn.hidden = true
        ETA.hidden = false
        
        seconds = 5
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
        
        timeProgressView.animateProgressView(1)
    }
    
    func subtractTime() {
        //self.ETA.text = "ETA: \(seconds) Min"
        if seconds == 5 {
            let notification = UILocalNotification()
            notification.alertBody = "Your delivery is 10 minutes away!"
            notification.soundName = "Default";
            notification.fireDate = NSDate(timeIntervalSinceNow: 5)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
            let notification2 = UILocalNotification()
            notification2.alertBody = "Your delivery has arrived"
            notification2.soundName = "Default";
            notification2.fireDate = NSDate(timeIntervalSinceNow: 10)
            UIApplication.sharedApplication().scheduleLocalNotification(notification2)
        }
        
        if seconds == 0 {
            timer.invalidate()
            self.signDeliverybtn.hidden = false
        }
        
        seconds--
    }

 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
