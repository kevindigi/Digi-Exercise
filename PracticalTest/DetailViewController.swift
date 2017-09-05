//
//  DetailViewController.swift
//  PracticalTest
//
//  Created by Smeet R. Chavda on 9/4/17.
//  Copyright © 2017 Smeet R. Chavda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let reuseIdentifier = "TableCell"
    var calculate = [Calculate]()
    
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        calculate = applicationDelegate.calculate
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as UITableViewCell
        let calculate = self.calculate[indexPath.row]
        cell.textLabel?.text = calculate.calculatedText
        return cell
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        applicationDelegate.calculate.removeAll()
        tblView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
