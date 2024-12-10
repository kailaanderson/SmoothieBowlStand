//
//  UpgradesViewController.swift
//  finalProject
//
//  Created by Guest User on 12/10/24.
//

import UIKit

class UpgradesViewController: UIViewController {
    
    @IBOutlet weak var coinsLabel: UILabel!
    
    
    var coins : Int = 0
    var upgradesBought = 0
    var tipJar : Bool = false
    var photos : Bool = false
    var stereo : Bool = false
    var ingredients : Bool = false
    var stand : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinsLabel.text = String(coins)
    }
    
    @IBAction func purchaseTipJar(_ sender: Any) {
        if(coins >= 150){
            coins -= 150
            tipJar = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchasePhotos(_ sender: Any) {
        if(coins >= 300){
            coins -= 300
            photos = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseStereo(_ sender: Any) {
        if(coins >= 500){
            coins -= 500
            stereo = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseBetterIngredients(_ sender: Any) {
        if(coins >= 550){
            coins -= 550
            ingredients = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseBetterStand(_ sender: Any) {
        if(coins > 800){
            coins -= 800
            stand = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    //send back remaining coins and upgrades
    
    

    
}