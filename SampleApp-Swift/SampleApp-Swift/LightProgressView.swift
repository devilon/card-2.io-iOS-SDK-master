//
//  ProgressView.swift
//  CustomProgressBar
//
//  Created by Sztanyi Szabolcs on 16/10/14.
//  Copyright (c) 2014 Sztanyi Szabolcs. All rights reserved.
//

import UIKit

class LightProgressView: UIView {

    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    //private var progressLabel: UILabel
    
    var colorTop: AnyObject = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.2).CGColor
    var colorBottom: AnyObject = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.2).CGColor
    
    required init?(coder aDecoder: NSCoder) {
        //progressLabel = UILabel()
        super.init(coder: aDecoder)
        createProgressLayer()
        //createLabel()
    }
    
    override init(frame: CGRect) {
        //progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLayer()
        //createLabel()
    }
    
    func changeColor(colorTop: UIColor, colorBottom: UIColor){
        self.colorTop = colorTop.CGColor
        self.colorBottom = colorBottom.CGColor
    }
    
    /*func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textColor = .whiteColor()
        progressLabel.textAlignment = .Center
        progressLabel.text = "Load content"
        progressLabel.font = UIFont(name: "Avenir-Light", size: 35.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }*/
    
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI)
        let endAngle = CGFloat(M_PI * 3)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.grayColor().CGColor
        progressLayer.lineWidth = 3.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 1.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds

        gradientLayer.locations = [0.0, 1.0]
        
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
        //progressLabel.text = "Load content"
    }
    
    func animateProgressView(endValue: CGFloat) {
        //progressLabel.text = "Loading..."
            
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(endValue)
        animation.duration = 1.0
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
        //progressLabel.text = "\(Int(endValue*100))%"
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        //progressLabel.text = "68%"
    }
}
