//
//  GameViewController.swift
//  finalProject
//
//  Created by Guest User on 12/4/24.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    
    //player variables
    var currentCoins : Int = 0
    var tipsRate : Int = 10 //how many tips the player gets per quick order
    
    //achievement variables
    var totalCoins: Int = 0
    var totalCustomersServed: Int = 0
    var coinsAfterUpdates : Int = 0
    
    //timers
    var timerRunning : Bool = false
    var timeMinutes : Int = 11
    var timeSeconds : Int = 0
    
    var customer = false //if customer is true, there's an order taking place
    //when customer is false, wait until customer leaves screen to add another customer to screen
    var customerLeaving = false
    var customerX : Double = 0;
    
    //game functionality
    @IBOutlet weak var timeLeftText: UILabel!
    @IBOutlet weak var coinsEarnedText: UILabel!
    @IBOutlet weak var orderView: UIImageView!
    @IBOutlet weak var smoothieOrderView: UIImageView!
    @IBOutlet weak var fruitOrderView: UIImageView!
    @IBOutlet weak var syrupOrderView: UIImageView!
    @IBOutlet weak var syrupImage: UIImageView!
    @IBOutlet weak var smoothieImage: UIImageView!
    @IBOutlet weak var fruitImage: UIImageView!
    
    //upgrades
    var tipJar : Bool = false
    var photos : Bool = false
    var stereo : Bool = false
    var betterIngredients : Bool = false
    var betterStand : Bool = false
    
    var gameOver : Bool = false
    var gameStarted : Bool = false
    var gamePaused : Bool = false
    
    var customerWaiting = 0
    var customerWaitTime = 20
    
    //available options
    var smoothieBase = ["Mango", "Strawberry", "Kiwi"]
    var fruit = ["Raspberry", "Banana", "Grape", "Blueberry"]
    var topping = ["Blueberry Syrup", "Honey", "Strawberry Syrup"]
    
    var currentOrder = [String]()
    var userInput = ["Smoothie", "Fruit", "Topping"]
    
    
    //player cannot select fruit or toppings if base isn't selected.
    //player cannot select toppings if fruit isn't selected
    var baseSelected: Bool = false
    var fruitSelected: Bool = false
    var toppingSelected: Bool = false
        
    @IBOutlet weak var serveButton: UIButton!
    
    @IBOutlet weak var currentCustomer: UIImageView!
    @IBAction func pauseButton(_ sender: Any) {
        gamePaused = !gamePaused
    }
    
    
    func removeOrder(){
        fruitImage.image = UIImage(named: " ")
        smoothieImage.image = UIImage(named: " ")
        syrupImage.image = UIImage(named: " ")
    }
    
    func assembleOrder(){
        if(!gameOver && !gamePaused){
            if(baseSelected){
                smoothieImage.isHidden = false
                let currentBase : String = userInput[0] + "Bowl"
                smoothieImage.image = UIImage(named: currentBase)
            }
            else {smoothieImage.image = UIImage(named: " ")}
            
            if(fruitSelected){
                fruitImage.isHidden = false
                fruitImage.image = UIImage(named: userInput[1])
            }
            else {fruitImage.image = UIImage(named: " ")}
            
            if(toppingSelected){
                syrupImage.isHidden = false
                syrupImage.image = UIImage(named: userInput[2])
            }
            else {syrupImage.image = UIImage(named: " ")}
        }
    }
    
    @IBAction func serveOrder(_ sender: Any) {
        //hide order
        self.serveButton.isHidden = true
        self.orderView.isHidden = true
        self.smoothieOrderView.isHidden = true
        self.fruitOrderView.isHidden = true
        self.syrupOrderView.isHidden = true

        //for debugging
        print("Your order: ")
        for item in userInput {
            print(item, " ")
        }
        
        print("done in ", customerWaiting, " second")
        
        self.customer = false
        self.customerLeaving = true
        
        if(correctOrder()){
            print("Order was correct")
            totalCustomersServed += 1
            if(self.customerWaiting <= 10){
                currentCoins += tipsRate
                print("earned 10 coins")
            }
            else {
                print("earned 5 coins")
                currentCoins += tipsRate/2
            }
        }
        else {
            print("order was incorrect")
            currentCoins -= 5
            if(currentCoins <= 0){ currentCoins = 0 }
        }
        updateText()
        resetGame()
    }
    
    @IBAction func trashOrder(_ sender: Any) {
        //reset smoothie bowl
        resetGame()
        //removeOrder()
        currentCoins -= 5
        if(currentCoins <= 0) {currentCoins = 0}
    }
    
    func randomOrder(){
        //create random order
        let randomBase = Int.random(in: 0...2) //get random base
        let randomFruit = Int.random(in: 0...3) //random fruit
        let randomTopping = Int.random(in: 0...2) //random topping
        
        self.currentOrder = [self.smoothieBase[randomBase], self.fruit[randomFruit], self.topping[randomTopping]]
        
        //display random order
        self.orderView.isHidden = false
        self.smoothieOrderView.isHidden = false
        self.fruitOrderView.isHidden = false
        self.syrupOrderView.isHidden = false
        
        //smoothie base
        switch(currentOrder[0]){
        case "Mango" :
            self.smoothieOrderView.image = UIImage(named: "Mango")
            break
        case "Strawberry":
            self.smoothieOrderView.image = UIImage(named: "Strawberry")
            break
        case "Kiwi":
            self.smoothieOrderView.image = UIImage(named: "Kiwi")
            break
        default:
            self.smoothieOrderView.isHidden = true
        }
        
        //fruit
        switch(currentOrder[1]){
        case "Raspberry":
            self.fruitOrderView.image = UIImage(named: "raspberryOrder")
            break
        case "Banana":
            self.fruitOrderView.image = UIImage(named: "bananaOrder")
            break
        case "Grape":
            self.fruitOrderView.image = UIImage(named: "grapeOrder")
            break
        case "Blueberry":
            self.fruitOrderView.image = UIImage(named: "blueberryOrder")
            break
        default:
            self.fruitOrderView.isHidden = true
        }
        
        //syrup
        switch(currentOrder[2]){
        case "Blueberry Syrup":
            self.syrupOrderView.image = UIImage(named: "Blueberry Syrup")
            break
        case "Honey":
            self.syrupOrderView.image = UIImage(named: "Honey")
            break
        case "Strawberry Syrup":
            self.syrupOrderView.image = UIImage(named: "Strawberry Syrup")
            break
        default:
            self.syrupOrderView.isHidden = true
        }
        
        print("Customer order: ")
        for item in currentOrder {
            print(item, " ")
        }
    }
    
    func correctOrder() -> Bool {
        return currentOrder == userInput
    }
    
    func newCustomer(){
        //called when player takes too long to serve customer or when customer receives their order

        //if there's already a customer, make them leave
        if(self.customerLeaving){
            self.customer = false
            self.customerWaiting = 0
            
            //change x value so customer "leaves"
            //goes to x=-200
            
            if(self.currentCustomer.center.x > -300){
                self.currentCustomer.center.x -= 2
            }
            else {
                self.customerLeaving = false
                self.currentCustomer.center.x = 499 //put customer on right side of screen
            }
            //change image to different random customer image
        }
        //bring new customer
        //change x value so customer "appears"
        //starts at x=400, ends at x=190
        if (self.currentCustomer.center.x > 289){
            self.currentCustomer.center.x -= 1
        }
        else {
            customer = true; //starts timer for customer wait time
            
        }
    }
    
    func updateText(){
        timeLeftText.text = String(timeMinutes) + ":"
        if timeSeconds / 10 < 1 {
            timeLeftText.text! += "0"
        }
        timeLeftText.text! += String(timeSeconds)
        coinsEarnedText.text = String(currentCoins)
    }
    
    //game timer
    
    func startTimer(){
        if(timerRunning){
            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
                
                if(self.timerRunning){
                    if self.timeSeconds < 59 {
                        self.timeSeconds += 1
                        
                    }
                    else {
                        self.timeMinutes += 1
                        self.timeSeconds = 0
                        if self.timeMinutes == 12 {
                            self.endGame()
                        }
                    }
                    self.updateText()
                }
                
                if(self.customer){
                    self.customerWaiting += 1
                    //print ("Waited for: ", self.customerWaiting, " seconds")
                    if(self.customerWaiting >= self.customerWaitTime){
                        self.customerLeaving = true
                        self.resetGame()
                        //self.newCustomer()
                    }
                }
            }
                
        }
    }
    
    //customer movement timer
    func customerTimer(){
        if(timerRunning){
            _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
                (timer) in
                
                if(self.timerRunning){
                    if(self.toppingSelected){
                        self.serveButton.isHidden = false
                    }
                    
                    //if there's no customer (order finished/player ran out of time to serve customer/game just started) bring in a new customer
                    if(self.customerLeaving){
                        self.customer = false
                        self.customerWaiting = 0
                    }
                    
                    if (!self.customer && self.gameStarted) {
                        //self.newCustomer()
                        //called when player takes too long to serve customer or when customer gets their order
                        
                        //if there's already a customer, make them leave
                        if(self.customerLeaving){
                            //change x value so customer "leaves"
                            //goes to x=-200
                            
                            if(self.currentCustomer.center.x > -300){
                                self.currentCustomer.center.x -= 2
                            }
                            else {
                                self.customerLeaving = false
                                self.currentCustomer.center.x = 499 //put customer on right side of screen
                            }
                            //change image to different random customer image
                        }
                        
                        //bring new customer
                        //change x value so customer "appears"
                        //starts at x=400, ends at x=190
                        if (!self.customerLeaving && self.currentCustomer.center.x > 289){
                            self.currentCustomer.center.x -= 1
                        }
                        else {
                            self.customer = true; //starts timer for customer wait time
                            if(self.customer && !self.customerLeaving) { self.randomOrder() }
                        }
                    }
                }
            }
              
        }
    }
    
    @IBOutlet weak var tipJarImage: UIImageView!
    @IBOutlet weak var photosDisplay: UIImageView!
    @IBOutlet weak var stereoImage: UIImageView!
    @IBOutlet weak var standImage: UIImageView!
    
    func displayUpgrades(){
        if(tipJar){
            //image
            tipJarImage.isHidden = false
            //upgrade
            tipsRate += 10
        }
        if(photos){
            //image
            photosDisplay.isHidden = false
            //upgrade
            customerWaitTime += 5
        }
        if(stereo){
            //image
            stereoImage.isHidden = false
            //upgrade
            customerWaitTime += 5
        }
        if(betterIngredients){
            //upgrade
            tipsRate += 10
        }
        if(betterStand){
            //image
            standImage.image = UIImage(named: "New Fruit Stand")
        }
    }
     
    
    //game buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startButtonImage: UIImageView!
    @IBAction func startGame(_ sender: Any) {
        timerRunning = true
        gameStarted = true
        startButtonImage.isHidden = true
        startButton.isHidden = true
        self.currentCustomer.isHidden = false
        startTimer()
        customerTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Check if the segue is the one to UpgradesViewController
            if segue.identifier == "toUpgradesVC" {
                // Get a reference to the destination view controller
                if let upgradesVC = segue.destination as? UpgradesViewController {
                    // Pass data to UpgradesViewController
                    upgradesVC.coins = self.totalCoins
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Reload the totalCoins from UserDefaults to reflect any updates from UpgradesViewController
            totalCoins = coinsAfterUpdates
        }
    
    @IBOutlet weak var closeStandButton: UIButton!
    @IBOutlet weak var endButtonImage: UIImageView!
    @IBAction func endButton(_ sender: UIButton) {
        //go to upgrades scene
        performSegue(withIdentifier: "toUpgradesVC", sender: self)
    }
    
    func endGame(){
        endButtonImage.isHidden = false
        closeStandButton.isHidden = false
        self.gameOver = true
        self.timerRunning = false
        totalCoins += currentCoins
        self.currentCustomer.isHidden = true
        
        //update user defaults
        UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
    }
    
    //smoothie bases
    @IBAction func addMangoBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Mango"
            baseSelected = true;
            self.assembleOrder()

        }
    }
    
    @IBAction func addStrawberryBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Strawberry"
            baseSelected = true;
            self.assembleOrder()

        }
    }
    
    @IBAction func addKiwiBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Kiwi"
            baseSelected = true;
            self.assembleOrder()

        }
    }
    
    //fruits
    @IBAction func addRaspberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            fruitSelected = true
            userInput[1] = "Raspberry"
            self.assembleOrder()

        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBanana(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Banana"
            fruitSelected = true
            self.assembleOrder()

        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addGrape(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Grape"
            fruitSelected = true
            self.assembleOrder()

        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBlueberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Blueberry"
            fruitSelected = true
            self.assembleOrder()

        }
        else {
            print("select a base first")
        }
    }
    
    //toppings
    @IBAction func addBlueberrySyrup(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Blueberry Syrup"
            toppingSelected = true
            self.assembleOrder()

        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addHoney(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Honey"
            toppingSelected = true
            self.assembleOrder()
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addStrawberrySyrup(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Strawberry Syrup"
            toppingSelected = true
            self.assembleOrder()
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    
    func resetGame(){
        baseSelected = false
        fruitSelected = false
        toppingSelected = false
        removeOrder()
    }
    
    override func viewDidLoad() {
        print("loaded game")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timeLeftText.text = String(timeMinutes) + ":"
        if timeSeconds / 10 < 1 {
            timeLeftText.text! += "0"
        }
        timeLeftText.text! += String(timeSeconds)
        coinsEarnedText.text = String(currentCoins)
        
        //user defaults to store data
        totalCoins = UserDefaults.standard.integer(forKey: "totalCoins")
        
        //reset variables
        resetGame()
        displayUpgrades()
        
    }
}
