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
    
    //timers
    var timerRunning : Bool = false
    var timeMinutes : Int = 9
    var timeSeconds : Int = 0
    
    var customer = false //if customer is true, there's an order taking place
    //when customer is false, wait until customer leaves screen to add another customer to screen
    var customerLeaving = false
    var customerX : Double = 0;
    
    //game functionality
    @IBOutlet weak var timeLeftText: UILabel!
    @IBOutlet weak var coinsEarnedText: UILabel!
    
    var gameOver : Bool = false;
    var gameStarted : Bool = false;
    var gamePaused : Bool = false;
    
    var customerWaiting = 0
    var customerWaitTime = 20
    
    //available options
    var smoothieBase = ["Mango", "Strawberry", "Kiwi"]
    var fruit = ["Strawberry", "Banana", "Grape", "Blueberry"]
    var topping = ["Peanut", "Honey", "Granola"]
    
    var currentOrder = [String]()
    var userInput = ["Smoothie", "Fruit", "Topping"]
    
    
    //player cannot select fruit or toppings if base isn't selected.
    //player cannot select toppings if fruit isn't selected
    var baseSelected: Bool = false
    var fruitSelected: Bool = false
    var toppingSelected: Bool = false
        
    @IBOutlet weak var serveButton: UIButton!
    
    @IBOutlet weak var currentCustomer: UIImageView!
    
    
    
    @IBAction func serveOrder(_ sender: Any) {
        self.serveButton.isHidden = true

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
    
    func randomOrder(){
        let randomBase = Int.random(in: 0...2) //get random base
        let randomFruit = Int.random(in: 0...3) //random fruit
        let randomTopping = Int.random(in: 0...2) //random topping
        
        self.currentOrder = [self.smoothieBase[randomBase], self.fruit[randomFruit], self.topping[randomTopping]]
        
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
     
    
    //game buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startButtonImage: UIImageView!
    @IBAction func startGame(_ sender: Any) {
        timerRunning = true
        gameStarted = true
        startButtonImage.isHidden = true
        startButton.isHidden = true
        startTimer()
        customerTimer()
    }
    
    
    @IBOutlet weak var closeStandButton: UIButton!
    @IBOutlet weak var endButtonImage: UIImageView!
    @IBAction func endButton(_ sender: Any) {
        //go to upgrades scene
    }
    
    func endGame(){
        endButtonImage.isHidden = false
        closeStandButton.isHidden = false
        self.gameOver = true
        self.timerRunning = false
        totalCoins += currentCoins
    }
    
    //smoothie bases
    @IBAction func addMangoBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Mango"
            baseSelected = true;
        }
    }
    
    @IBAction func addStrawberryBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Strawberry"
            baseSelected = true;
        }
    }
    
    @IBAction func addKiwiBase(_ sender: Any) {
        if(!baseSelected){
            userInput[0] = "Kiwi"
            baseSelected = true;
        }
    }
    
    //fruits
    @IBAction func addStrawberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            fruitSelected = true
            userInput[1] = "Strawberry"
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBanana(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Banana"
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addGrape(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Grape"
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBlueberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            userInput[1] = "Blueberry"
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    //toppings
    @IBAction func addPeanuts(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Peanut"
            toppingSelected = true
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addHoney(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Honey"
            toppingSelected = true
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addGranola(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            userInput[2] = "Granola"
            toppingSelected = true
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    
    func resetGame(){
        baseSelected = false
        fruitSelected = false
        toppingSelected = false
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
        
        //reset variables
        resetGame()
        
    }
}
