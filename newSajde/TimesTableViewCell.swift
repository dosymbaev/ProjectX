import Foundation
import UIKit
import Neon

class TimesTableViewCell: UITableViewCell {
    var timesLabel = UILabel()
    var myLabel1 = UILabel()
    let alarmButton = UIButton()
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    override func layoutSubviews() {
        setUpLayouts()
    }
    func setUpLayouts(){
        alarmButton.anchorToEdge(.Right, padding: 0, width: 44, height: 44)
        timesLabel.anchorToEdge(.Left, padding: 0, width: 100, height: 30)
        myLabel1.align(.UnderCentered, relativeTo: timesLabel, padding: 0, width: 100, height: 15)
        var x = timesLabel.frame
        x.origin.x += 10
        x.origin.y -= 8
        timesLabel.frame = x
        
        var x2 = myLabel1.frame
        x2.origin.x += 10
        x2.origin.y -= 9
        myLabel1.frame = x2
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        myLabel1.textColor = UIColor.grayColor()
        myLabel1.font = myLabel1.font.fontWithSize(13)
        
        timesLabel.font = UIFont.boldSystemFontOfSize(25.0)
        
        alarmButton.setImage(UIImage(named: "alarm"), forState: .Normal)
        alarmButton.setImage(UIImage(named: "alarm_selected"), forState: .Selected)
        alarmButton.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        alarmButton.userInteractionEnabled = true
        
        contentView.addSubview(timesLabel)
        contentView.addSubview(alarmButton)
        contentView.addSubview(myLabel1)
    }
    
}

