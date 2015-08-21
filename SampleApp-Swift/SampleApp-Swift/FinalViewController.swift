//
//  FinalViewController.swift
//  RBCInstaBank
//
//  Created by Kevin Peters on 2015-08-14.
//  Copyright © 2015 Punskyy, Roman. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    @IBOutlet weak var eSignBtn: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var thankyou: UILabel!

    @IBOutlet weak var rbcLogi: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rbcLogi.alpha = 0
        self.thankyou.alpha = 0
        self.rbcLogi.hidden = true
        self.thankyou.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eSignButtonPress(sender: AnyObject) {
        self.eSignBtn.hidden = true
        self.label1.hidden = true
        self.label2.hidden = true
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.rbcLogi.hidden = false
            self.thankyou.hidden = false
            self.rbcLogi.alpha = 1
            self.thankyou.alpha = 1
            }, completion: nil)
        
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
