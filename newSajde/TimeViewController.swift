//
//  File.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/12/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import Foundation
import UIKit
import Neon
import Alamofire
import SVProgressHUD

class TimeViewController: UIViewController{
    let times = ["Фаджр","Восход","Зухр","Аср","Магриб","Иша"]
    var timesValue: [String] = []
    let myFirstView = UIView()
    let mySecondView = UIView()
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    let moonImageView = UIImageView()
    let clockImageView = UIImageView()
    let dateLabel = UILabel()
    let dayLabel = UILabel()
    let locationImageView = UIImageView()
    let localNotification = UILocalNotification()
    var cityLabel = UILabel()
    let timeTableView = UITableView()
    let defaults = NSUserDefaults.standardUserDefaults()
    var oneOn = false
    var secondOn = false
    var thirdOn = false
    var fourthOn = false
    var fifthOn = false
    var sixthOn = false
    var cityName: String!
    var dayString: String!
    var monthString: String!
    var dateString: String!
    override func viewWillAppear(animated: Bool) {
        self.timesValue.removeAll()
        getTimes()
        self.timeTableView.reloadData()
        let today = NSDate()
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:m"
        let dateString4 = dayTimePeriodFormatter.stringFromDate(today)
        cityLabel.text = defaults.stringForKey("cityName")! + "\n" + dateString4 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.setBool(true, forKey: "playSound")
        timeTableView.userInteractionEnabled = true
        view.tag = 666
        view.userInteractionEnabled = true
        setBackgroundColor()
        self.setUpSecondView()
        self.setUpFirstView()
        self.setUpButton()
        fireNotification()
        getTimes()
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year,.Month,.Day,.Hour,.Minute,.Second], fromDate: date)
        let year = components.year
        let day = components.day
        let month = components.month
        
