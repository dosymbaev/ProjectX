//
//  SelectCityViewController.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/20/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import UIKit
import Neon

class SelectCityViewController: UIViewController {
    var cities = ["Алматы","Астана","Актау","Актобе","Аркалык","Атырау","Екибастуз","Жезказган","Жетисай","Караганда","Кокшетау","Костанай","Кызыл Орда","Орал","Оскемен","Павлодар","Петропавловск","Семей","Талдыкорган","Тараз","Туркестан","Шымкент"]
    let myFirstView = UIView()
    let citiesTable = UITableView()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .greenColor()
        refresh()
        setUpFirstView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpLayouts()
    }
    func setUpLayouts(){
        myFirstView.anchorInCenter(width: view.width - 20, height: view.height - 200)
    }
    func setUpFirstView(){
        myFirstView.layer.cornerRadius = 8
        myFirstView.backgroundColor = UIColor.whiteColor()
        myFirstView.frame = CGRectMake(15, 15, 345, 435)
        myFirstView.clipsToBounds = true
        
        citiesTable.frame = CGRectMake(0, 0, myFirstView.width, myFirstView.height)
        citiesTable.dataSource = self
        citiesTable.delegate = self
        citiesTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        citiesTable.separatorColor = UIColorFromHex(0x25bfed)
        citiesTable.tableFooterView = UIView()
        
        myFirstView.addSubview(citiesTable)
        self.view.addSubview(myFirstView)
    }

    //MARK: - Background Color
    let colors = Colors()
    func refresh() {
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
    }
    class Colors {
        let colorTop = UIColorFromHex(0x25bfed).CGColor
        let colorBottom = UIColorFromHex(0x2962a8).CGColor
        let gl: CAGradientLayer
        
        init() {
            gl = CAGradientLayer()
            gl.colors = [ colorTop, colorBottom]
            gl.locations = [ 0.0, 1.0]
        }
    }
    }

//MARK: - Table view

extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? CityTableViewCell
        defaults.setObject(cell!.myLabel1.text!, forKey: "cityName")
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            appDelegate.loadMainPages()
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CityTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cell.myLabel1.text = cities[indexPath.row]
        cell.selectionStyle = .Blue
        return cell
    }
}
