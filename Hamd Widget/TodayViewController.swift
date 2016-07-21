//
//  TodayViewController.swift
//  Hamd Widget
//
//  Created by Dias Dosymbaev on 7/18/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timeLineImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        preferredContentSize = CGSizeMake(320, 100)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineImageView.frame.size.width = self.view.frame.width
        print(timeLineImageView.frame.width)
        timeRemainingLabel.backgroundColor = .whiteColor()
        timeRemainingLabel.layer.cornerRadius = 15
        var x = timeLineImageView.frame
        x.origin.x -= 20
        timeLineImageView.frame = x
        
    }
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