//        let minute = components.minute
//        let hour = components.hour
//        let second = components.second
        
        if month < 10 {
            self.monthString = "0\(month)"
        }else{
            self.monthString = "\(month)"
        }
        if day < 10 {
            self.dayString = "0\(day)"
        }else {
            self.dayString = "\(day)"
        }
        
        self.dateString = "\(year).\(self.monthString).\(self.dayString)"
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bottomMargin: CGFloat = 64
        
        myFirstButton.anchorToEdge(.Bottom, padding: bottomMargin + 10, width: 25, height: 25)
        mySecondView.alignAndFillWidth(align: .AboveCentered, relativeTo: myFirstButton, padding: 10, height: 95)
        myFirstView.alignAndFill(align: .AboveCentered, relativeTo: mySecondView, padding: 10)
    
        timeTableView.anchorAndFillEdge(.Top, xPad: 0, yPad: 0, otherSize: view.height)
        
        moonImageView.anchorToEdge(.Top, padding: 5, width: 25, height: 25)
        dateLabel.anchorToEdge(.Bottom, padding: 0, width: firstView.width, height: 40)
        clockImageView.anchorToEdge(.Top, padding: 5, width: 25, height: 25)
        dayLabel.anchorToEdge(.Bottom, padding: 0, width: secondView.width, height: 40)
        locationImageView.anchorToEdge(.Top, padding: 5, width: 25, height: 25)
        cityLabel.anchorToEdge(.Bottom, padding: 0, width: thirdView.width, height: 40)
        mySecondView.groupInCenter(group: .Horizontal, views: [firstView, secondView, thirdView], padding: 0, width: mySecondView.width / 3, height: 80)
    }
    func fireNotification(){
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.alertBody = "new Blog Posted at iOScreator.com"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func getTimes(){
        SVProgressHUDMaskType.Clear
        SVProgressHUD.setForegroundColor(UIColorFromHex(0x2962a8))
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setCornerRadius(20)
        SVProgressHUD.show()
        guard let stringURL = "http://azan.kz/ws/getNamazTimes?region=\(defaults.stringForKey("cityName")!)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else { return }
        guard let url = NSURL(string: stringURL) else {
            print("Error with URL")
            return
        }
        let urlRequest = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {(data: NSData?, response: NSURLResponse?,error: NSError?) in
            guard let jsonData = data else {
                print("no data has been downloaded")
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
                let items = json["result"] as! [[String: AnyObject]]
                
                for i in 0...items.count - 1 {
                    if items[i]["date"] as! String == self.dateString {
                        self.timesValue.append(items[i]["time"]! as! String)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    SVProgressHUD.dismiss()
                    self.timeTableView.reloadData()
                })
            }catch{
                print("Error with JSON")
            }
        }
        task.resume()

    }
    func setBackgroundColor(){
        view.backgroundColor = UIColor.clearColor()
        let greenLayer = CAGradientLayer.greenLayer()
        greenLayer.frame = view.frame
        greenLayer.frame.origin.y -= 64
        greenLayer.frame.size.height += 64
        view.layer.insertSublayer(greenLayer, atIndex: 0)
        
        let orangeLayer = CAGradientLayer.orangeLayer()
        orangeLayer.frame = view.frame
        orangeLayer.frame.origin.y -= 64
        orangeLayer.frame.size.height += 64
        view.layer.insertSublayer(orangeLayer, below: greenLayer)
        
        let blueLayer = CAGradientLayer.blueLayer()
        blueLayer.frame = view.frame
        blueLayer.frame.origin.y -= 64
        blueLayer.frame.size.height += 64
        view.layer.insertSublayer(blueLayer, below: orangeLayer)

    }
    func setUpFirstView(){
        myFirstView.layer.cornerRadius = 8
        myFirstView.backgroundColor = UIColor.whiteColor()
        myFirstView.frame = CGRectMake(15, 15, 345, 435)
        myFirstView.clipsToBounds = true
        

        timeTableView.scrollEnabled = false
        timeTableView.dataSource = self
        timeTableView.delegate = self
        timeTableView.separatorStyle = .None
        
        myFirstView.addSubview(timeTableView)
        self.view.addSubview(myFirstView)
    }
    func setUpSecondView(){
        mySecondView.layer.cornerRadius = 8
        mySecondView.backgroundColor = UIColor.whiteColor()
        mySecondView.frame = CGRectMake(15, 460, 345, 95)
        self.view.addSubview(mySecondView)
        
        moonImageView.contentMode = .ScaleAspectFill
        moonImageView.image = UIImage(named: "moon")
        let today = NSDate()
        let formatter = NSDateFormatter()
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE" //"HH:m"
        let dateString2 = dayTimePeriodFormatter.stringFromDate(today)
        formatter.dateFormat = "d MMMM"
        let dateString = formatter.stringFromDate(today)
        dateLabel.text = dateString + "\n" + dateString2
        dateLabel.numberOfLines = 2
        dateLabel.font = dateLabel.font.fontWithSize(15.0)
        dateLabel.textAlignment = .Center
        dateLabel.textColor = UIColorFromHex(0x2962a8, alpha: 1.0)
        firstView.addSubview(moonImageView)
        firstView.addSubview(dateLabel)
        
        clockImageView.contentMode = .ScaleAspectFill
        clockImageView.image = UIImage(named: "clock_blue")
        
        
        dayLabel.text = ""
        dayLabel.numberOfLines = 2
        dayLabel.font = dayLabel.font.fontWithSize(15.0)
        dayLabel.textAlignment = .Center
        dayLabel.textColor = UIColorFromHex(0x2962a8, alpha: 1.0)
        secondView.addSubview(clockImageView)
        secondView.addSubview(dayLabel)
        
        locationImageView.contentMode = .ScaleAspectFill
        locationImageView.image = UIImage(named: "location")
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        let dateString3 = dayTimePeriodFormatter.stringFromDate(today)
        cityLabel.text =  defaults.stringForKey("cityName")! + "\n" + dateString3
        cityLabel.numberOfLines = 2
        cityLabel.font = cityLabel.font.fontWithSize(15.0)
        cityLabel.textAlignment = .Center
        cityLabel.textColor = UIColorFromHex(0x2962a8, alpha: 1.0)
        thirdView.addSubview(locationImageView)
        thirdView.addSubview(cityLabel)
        
        mySecondView.addSubview(firstView)
        mySecondView.addSubview(secondView)
        mySecondView.addSubview(thirdView)
    }
    let myFirstButton = MenuButton()
    func setUpButton(){
        myFirstButton.vc = self
        myFirstButton.setImage(UIImage(named:"settings"), forState: .Normal)
        myFirstButton.tintColor = UIColor.whiteColor()
        myFirstButton.showsTouchWhenHighlighted = true
        myFirstButton.frame = CGRectMake(175, 570, 25, 25)
        myFirstButton.userInteractionEnabled = true
        self.view.addSubview(myFirstButton)
    }
    func alarmButtonPressed(sender: UIButton){
        sender.selected = !sender.selected;
    }
    func toTheNextView() {
        let secondViewController:SettingsViewController = SettingsViewController()
        let navController2 = UINavigationController(rootViewController: secondViewController)
        if let vc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.controller {
            vc.presentViewController(navController2, animated: true, completion: nil)
        }
    }
        //MARK: - Background Color
        let colors = Colors()
        class Colors{
            var colorTop = UIColorFromHex(0x25bfed).CGColor
            var colorBottom = UIColorFromHex(0x2962a8).CGColor
            let gl: CAGradientLayer
            
            init() {
                gl = CAGradientLayer()
                gl.colors = [ colorTop, colorBottom ]
                gl.locations = [ 0.0, 1.0 ]
            }
        }
    }
class MenuButton: UIButton {
    var vc: TimeViewController?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        vc?.toTheNextView()
    }
}
//MARK: -Table View
extension TimeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return myFirstView.height / 6
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TimesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.selectionStyle = .None
        cell.myLabel1.text = times[indexPath.row]
        
        if timesValue.count >= 6 {
            cell.timesLabel.text = self.timesValue[indexPath.row]
        }
        cell.alarmButton.tag = indexPath.row
        cell.alarmButton.addTarget(self, action: #selector(TimeViewController.alarmButtonPressed(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
}
    