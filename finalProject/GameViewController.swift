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
    
    
    //player cannot select fruit or toppings if base isn't selected.
    //player cannot select toppings if fruit isn't selected
    var baseSelected: Bool = false
    var fruitSelected: Bool = false
    var toppingSelected: Bool = false
    
    
    
    @IBOutlet weak var currentCustomer: UIImageView!
    func newCustomer(){
        //called when player takes too long to serve customer or when customer gets their order
        
        //if there's already a customer, make them leave
        if(self.customerLeaving){
            self.customer = false
            self.customerWaiting = 0
            
            //change x value so customer "leaves"
            //goes to x=-200
            
            if(self.currentCustomer.center.x > -300){
                self.currentCustomer.center.x -= 2
                print(self.currentCustomer.center.x)
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
            print(currentCustomer.center.x)
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
                    print ("Waited for: ", self.customerWaiting, " seconds")
                    if(self.customerWaiting >= self.customerWaitTime){
                        self.customerLeaving = true
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
                            print(self.currentCustomer.center.x)
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
                        print(self.currentCustomer.center.x)
                    }
                    else {
                        self.customer = true; //starts timer for customer wait time
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
    }
    
    //smoothie bases
    @IBAction func addMangoBase(_ sender: Any) {
        if(!baseSelected){
            print("mangoBase")
            baseSelected = true;
        }
    }
    
    @IBAction func addStrawberryBase(_ sender: Any) {
        if(!baseSelected){
            print("strawberryBase")
            baseSelected = true;
        }
    }
    
    @IBAction func addKiwiBase(_ sender: Any) {
        if(!baseSelected){
            print("kiwiBase")
            baseSelected = true;
        }
    }
    
    //fruits
    @IBAction func addStrawberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            print("strawberry")
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBanana(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            print("banana")
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addGrape(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            print("grape")
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    @IBAction func addBlueberry(_ sender: Any) {
        if(baseSelected && !fruitSelected){
            print("blueberry")
            fruitSelected = true
        }
        else {
            print("select a base first")
        }
    }
    
    //toppings
    @IBAction func addPeanuts(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            print("peanuts")
            toppingSelected = true
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addHoney(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            print("honey")
            toppingSelected = true
        }
        else {
            print("make sure you have a base and fruit")
        }
    }
    
    @IBAction func addGranola(_ sender: Any) {
        if(baseSelected && fruitSelected && !toppingSelected){
            print("granola")
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
        
        //start game
        //if(gameStarted) { startTimer() }
    }
}
