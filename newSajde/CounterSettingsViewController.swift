import UIKit

class CounterSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myArray = ["Вибрация", "Звук"]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: - LifeCycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Настройки"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let nav1 = UINavigationController()
        let mainView = SettingsViewController()
        nav1.viewControllers = [mainView]
        
        navigationController?.navigationBar.barTintColor = UIColorFromHex(0x2a8e6b)
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
    
    //MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "звуки"
    }
    
    //MARK: - Table View DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CounterTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.myLabel1.text = myArray[indexPath.row]
        cell.selectionStyle = .None
        cell.switcher.addTarget(self, action: #selector(CounterSettingsViewController.switchChanged(_:)), forControlEvents: .ValueChanged)
        if indexPath.row == 0 {
            cell.switcher.tag = 0
            if defaults.boolForKey("vibrate") == true{
                cell.switcher.setOn(true, animated:true)
            }else{
                cell.switcher.setOn(false, animated: true)
            }
            
        }else{
            cell.switcher.tag = 1
            if defaults.boolForKey("playSound") == true{
                cell.switcher.setOn(true, animated:true)
            }else{
                cell.switcher.setOn(false, animated: true)
            }
            
        }
        return cell
    }
    //MARK: - Actions
    func pressed(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func switchChanged(sender: UISwitch){
        if sender.tag == 0{
            if sender.on {
                defaults.setBool(true, forKey: "vibrate")
            }else{
                defaults.setBool(false, forKey: "vibrate")
            }
        }else{
            if sender.on {
                defaults.setBool(true, forKey: "playSound")
            }else{
                defaults.setBool(false, forKey: "playSound")
            }
        }
    }

    func playSwitchChanged(){
        if defaults.boolForKey("playSound") == true{
            defaults.setBool(false, forKey: "playSound")
        }else {
            defaults.setBool(true, forKey: "playSound")
        }
    }
}