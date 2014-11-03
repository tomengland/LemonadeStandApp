//
//  ViewController.swift
//  LemonadeStandApp
//
//  Created by THOMAS ENGLAND on 11/2/14.
//  Copyright (c) 2014 tomEngland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Current Labels
    @IBOutlet weak var currentMoneyLabel: UILabel!
    @IBOutlet weak var currentLemonsLabel: UILabel!
    @IBOutlet weak var currentIceCubesLabel: UILabel!
    
    // Step #1 outlets
    @IBOutlet weak var purchaseLemonsCountLabel: UILabel!
    @IBOutlet weak var purchaseIceCubesCountLabel: UILabel!
    
    // Step #2 outlets
    @IBOutlet weak var mixLemonsCountLabel: UILabel!
    @IBOutlet weak var mixIceCubesCountLabel: UILabel!
    
    // Properties
    var currentMoney = 10
    var currentLemons = 0
    var currentIceCubes = 0
    var purchaseLemonsCount = 0
    var purchaseIceCubesCount = 0
    var mixLemonsCount = 0
    var mixIceCubesCount = 0
    var lemonadeRatio = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateView()
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Step #1 Buttons
    @IBAction func purchaseLemonsPlusButton(sender: UIButton) {
        self.addLemons()
        
    }
    
    @IBAction func purchaseLemonsMinusButton(sender: UIButton) {
        self.minusLemons()
    
    }
    
    @IBAction func purchaseIceCubesPlusButton(sender: UIButton) {
        self.addIceCubes()
    }
    
    @IBAction func purchaseIceCubesMinusButton(sender: UIButton) {
        self.minusIceCubes()
    }
    
    // Step #2 Buttons
    
    @IBAction func mixLemonsPlusButton(sender: UIButton) {
        self.addMixLemons()
    }
    
    @IBAction func mixLemonsMinusButton(sender: UIButton) {
        self.minusMixLemons()
    
    }
    
    @IBAction func mixIceCubesPlusButton(sender: UIButton) {
        self.addMixIceCubes()
    }
    
    @IBAction func mixIceCubesMinusButton(sender: UIButton) {
        self.minusMixIceCubes()
    }
    
    // Start Day
    
    @IBAction func startDayButton(sender: UIButton) {
    
        if self.checkInventory() {
            self.createRatio()
            self.createCustomers()
            self.resetDay()
        } else {
            println("Make Corrections")
        }
        
    }
    
    // Helper Functions
    
    func updateView() {
        self.currentMoneyLabel.text = "$\(self.currentMoney)"
        self.currentLemonsLabel.text = "\(self.currentLemons) Lemons"
        self.currentIceCubesLabel.text = "\(self.currentIceCubes) Ice Cubes"
        
        // Step #1
        self.purchaseLemonsCountLabel.text = "\(self.purchaseLemonsCount)"
        self.purchaseIceCubesCountLabel.text = "\(self.purchaseIceCubesCount)"
        
        // Step #2
        self.mixLemonsCountLabel.text = "\(self.mixLemonsCount)"
        self.mixIceCubesCountLabel.text = "\(self.mixIceCubesCount)"
    }
    
    func addLemons() {
        if self.currentMoney >= 2 {
            self.purchaseLemonsCount += 1
            self.currentMoney -= 2
            self.currentLemons += 1
            updateView()
        } else {
            println("You don't have enough money to buy more Lemons.")
            showAlertWithText(message: "You don't have enough money to buy more lemons")
        }
        
    }
    
    func minusLemons() {
        if self.purchaseLemonsCount > 0  {
            self.purchaseLemonsCount -= 1
            self.currentMoney += 2
            self.currentLemons -= 1
            updateView()
        } else {
            println("You currently have no purchased Lemons, you can't subtract")
            showAlertWithText(message: "You currently have no purchased Lemons, you can't subtract")
        }
    }
    
    func addIceCubes() {
        if self.currentMoney >= 1 {
            self.purchaseIceCubesCount += 1
            self.currentMoney -= 1
            self.currentIceCubes += 1
            updateView()
        } else {
            println("You don't have enough money to buy more Ice Cubes")
            showAlertWithText(message: "You don't have enough money to buy more Ice Cubes")
        }
    }
    
    func minusIceCubes() {
        if self.purchaseIceCubesCount > 0 {
            self.purchaseIceCubesCount -= 1
            self.currentMoney += 1
            self.currentIceCubes -= 1
            updateView()
        } else {
            println("You currently have no purchased Ice Cubes, you can't subtract")
            showAlertWithText(message: "You currently have no purchased Ice Cubes, you can't subtract")
        }
    }
    
    func addMixLemons() {
        if self.currentLemons > 0 {
            self.currentLemons -= 1
            self.mixLemonsCount += 1
            updateView()
        } else {
            println("You don't have anymore Lemons, please purchase more Lemons")
            showAlertWithText(message: "You don't have anymore Lemons, please purchase more Lemons")
        }
    }
    
    func minusMixLemons() {
        if self.mixLemonsCount > 0 {
            self.mixLemonsCount -= 1
            self.currentLemons += 1
            updateView()
        } else {
            showAlertWithText(message: "You currently have 0 mixed Lemons, you can't subtract")
            println("You currently have 0 mixed Lemons, you can't subtract")
        }
    }
    
    func addMixIceCubes() {
        if self.currentIceCubes > 0 {
            self.mixIceCubesCount += 1
            self.currentIceCubes -= 1
            updateView()
        } else {
            println("You don't have any more Ice Cubes, please purchase more Ice Cubes")
            showAlertWithText(message: "You don't have any more Ice Cubes, please purchase more Ice Cubes")
        }
    }
    
    func minusMixIceCubes() {
        if self.mixIceCubesCount > 0 {
            self.mixIceCubesCount -= 1
            self.currentIceCubes += 1
            updateView()
        } else {
            println("You currently have 0 mixed Ice Cubes, you can't subtract")
            showAlertWithText(message: "You currently have 0 mixed Ice Cubes, you can't subtract")
        }
    }
    func checkInventory() -> Bool {
        if self.currentIceCubes < 0 || self.currentLemons < 0 {
            println("Please adjust your supplies so that it's no longer negative")
            showAlertWithText(message: "Please adjust your supplies so that it's no longer negative")
            return false
        } else if self.mixLemonsCount == 0 || self.mixIceCubesCount == 0 {
            println("Please adjust your mix to include something")
            showAlertWithText(message: "Please adjust your mix to include something")
            return false
        } else {
            println("There is inventory")
            return true
        }
    }
    
    func createRatio() {
        self.lemonadeRatio = (Double(self.mixLemonsCount) / Double(self.mixIceCubesCount))
        }

    func resetDay() {
        
        self.mixIceCubesCount = 0
        self.mixLemonsCount = 0
        self.purchaseIceCubesCount = 0
        self.purchaseLemonsCount = 0
        updateView()
        
    }
    
    func createCustomers() {
        let customerCount = 1 + Double(arc4random_uniform(UInt32(10)))
        
        for var i = 1.0; i <= customerCount; i++ {
            var customerPreference = (1 + Double(arc4random_uniform(UInt32(10)))) / 10
            
            if customerPreference < 0.4 && lemonadeRatio > 1 {
                println("Paid $1")
                println("Customer \(i) paid $1 because their preference was \(customerPreference) and the lemonade ratio was \(lemonadeRatio)")
                currentMoney += 1
            } else if customerPreference >= 0.4 && customerPreference <= 0.6 && lemonadeRatio == 1 {
                println("Paid $1")
                println("Customer \(i) paid $1 because their preference was \(customerPreference) and the lemonade ratio was \(lemonadeRatio)")
                currentMoney += 1
                
                
            } else if customerPreference > 0.6 && lemonadeRatio < 1 {
                println("Paid $1")
                println("Customer \(i) paid $1 because their preference was \(customerPreference) and the lemonade ratio was \(lemonadeRatio)")
                currentMoney += 1
            } else {
                
                println("No Match, No Revnue")
                println("Customer \(i) did not buy because their preference was \(customerPreference) and the lemonade ratio was \(lemonadeRatio)")
                
            }
            
        }
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }


    
    
    
    
    
    
    
    
}

