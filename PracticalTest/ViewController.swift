//
//  ViewController.swift
//  PracticalTest
//
//  Created by Smeet R. Chavda on 9/4/17.
//  Copyright © 2017 Smeet R. Chavda. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    var item :[String] = []
    var calculate = [Calculate]()
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var clearButtonOutlet: UIButton!
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "ic_home")!)
        textInputValue.delegate = self
        textInputValue.keyboardType = .numberPad
        
        randomButtonConstraint.constant += view.bounds.width
        calculateButtonConstraint.constant += view.bounds.width
        textInputConstraint.constant += view.bounds.width
        resultButtonConstraint.constant += view.bounds.width

        randomButton.layer.cornerRadius = 10
        calculateButton.layer.cornerRadius = 10
        resultButton.layer.cornerRadius = 10
        clearButtonOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func randomNumberAction(_ sender: Any) {

        let lower : UInt32 = 0
        let upper : UInt32 = 9
        for _ in 0 ..< 16 {
            let randomNumber = arc4random_uniform(upper - lower) + lower
            item.append(String(randomNumber))
        }
       
        collectionviewBox.reloadData()
        calculateButton.isEnabled = true
        resultButton.isEnabled = true
        textInputValue.isEnabled = true
        randomButton.isEnabled = false
        
        //To bounce Button
        
        let theButton = sender as! UIButton
        let bounds = theButton.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height) }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: { theButton.bounds = bounds })
            }
        }
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
                let acs = Calculate(calculated: "Count of \(i) is \(count)")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.calculate.append(acs)
            }
        }
        var controller: DetailViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func resultAction(_ sender: Any) {
        calculateButton.isEnabled = false
        textInputValue.isEnabled = false
        resultButton.isEnabled = false
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
            if textInputValue.text == "0"{
                let alertController = UIAlertController()
                alertController.title = "Sorry :("
                alertController.message = "Addition of Zero would be Zero\n Please enter another digit"
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in
                    self.resultButton.isEnabled = true
                    self.textInputValue.isEnabled = true
                }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
            if count != 0{
                for j in 0..<item.count {
                    if firstIndex == j{
                        item[j] = String(count)
                    }else{
                        item[j] = String("")!
                        
                    }
                }
            } else {
                let alertController = UIAlertController()
                alertController.title = "Sorry :("
                alertController.message = "Number is not in the grid"
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in
                    self.resultButton.isEnabled = true
                    self.textInputValue.isEnabled = true
                }
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
            textInputValue.text = ""
            collectionviewBox.reloadData()
        } else {
            let alertController = UIAlertController()
            alertController.title = "Sorry :("
            alertController.message = "Please enter some value in text field"
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ action in
                self.resultButton.isEnabled = true
                self.textInputValue.isEnabled = true
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
        //To bounce Button
        
        let theButton = sender as! UIButton
        let bounds = theButton.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height) }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: { theButton.bounds = bounds })
            }
        }
    }
    
    @IBAction func clearDataAction(_ sender: UIButton) {
        item.removeAll()
        collectionviewBox.reloadData()
        randomButton.isEnabled = true
        calculateButton.isEnabled = false
        resultButton.isEnabled = false
        textInputValue.isEnabled = false
        textInputValue.text = ""
        
        //To bounce Button
        
        let theButton = sender 
        
        let bounds = theButton.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height) }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: { theButton.bounds = bounds })
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 1
        
        /*
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
         
         let allowedCharacters = CharacterSet.decimalDigits
         let characterSet = CharacterSet(charactersIn: string)
         return allowedCharacters.isSuperset(of: characterSet)
        */
    }
 
    // Mark: - For Animation
    
    @IBOutlet weak var randomButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var calculateButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var textInputConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultButtonConstraint: NSLayoutConstraint!
    
    var animationPerformedOnce = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !animationPerformedOnce {
            UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
                self.randomButtonConstraint.constant -= self.view.bounds.width
                self.calculateButtonConstraint.constant -= self.view.bounds.width
                self.textInputConstraint.constant -= self.view.bounds.width
                self.resultButtonConstraint.constant -= self.view.bounds.width
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            animationPerformedOnce = true
        }
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
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 0.5
        cell.lblNo.text = String(self.item[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        animateCell(cell: cell)
    }
    
    func animateCell(cell: UICollectionViewCell) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 200
        cell.layer.cornerRadius = 0
        animation.toValue = 0
        animation.duration = 1
        cell.layer.add(animation, forKey: animation.keyPath)
    }
    
    func animateCellAtIndexPath(indexPath: IndexPath) {
        guard let cell = collectionviewBox.cellForItem(at: indexPath as IndexPath) else { return }
        animateCell(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animateCellAtIndexPath(indexPath: indexPath)
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


