

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController, CardIOPaymentViewControllerDelegate {

    @IBOutlet weak var touchIDButton: UIButton!
    @IBOutlet weak var rbcTitleLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var creditCardButton: UIButton!
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    self.creditCardButton.alpha = 0
    self.touchIDButton.alpha = 0
    self.rbcTitleLabel.alpha = 0
    self.label1.alpha = 0
    self.label2.alpha = 0
    self.label3.alpha = 0
    self.label4.alpha = 0
    
    CardIOUtilities.preload()
  }
    
    override func viewWillAppear(animated: Bool) {
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.rbcTitleLabel.alpha = 1
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.rbcTitleLabel.frame.origin.y -= 120
                    }, completion: { (finished) -> Void in
                        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.touchIDButton.alpha = 1
                            self.creditCardButton.alpha = 1
                            self.label1.alpha = 1
                            self.label2.alpha = 1
                            self.label3.alpha = 1
                            self.label4.alpha = 1
                            }, completion: nil)
                })
                
        }

    }
    
    @IBAction func touchIDEvent(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToOptions", sender: self)
        
        /*let myContext = LAContext()
        var authError: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        let myReasonString = "String explaining why app needs authentication"
        
        if myContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &authError) {
            [myContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: myReasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("goToOptions", sender: self)
                    }                } else {
                    // Authenticate failed
                }
            })]
        } else{
            // Could not evaluate policy; check authError
        }*/
        
    }



  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func scanCard(sender: AnyObject) {
    let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
    cardIOVC.modalPresentationStyle = .FormSheet
    cardIOVC.useCardIOLogo = true
    cardIOVC.hideCardIOLogo = true
    presentViewController(cardIOVC, animated: true, completion: nil)
  }
  
  func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
    
    paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
    
    if let info = cardInfo {
      let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
      print(str)
    }
    
    paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    self.performSegueWithIdentifier("goToOptions", sender: self)
    
  }
    
    
    
    
}
