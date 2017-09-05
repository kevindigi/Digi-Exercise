//
//  ViewController.swift
//  PracticalTest
//
//  Created by Smeet R. Chavda on 9/4/17.
//  Copyright © 2017 Smeet R. Chavda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var item :[Int] = []
    var calculate = [Calculate]()
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var textInputValue: UITextField!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var collectionviewBox: UICollectionView!
    let reuseIdentifier = "CollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        calculateButton.isEnabled = false
        resultButton.isEnabled = false
        textInputValue.isEnabled = false
        calculateCellSize(self.view.frame.size, itemCount: 4)
        collectionviewBox.backgroundColor = UIColor.clear
    }
    
    @IBAction func randomNumberAction(_ sender: Any) {

        let lower : UInt32 = 0
        let upper : UInt32 = 9
        for _ in 0 ..< 16 {
            let randomNumber = arc4random_uniform(upper - lower) + lower
            item.append(Int(randomNumber))
        }
       
        collectionviewBox.reloadData()
        calculateButton.isEnabled = true
        resultButton.isEnabled = true
        textInputValue.isEnabled = true
        randomButton.isEnabled = false
    }
    
    @IBAction func calculateAction(_ sender: Any) {
        for i in 0 ... 9 {
            var count = 0
            for j in 0 ..< item.count {
                let number = Int(item[j])
                if i == number{
                    count = count + 1
                }
            }
            if count != 0{
                let acs = Calculate(calculated: "count of \(i) is \(count)")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.calculate.append(acs)
            }
        }
        var controller: DetailViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func resultAction(_ sender: Any) {
        if textInputValue.text != "" {
            var count :Int = 0
            let inputNumbr = Int(textInputValue.text!)
            var firstIndex:Int? = nil
            
            for j in 0 ..< item.count {
                let number = Int(item[j])
                if inputNumbr == number{
                    if firstIndex == nil {
                        firstIndex = j
                    }
                    count = count + inputNumbr!
                }
            }
            if count != 0{
                for j in 0..<item.count {
                    if firstIndex == j{
                        item[j] = count
                    }else{
                        item[j] = 0
                    }
                }
            } else if count == 0 {
                let alertController = UIAlertController()
                alertController.title = "Sorry :("
                alertController.message = "Addition of zero would be zero"
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController()
                alertController.title = "Sorry :("
                alertController.message = "Number is not in the grid"
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
            collectionviewBox.reloadData()
        } else {
            let alertController = UIAlertController()
            alertController.title = "Sorry :("
            alertController.message = "Please enter some value in text field"
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        randomButton.isEnabled = true
        calculateButton.isEnabled = false
        resultButton.isEnabled = false
        textInputValue.isEnabled = false
    }
    
    @IBAction func clearDataAction(_ sender: UIButton) {
        item.removeAll()
        collectionviewBox.reloadData()
        randomButton.isEnabled = true
        calculateButton.isEnabled = false
        resultButton.isEnabled = false
        textInputValue.isEnabled = false
    }
}

extension ViewController :UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    // MARK: - UICollectionView protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionviewBox.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 0.5
        cell.lblNo.text = String(self.item[indexPath.row])
        return cell
    }
    
    //Mark: - UICollectionViewDelegateFlowLayout Protocol
    
    func calculateCellSize(_ size: CGSize, itemCount: Int) {
        let cvFlowLayout = collectionViewFlowLayout!
        let cvSize = size
        var cellSize = CGSize()
        
        let minimumInteritemSpacingMultiplier:CGFloat = CGFloat(itemCount - 1)
        
        cellSize.width = (cvSize.width - (cvFlowLayout.minimumInteritemSpacing * minimumInteritemSpacingMultiplier + cvFlowLayout.sectionInset.left + cvFlowLayout.sectionInset.right )) / CGFloat(itemCount)
        cellSize.height = cellSize.width
        cvFlowLayout.itemSize = cellSize
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        calculateCellSize(size, itemCount: 4)
    }
}


