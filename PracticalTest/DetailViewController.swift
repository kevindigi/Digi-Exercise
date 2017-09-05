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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "ic_home")!)
        tblView.backgroundColor = UIColor.clear
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        calculate = applicationDelegate.calculate
        tblView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as UITableViewCell
        let calculate = self.calculate[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = calculate.calculatedText
        cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
        return cell
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        applicationDelegate.calculate.removeAll()
        tblView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    // Mark: - Animation of Table
    
    func animateTable() {
        tblView.reloadData()
        let cells = tblView.visibleCells
        
        let tableViewHeight = tblView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
