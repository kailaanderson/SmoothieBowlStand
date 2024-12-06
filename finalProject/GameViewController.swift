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
    
    //game functionality
    @IBOutlet weak var timeLeftText: UILabel!
    @IBOutlet weak var coinsEarnedText: UILabel!
    
    var gameOver : Bool = false;
    var gameStarted : Bool = false;
    var gamePaused : Bool = false;
    
    
    //player cannot select fruit or toppings if base isn't selected.
    //player cannot select toppings if fruit isn't selected
    var baseSelected: Bool = false
    var fruitSelected: Bool = false
    var toppingSelected: Bool = false
    
    
    
    
    
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
        if(gameStarted) { startTimer() }
    }
}
