//
//  UpgradesViewController.swift
//  finalProject
//
//  Created by Guest User on 12/10/24.
//

import UIKit

class UpgradesViewController: UIViewController {
    
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var coinAchievement: UILabel!
    @IBOutlet weak var customerAchievement: UILabel!
    @IBOutlet weak var upgradeAchievement: UILabel!
    
    
    var gameVC : GameViewController?
    var coins : Int = 0
    var upgradesBought = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        var availableCoins : Int = gameVC?.totalCoins ?? 0
        var customers : Int = gameVC?.totalCustomersServed ?? 0
        coinsLabel.text = String(availableCoins)
        coins = availableCoins
        
        //update achievement labels
        coinAchievement.text = String(coins) + "/1000 Coins Earned"
        customerAchievement.text = String(customers) + "/200 Customers Served"
        upgradeAchievement.text = String(upgradesBought) + "/5 Upgrades Bought"
    }
    
    @IBAction func purchaseTipJar(_ sender: Any) {
        if(coins >= 100){
            coins -= 100
            gameVC?.tipJar = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchasePhotos(_ sender: Any) {
        if(coins >= 100){
            coins -= 100
            gameVC?.photos = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseStereo(_ sender: Any) {
        if(coins >= 200){
            coins -= 200
            gameVC?.stereo = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseBetterIngredients(_ sender: Any) {
        if(coins >= 300){
            coins -= 300
            gameVC?.betterIngredients = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    @IBAction func purchaseBetterStand(_ sender: Any) {
        if(coins > 500){
            coins -= 500
            gameVC?.betterStand = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
    }
    
    
    
    

    
}
