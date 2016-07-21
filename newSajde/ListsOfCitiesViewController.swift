import Foundation
import UIKit

class ListsOfCitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selected = 0
    var citiesArray = ["Алматы","Астана","Актау","Актобе","Аркалык","Атырау","Екибастуз","Жезказган","Жетисай","Караганда","Кокшетау","Костанай","Кызыл Орда","Орал","Оскемен","Павлодар","Петропавловск","Семей","Талдыкорган","Тараз","Туркестан","Шымкент"]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выберите город"
        
        let tableView = UITableView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let nav1 = UINavigationController()
        let mainView = SettingsViewController()
        nav1.viewControllers = [mainView]
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? ListsOfCitiesTableViewCell
        defaults.setInteger(indexPath.row, forKey: "city")
        defaults.setObject(cell!.myLabel1.text!, forKey: "cityName")
        defaults.synchronize()
        cell?.accessoryType = .Checkmark
        navigationController?.popViewControllerAnimated(true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ListsOfCitiesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        cell.myLabel1.text = citiesArray[indexPath.row]
        if cell.myLabel1.text! == defaults.stringForKey("cityName")! {
            cell.accessoryType = .Checkmark
        }
        return cell
    }
}