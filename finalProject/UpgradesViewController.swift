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
    
    //button variables
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var stereoButton: UIButton!
    @IBOutlet weak var ingredientsButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    
    @IBAction func purchaseTipJar(_ sender: Any) {
        if(coins >= 150){
            coins -= 150
            tipJar = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
        tipsButton.titleLabel?.text = "Bought"
    }
    
    @IBAction func purchasePhotos(_ sender: Any) {
        if(coins >= 300){
            coins -= 300
            photos = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
        photosButton.titleLabel?.text = "Bought"
    }
    
    @IBAction func purchaseStereo(_ sender: Any) {
        if(coins >= 500){
            coins -= 500
            stereo = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
        stereoButton.titleLabel?.text = "Bought"
    }
    
    @IBAction func purchaseBetterIngredients(_ sender: Any) {
        if(coins >= 550){
            coins -= 550
            ingredients = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
        ingredientsButton.titleLabel?.text = "Bought"
    }
    
    @IBAction func purchaseBetterStand(_ sender: Any) {
        if(coins > 800){
            coins -= 800
            stand = true
            coinsLabel.text = String(coins)
            upgradesBought += 1
        }
        standButton.titleLabel?.text = "Bought"
    }
    
    //send back remaining coins and upgrades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Check if the segue is the one to UpgradesViewController
            if segue.identifier == "toGameVC" {
                // Get a reference to the destination view controller
                if let gameVC = segue.destination as? GameViewController {
                    // Pass data to GameViewController
                    gameVC.coinsAfterUpdates = self.coins
                    gameVC.tipJar = self.tipJar
                    gameVC.photos = self.photos
                    gameVC.stereo = self.stereo
                    gameVC.betterIngredients = self.ingredients
                    gameVC.betterStand = self.stand
                }
            }
    }
    
    @IBAction func startNewDay(_ sender: Any) {
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    

    
}
