import UIKit
import Neon

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Включить уведомления"]
    var projectArray = ["Поделиться с друзьями", " Оставить отзыв","Предложения по улучшению"]
    let defaults = NSUserDefaults.standardUserDefaults()
    var tableView: UITableView!
    let destination = TimeViewController()
    let sectionsTitle = ["ГОРОД","ЗВУК","ПОМОЩЬ ПРОЕКТУ",""]
    let versionLabel = UILabel()
    let facebookButton = UIButton()
    let vkButton = UIButton()
    let instagramButton = UIButton()
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpLayouts()
    }
    func setUpLayouts(){
        versionLabel.anchorToEdge(.Bottom, padding: -10, width: 100, height: 20)
        view.groupAgainstEdge(group: .Horizontal, views: [facebookButton,instagramButton,vkButton] , againstEdge: .Top, padding: 0, width: 50, height: 50)
        var x = facebookButton.frame
        x.origin.x -= 30
        facebookButton.frame = x
        
        var x2 = vkButton.frame
        x2.origin.x += 30
        vkButton.frame = x2
    }
    //MARK: - LifeCycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Настройки"
        tableView.reloadData()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let nav1 = UINavigationController()
        let mainView = SettingsViewController()
        nav1.viewControllers = [mainView]
        
        navigationController?.navigationBar.barTintColor = UIColorFromHex(0x2962a8, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .whiteColor()
        navigationController?.navigationBar.translucent = true
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "close"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 15, 15)
        btnName.addTarget(self, action: #selector(SettingsViewController.pressed(_:)), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let titleLabel = UILabel()
        titleLabel.text = sectionsTitle[section]
        titleLabel.font = titleLabel.font.fontWithSize(12)
        view.addSubview(titleLabel)
        if section < 3 {
            titleLabel.frame = CGRectMake(10, 6, 200, 30)
        }else if section == 3 {
            facebookButton.setImage(UIImage(named: "facebook"), forState: .Normal)
            view.addSubview(facebookButton)
            
            vkButton.setImage(UIImage(named: "vk"), forState: .Normal)
            view.addSubview(vkButton)
            
            instagramButton.setImage(UIImage(named: "instagram"), forState: .Normal)
            view.addSubview(instagramButton)
            
            versionLabel.text = "Версия 1.0"
            view.addSubview(versionLabel)
        }
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 37
        case 1: return 37
        case 2: return 37
        default: return 75
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            navigationController?.pushViewController(ListsOfCitiesViewController(), animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 50
    }
    //MARK: - TableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2 {
            return projectArray.count
        }else if section == 3 {
            return 0
        }
        else{
            return myArray.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         if indexPath.section == 0{
            let cell = CityTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
            cell.myLabel1.text = defaults.stringForKey("cityName")
            destination.cityName = defaults.stringForKey("cityName")
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
         else if indexPath.section == 1{
            let cell = SettingsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
            cell.selectionStyle = .None
            cell.myLabel1.text = myArray[indexPath.row]
            cell.switcher.addTarget(self,action: #selector(SettingsViewController.switcherChanged), forControlEvents: .ValueChanged)
            if indexPath.row == 0 {
                cell.switcher.tag = 0
                if defaults.boolForKey("notifications") == true{
                    cell.switcher.setOn(true, animated:true)
                }else{
                    cell.switcher.setOn(false, animated: true)
                }
                
            }else{
                cell.switcher.tag = 1
                if defaults.boolForKey("systemSound") == true{
                    cell.switcher.setOn(true, animated:true)
                }else{
                    cell.switcher.setOn(false, animated: true)
                }
            }

            return cell
         }else if indexPath.section == 3{
            let cell = CityTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
            cell.myLabel1.text = "asd"
            return cell
         }else{
            
            let cell = ProjectTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
            cell.myLabel1.text = projectArray[indexPath.row]
            return cell
        }
        
    }
    // MARK: - Actions
    
    func pressed(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func switcherChanged(sender: UISwitch){
        if sender.tag == 0{
            if sender.on {
                defaults.setBool(true, forKey: "notifications")
            }else{
                defaults.setBool(false, forKey: "notifications")
            }
        }else{
            if sender.on {
                defaults.setBool(true, forKey: "systemSound")
            }else{
                defaults.setBool(false, forKey: "systemSound")
            }
        }

    }
}