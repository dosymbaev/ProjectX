//
//  CompassViewController.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/12/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import Foundation
import UIKit
import Neon
import AudioToolbox
import AVFoundation

class CounterViewController: UIViewController {
    let plusButton = PlusButton()
    let minusButton = MinusButton()
    let resetButton = ResetButton()
    let settingsButton = SettingsButton()
    let digits = UILabel()
    let promptView = UIView()
    var backgroundLayer: CAGradientLayer!
    var promptMessageLabel = UILabel()
    let yesButton = YesButton()
    let noButton = NoButton()
    var animating = false
    let defaults = NSUserDefaults.standardUserDefaults()
    var plusAnimating = false
    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let pianoSound = NSBundle.mainBundle().pathForResource("cork2", ofType: "aiff")!
        if let pianoSound: String! = pianoSound {
           let myURL = NSURL(fileURLWithPath: pianoSound)
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: myURL)
            }
            catch{
                print("error")
            }
        }
        self.backgroundLayer = colors.gl
        view.userInteractionEnabled = true
        setBackgroundColor()
        setLabel()
        setUpButton()
        setUpPrompt()
        digits.text = String(defaults.integerForKey("counter"))
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpLayouts()
    }
    func buttonPressed(button: UIButton){
            if defaults.boolForKey("playSound") == true {
                audioPlayer.play()
            }
            if defaults.boolForKey("vibrate") == true {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            if button.tag == 1 {
                if Int(digits.text!)! == 0{
                    digits.text = "0"
                }else{
                    let result = defaults.integerForKey("counter") - 1
                    defaults.setInteger(result, forKey: "counter")
                    digits.text = String(result)
                }
            }else if button.tag == 0 {
                let result = defaults.integerForKey("counter") + 1
                defaults.setInteger(result, forKey: "counter")
                digits.text = String(result)
            }
            plusAnimating = true
            UIView.animateWithDuration(0.2,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.7,
                                       initialSpringVelocity: 0.5,
                                       options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction],
                                       animations: {
                                        button.transform = CGAffineTransformMakeScale(0.7, 0.7)
                                        button.transform = CGAffineTransformMakeScale(1, 1)
                                        
                },
                                       completion: { finished in self.plusAnimating = false})

        
                UIView.animateWithDuration(0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: UIViewAnimationOptions.CurveEaseInOut,
                       animations: {
                        self.digits.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        self.digits.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        self.digits.transform = CGAffineTransformMakeScale(1, 1)

},
                       completion:nil)
    }
    func promptButtonPressed(button: UIButton){
        if button.tag == 0 {
            digits.text = String(0)
            defaults.setInteger(0, forKey: "counter")
            closePrompt()
        }else if button.tag == 1{
            closePrompt()
        }
    }
    func openPrompt(){
        plusButton.userInteractionEnabled = false
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    self.promptView.alpha = 1
                                    self.promptView.transform = CGAffineTransformMakeScale(0.6, 0.6)
                                    self.promptView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                                    self.promptView.transform = CGAffineTransformMakeScale(1, 1)
                                    
            },
                                   completion: nil)
    }
    func closePrompt(){
        animating = true
        plusButton.userInteractionEnabled = true
        UIView.animateWithDuration(0.3,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    self.promptView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                                    self.promptView.alpha = 0
            },
                                   completion: {
                                    finished in
                                    self.animating = false
                                    self.setUpLayouts()
                                    })
    }
    func setUpLayouts(){
        let bottomMargin: CGFloat = 64
        settingsButton.anchorToEdge(.Bottom, padding: bottomMargin + 10, width: 25, height: 25)
        
        digits.anchorAndFillEdge(.Top, xPad: 10, yPad: 30, otherSize: 100)
        
        plusButton.anchorInCenter(width: view.width/2.5, height: view.width/2.5)
        var x = plusButton.frame
        x.origin.x += 50
        plusButton.frame = x
        
        minusButton.align(.ToTheLeftMatchingBottom, relativeTo: plusButton,padding: 10, width: view.width/3.5, height: view.width/3.5)
        
        resetButton.align(.ToTheLeftMatchingTop, relativeTo: plusButton, padding: -10, width: view.width/4.5, height: view.width/4.5)
        var y = resetButton.frame
        y.origin.y -= 20
        resetButton.frame = y
        
        if animating == false {
            promptView.anchorInCenter(width: view.width - 20, height: 200)
            var y2 = promptView.frame
            y2.origin.y -= 40
            promptView.frame = y2
            
            promptMessageLabel.anchorToEdge(.Top, padding: 45, width: promptView.width - 20, height: 50)
            
            noButton.anchorInCorner(.BottomRight, xPad: 0, yPad: 0, width: promptView.width/2, height: 70)
            yesButton.anchorInCorner(.BottomLeft, xPad: 0, yPad: 0, width: promptView.width/2, height: 70)
        }
    }
    func setBackgroundColor(){
        view.backgroundColor = UIColor.clearColor()
        let greenLayer = CAGradientLayer.greenLayer()
        greenLayer.frame = view.frame
        greenLayer.frame.origin.y -= 64
        greenLayer.frame.size.height += 64
        view.layer.insertSublayer(greenLayer, atIndex: 0)
        
        let blueLayer = CAGradientLayer.blueLayer()
        blueLayer.frame = view.frame
        blueLayer.frame.origin.y -= 64
        blueLayer.frame.size.height += 64
        view.layer.insertSublayer(blueLayer, below: greenLayer)
    }
    func toTheNextView() {
        let secondViewController:CounterSettingsViewController = CounterSettingsViewController()
        let navController2 = UINavigationController(rootViewController: secondViewController)
        if let vc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.controller {
            vc.presentViewController(navController2, animated: true, completion: nil)
        }
    }
    func setLabel(){
        digits.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        digits.center = CGPoint(x: view.bounds.width / 2, y: 100)
        digits.text = "1000"
        digits.font = digits.font.fontWithSize(120)
        digits.textAlignment = .Center
        
        digits.textColor = UIColorFromHex(0xffffff, alpha: 1.0)
        view.addSubview(digits)
    }
    func setUpPrompt(){
        promptView.backgroundColor = .whiteColor()
        promptView.layer.cornerRadius = 10
        promptView.clipsToBounds = true
        promptView.alpha = 0
        
        promptMessageLabel.text = "Вы действительно хотите начать отсчет сначала?"
        promptMessageLabel.textAlignment = .Center
        promptMessageLabel.numberOfLines = 2
        
        
        noButton.vc = self
        noButton.backgroundColor = UIColorFromHex(0xFF573F)
        noButton.setTitle("Нет", forState: .Normal)
        noButton.titleLabel?.textColor = .whiteColor()
        noButton.layer.masksToBounds = true
        noButton.tag = 1
        noButton.userInteractionEnabled = true
        
        yesButton.vc = self
        yesButton.backgroundColor = UIColorFromHex(0x1BBBEE)
        yesButton.setTitle("Да", forState: .Normal)
        yesButton.titleLabel?.textColor = .whiteColor()
        yesButton.clipsToBounds = true
        yesButton.userInteractionEnabled = true
        yesButton.tag = 0
        
        promptView.addSubview(yesButton)
        promptView.addSubview(noButton)
        promptView.addSubview(promptMessageLabel)
        view.addSubview(promptView)
    }
    func setUpButton(){
        plusButton.vc = self
        plusButton.setImage(UIImage(named:"plusButton"), forState: .Normal)
        plusButton.tintColor = UIColor.whiteColor()
        plusButton.reversesTitleShadowWhenHighlighted = true
        plusButton.frame = CGRectMake(162.5, 250, 155, 155)
        plusButton.userInteractionEnabled = true
        plusButton.tag = 0
        
        minusButton.vc = self
        minusButton.setImage(UIImage(named:"minusButton"), forState: .Normal)
        minusButton.tintColor = UIColor.whiteColor()
        minusButton.reversesTitleShadowWhenHighlighted = true
        minusButton.frame = CGRectMake(62.5, 328, 80, 80)
        minusButton.userInteractionEnabled = true
        minusButton.tag = 1
        
        resetButton.vc = self
        resetButton.setImage(UIImage(named:"reset"), forState: .Normal)
        resetButton.tintColor = UIColor.whiteColor()
        resetButton.reversesTitleShadowWhenHighlighted = true
        resetButton.frame = CGRectMake(85, 255, 60, 60)
        resetButton.userInteractionEnabled = true
        resetButton.tag = 2
        
        settingsButton.vc = self
        settingsButton.setImage(UIImage(named:"settings"), forState: .Normal)
        settingsButton.showsTouchWhenHighlighted = true
        settingsButton.frame = CGRectMake(175, 570, 25, 25)
        settingsButton.userInteractionEnabled = true
        
        
        self.view.addSubview(settingsButton)
        self.view.addSubview(minusButton)
        self.view.addSubview(plusButton)
        self.view.addSubview(resetButton)
    }
    //MARK: - Background Color
    let colors = Colors()
    class Colors{
        var colorTop = UIColorFromHex(0x2ac879).CGColor
        var colorBottom = UIColorFromHex(0x2a8e6b).CGColor
        let gl: CAGradientLayer
        
        init() {
            gl = CAGradientLayer()
            gl.colors = [ colorTop, colorBottom ]
            gl.locations = [ 0.0, 1.0 ]
        }
        }
    }

    //MARK: - Button Classes
    class MinusButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.buttonPressed(self)
        }
    }
    class PlusButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.buttonPressed(self)
        }
    }
    class ResetButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.openPrompt()
        }
    }
    class NoButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.promptButtonPressed(self)
        }
    }
    class YesButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.promptButtonPressed(self)
        }
    }
    class SettingsButton: UIButton {
        var vc: CounterViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.toTheNextView()
    }
    }