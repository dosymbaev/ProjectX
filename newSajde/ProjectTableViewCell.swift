import UIKit
import Neon

class ProjectTableViewCell: UITableViewCell {
    
    var myLabel1: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 10
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 300
        
        myLabel1 = UILabel()
        myLabel1.frame = CGRectMake(gap, gap, labelWidth, labelHeight)
        myLabel1.textColor = UIColor.blackColor()
        
        contentView.addSubview(myLabel1)
    }
    
}
