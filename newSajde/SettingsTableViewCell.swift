import UIKit
import Neon

class SettingsTableViewCell: UITableViewCell {
    
    var myLabel1: UILabel!
    var switcher = UISwitch()
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayouts()
    }
    func setUpLayouts(){
        switcher.anchorToEdge(.Right, padding: 30, width: 30, height: 30)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 10
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 300
        
        myLabel1 = UILabel()
        myLabel1.frame = CGRectMake(gap, gap, labelWidth, labelHeight)
        myLabel1.textColor = UIColor.blackColor()
        
        switcher.frame = CGRectMake(200, 10, 30, 30)
        
        contentView.addSubview(switcher)
        contentView.addSubview(myLabel1)
    }
    
}
