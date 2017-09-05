//
//  DetailTableViewController.swift
//  PracticalTest
//
//  Created by Smeet R. Chavda on 9/4/17.
//  Copyright © 2017 Smeet R. Chavda. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    let reuseIdentifier = "TableCell"
    var calculate = [Calculate]()
    
    override func viewWillAppear(_ animated: Bool) {
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        calculate = applicationDelegate.calculate
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as UITableViewCell
        let calculate = self.calculate[indexPath.row]
        cell.textLabel?.text = calculate.calculatedText
        return cell
    }
}
