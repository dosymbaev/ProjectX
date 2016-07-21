//
//  CompassViewController.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/12/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import Foundation
import UIKit
import Spring
import Neon

class OthersViewController: UIViewController {
    let bgView = UIView()
    let compassButton = MyButton()
    let restaurantsButton = MyButton()
    let halalButton = MyButton()
    let errorView = UIView()
    let facebookButton = UIButton()
    let vkButton = UIButton()
    let instaButton = UIButton()
    let closeButton = CloseButton()
    let opsLabel = UILabel()
    let triangleImageView = UIImageView()
    let detailLabel = UILabel()
    let toolImageView = UIImageView()
    var animating = false
    var offsetOfTriangle = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setUpButtons()
        setUpError()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpLayouts()
    }
    func setUpLayouts() {
        view.groupAgainstEdge(group: .Horizontal, views: [compassButton,restaurantsButton,halalButton], againstEdge: .Top, padding: 5, width: view.width / 3, height: 69)
        [compassButton,restaurantsButton,halalButton].forEach({
            var frame = $0.frame
            frame.origin.y += 20
            $0.frame = frame
        })
        if animating == false{
            errorView.alignAndFill(align: .UnderCentered, relativeTo: compassButton, padding: 10)
            var frame = errorView.frame
            frame.size.height -= 64
            errorView.frame = frame
            facebookButton.anchorInCorner(.BottomLeft, xPad: 20, yPad: 20, width: 70, height: 70)
            vkButton.anchorToEdge(.Bottom, padding: 20, width: 70, height: 70)
            instaButton.anchorInCorner(.BottomRight, xPad: 20, yPad: 20, width: 70, height: 70)
            closeButton.anchorInCorner(.TopRight, xPad: 0,yPad: 0, width: 44, height: 44)
            toolImageView.anchorToEdge(.Top, padding: 10, width: errorView.width - 60, height: errorView.height / 2.5)
            detailLabel.align(.UnderCentered, relativeTo: opsLabel, padding: 5, width: errorView.width - 10, height: 60)
            opsLabel.align(.UnderCentered, relativeTo: toolImageView, padding: 10, width: 150, height: 40)
            if offsetOfTriangle == 0{
                triangleImageView.align(.AboveMatchingLeft, relativeTo: errorView, padding: -15, width: 30, height: 30)
            }else if offsetOfTriangle == 1{
                triangleImageView.align(.AboveCentered, relativeTo: errorView, padding: -15, width: 30, height: 30)
                var x = triangleImageView.frame
                x.origin.x -= 20
                triangleImageView.frame = x
            }else{
                triangleImageView.align(.AboveMatchingRight, relativeTo: errorView, padding: -15, width: 30, height: 30)
                var x = triangleImageView.frame
                x.origin.x -= 45
                triangleImageView.frame = x
            }
            
            var y = triangleImageView.frame
            y.origin.x += 20
            triangleImageView.frame = y
        }
    }
    
    func setBackgroundColor(){
        view.backgroundColor = UIColor.clearColor()
        let orangeLayer = CAGradientLayer.orangeLayer()
        orangeLayer.frame = view.frame
        orangeLayer.frame.origin.y -= 64
        orangeLayer.frame.size.height += 64
        view.layer.insertSublayer(orangeLayer, atIndex: 0)
        
        let blueLayer = CAGradientLayer.blueLayer()
        blueLayer.frame = view.frame
        blueLayer.frame.origin.y -= 64
        blueLayer.frame.size.height += 64
        view.layer.insertSublayer(blueLayer, below: orangeLayer)
    }
    
    func setUpButtons(){
        compassButton.vc = self
        compassButton.setImage(UIImage(named:"compass"), forState: .Normal)
        compassButton.tintColor = UIColor.whiteColor()
        compassButton.reversesTitleShadowWhenHighlighted = true
        compassButton.frame = CGRectMake(30, 40, 69, 69)
        compassButton.userInteractionEnabled = true
        compassButton.showsTouchWhenHighlighted = true
        compassButton.tag = 0
        
        restaurantsButton.vc = self
        restaurantsButton.setImage(UIImage(named:"rests"), forState: .Normal)
        restaurantsButton.tintColor = UIColor.whiteColor()
        restaurantsButton.reversesTitleShadowWhenHighlighted = true
        restaurantsButton.frame = CGRectMake(153 ,  40, 70, 70)
        restaurantsButton.userInteractionEnabled = true
        restaurantsButton.showsTouchWhenHighlighted = true
        restaurantsButton.tag = 1
        
        halalButton.vc = self
        halalButton.setImage(UIImage(named:"halal"), forState: .Normal)
        halalButton.tintColor = UIColor.whiteColor()
        halalButton.reversesTitleShadowWhenHighlighted = true
        halalButton.frame = CGRectMake(276, 40, 70, 70)
        halalButton.userInteractionEnabled = true
        halalButton.showsTouchWhenHighlighted = true
        halalButton.tag = 2
        
        view.addSubview(compassButton)
        view.addSubview(restaurantsButton)
        view.addSubview(halalButton)
    }
    func setUpError(){
        triangleImageView.alpha = 0
        triangleImageView.contentMode = .ScaleAspectFit
        triangleImageView.image = UIImage(named: "triangle")
        
        errorView.frame = CGRectMake(10, 130, 355, 400)
        errorView.backgroundColor = .whiteColor()
        errorView.layer.cornerRadius = 15
        errorView.alpha = 0
        view.addSubview(errorView)
        
        
        opsLabel.text = "Ooops!"
        opsLabel.contentMode = .Center
        opsLabel.textAlignment = .Center
        
        
        detailLabel.text = "Эта функция скоро будет доступна, подписывайтесь чтобы не пропустить обновления."
        detailLabel.contentMode = .Center
        detailLabel.textAlignment = .Center
        detailLabel.numberOfLines = 10
        detailLabel.font = detailLabel.font.fontWithSize(13)
        detailLabel.textColor = .grayColor()
        
        
        toolImageView.contentMode = .ScaleAspectFill
        toolImageView.image = UIImage(named: "programing")
        toolImageView.clipsToBounds = true
        
        
        
        facebookButton.setImage(UIImage(named:"facebook"), forState: .Normal)
        facebookButton.frame = CGRectMake(36.5, 290, 70, 70)
        facebookButton.userInteractionEnabled = true
        
        vkButton.setImage(UIImage(named:"vk"), forState: .Normal)
        vkButton.frame = CGRectMake(142.5, 290, 70, 70)
        vkButton.userInteractionEnabled = true
        
        instaButton.setImage(UIImage(named:"instagram"), forState: .Normal)
        instaButton.frame = CGRectMake(248.5, 290, 70, 70)
        instaButton.userInteractionEnabled = true
        
        closeButton.vc = self
        closeButton.setImage(UIImage(named: "cancel_black"), forState: .Normal)
        closeButton.frame = CGRectMake(330, 10, 15, 15)
        closeButton.userInteractionEnabled = true
        closeButton.imageEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        
        
        
        view.addSubview(triangleImageView)
        
        errorView.addSubview(facebookButton)
        errorView.addSubview(instaButton)
        errorView.addSubview(vkButton)
        errorView.addSubview(toolImageView)
        errorView.addSubview(opsLabel)
        errorView.addSubview(detailLabel)
        errorView.addSubview(closeButton)
        
    }
    func setInitial(x: CGFloat, y: CGFloat){
        let translate = CGAffineTransformMakeTranslation(x, y)
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        self.errorView.transform = CGAffineTransformConcat(scale, translate)
    }
    func buttonPressed(button: UIButton){
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                        button.transform = CGAffineTransformMakeScale(0.5, 0.5)
                                        button.transform = CGAffineTransformMakeScale(1.2, 1.2)
                                        button.transform = CGAffineTransformMakeScale(1, 1)
                                        button.transform = CGAffineTransformMakeRotation(-45)
                                        button.transform = CGAffineTransformMakeRotation(0)
                                   },
                                   completion: nil)
        
        errorView.alpha = 1
        triangleImageView.alpha = 1
        if button.tag == 0{
            setInitial(-60, y: -150)
            offsetOfTriangle = 0
        }else if button.tag == 1 {
            setInitial(0, y: -150)
            offsetOfTriangle = 1
        }else{
            setInitial(60, y: -150)
            offsetOfTriangle = 2
        }
        
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: {
                                    let scale1 = CGAffineTransformMakeScale(1, 1)
                                    let translate1 = CGAffineTransformMakeTranslation(0, 0)
                                    self.errorView.transform = CGAffineTransformConcat(scale1, translate1)
            },
                                   completion: nil)
    }
    
    func closePressed(){
//        let translate = CGAffineTransformMakeTranslation(0, 0)
//        let scale = CGAffineTransformMakeScale(1, 1)
//        self.errorView.transform = CGAffineTransformConcat(scale, translate)
        self.triangleImageView.alpha = 0
        animating = true
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    var translate: CGAffineTransform?
                                    if self.offsetOfTriangle == 0{
                                        translate = CGAffineTransformMakeTranslation(-60, -120)
                                    }else if self.offsetOfTriangle == 1 {
                                        translate = CGAffineTransformMakeTranslation(0, -120)
                                    }else{
                                        translate = CGAffineTransformMakeTranslation(60, -120)
                                    }
                                    guard let translate1 = translate else { return }
                                    let scale = CGAffineTransformMakeScale(0.4, 0.4)
                                    self.errorView.transform = CGAffineTransformConcat(scale, translate1)
                                    self.errorView.alpha = 0
                                    
            },
                                   completion: { finished in
                                    self.animating = false
                                    self.setUpLayouts()
        })
    }
    //MARK: - Background Color
    let colors = Colors()
    class Colors{
        var colorTop = UIColorFromHex(0xfe9458).CGColor
        var colorBottom = UIColorFromHex(0xfd6a51).CGColor
        let gl: CAGradientLayer
        
        init() {
            gl = CAGradientLayer()
            gl.colors = [ colorTop, colorBottom ]
            gl.locations = [ 0.0, 1.0 ]
        }
    }
    //MARK: - Button Classes
    class MyButton: UIButton {
        var vc: OthersViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.buttonPressed(self)
        }
    }
    class CloseButton: UIButton {
        var vc: OthersViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            vc?.closePressed()
        }
    }
    class RestaurantButton: UIButton {
        var vc: OthersViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
//            vc?.plusPressed()
        }
    }
    class HalalButton: UIButton {
        var vc: OthersViewController?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
//            vc?.resetPressed()
        }
    }

}

