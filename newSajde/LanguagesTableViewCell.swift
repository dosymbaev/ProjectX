import Foundation
import UIKit
import Neon

class LanguagesTableViewCell: UITableViewCell {
    
    var myLabel1: UILabel!

    let engButton = UIButton()
    let ruButton = UIButton()
    let kzButton = UIButton()

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayouts()
    }
    func setUpLayouts(){
        contentView.groupAndFill(group: .Horizontal, views: [kzButton,ruButton,engButton], padding: 15)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        kzButton.setImage(UIImage(named:"KAZ"), forState: .Normal)
        kzButton.imageView?.contentMode = .ScaleAspectFit
        kzButton.imageEdgeInsets = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        kzButton.frame = CGRectMake(10, 10, 90, 70)
        kzButton.layer.borderColor = UIColorFromHex(0x9B9B9B).CGColor
        kzButton.layer.borderWidth = 0.5
        kzButton.layer.cornerRadius = 5
        kzButton.contentMode = .ScaleAspectFit
        
        ruButton.setImage(UIImage(named:"RUS"), forState: .Normal)
        ruButton.frame = CGRectMake(120, 10, 90, 70)
        ruButton.imageView?.contentMode = .ScaleAspectFit
        ruButton.imageEdgeInsets = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        ruButton.layer.borderColor = UIColorFromHex(0x9B9B9B).CGColor
        ruButton.layer.borderWidth = 0.5
        ruButton.layer.cornerRadius = 5
        
        engButton.setImage(UIImage(named:"USA"), forState: .Normal)
        engButton.frame = CGRectMake(230, 10, 90, 70)
        engButton.imageView?.contentMode = .ScaleAspectFit
        engButton.imageEdgeInsets = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        engButton.layer.borderColor = UIColorFromHex(0x9B9B9B).CGColor
        engButton.layer.borderWidth = 0.5
        engButton.layer.cornerRadius = 5
        

        
        
        contentView.addSubview(kzButton)
        contentView.addSubview(ruButton)
        contentView.addSubview(engButton)

    }
    
}
