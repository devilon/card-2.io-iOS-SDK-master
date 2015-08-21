//
//  ProgressView.swift
//  CustomProgressBar
//
//  Created by Sztanyi Szabolcs on 16/10/14.
//  Copyright (c) 2014 Sztanyi Szabolcs. All rights reserved.
//

import UIKit

class DateProgressView: UIView {

    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    private var progressLabel: UILabel
    
    var colorTop: AnyObject = UIColor(red: 186.0/255.0, green: 119.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
    var colorBottom: AnyObject = UIColor(red: 186.0/255.0, green: 119.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
    
    var endValue : CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        super.init(coder: aDecoder)
        createProgressLayer()
        createLabel()
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLayer()
        createLabel()
    }
    
    func changeColor(colorTop: UIColor, colorBottom: UIColor){
        self.colorTop = colorTop.CGColor
        self.colorBottom = colorBottom.CGColor
    }
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textColor = .whiteColor()
        progressLabel.textAlignment = .Center
        //progressLabel.text = "Load content"
        progressLabel.font = UIFont(name: "Avenir-Light", size: 20.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI*1.5)
        let endAngle = CGFloat(M_PI * 3.5)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.grayColor().CGColor
        progressLayer.lineWidth = 2.5
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
        animation.duration = 20
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        self.endValue = endValue
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print(self.endValue)
        //progressLabel.text = "\(Int(self.endValue*100))%"
    }
}
