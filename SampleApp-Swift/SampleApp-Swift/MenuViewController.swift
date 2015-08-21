//
//  MenuViewController.swift
//  SampleApp-Swift
//
//  Created by Kevin Peters on 2015-08-04.
//  Copyright © 2015 Punskyy, Roman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        //setDateLabels()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }
    
    func setDateLabels(){
        let date:NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.dateLabel.text = dateFormatter.stringFromDate(date)
    }
    
    @IBAction func getCurrencyBtnPressed(sender: AnyObject) {
    }
}
