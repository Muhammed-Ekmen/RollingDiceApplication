//
//  ViewController.swift
//  RollingDiceApplication
//
//  Created by Semih Ekmen on 4.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //PLayer One
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerOneDiceScore: UILabel!
    @IBOutlet weak var playerOneImage: UIImageView!
    //PLayerTwo
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var playerTwoDiceScore: UILabel!
    @IBOutlet weak var playerTwoImage: UIImageView!
    //TOOLS
    @IBOutlet weak var firstDice: UIImageView!
    @IBOutlet weak var gameTurn: UILabel!
    @IBOutlet weak var secondDice: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    //REPO
    var playerDiceScores = (playerOne:0,playerTwo:0)
    var playerScores = (playerOne: 0 , playerTwo: 0)
    var numberOfSet:Int = 5
    var currentSet:Int = 1
    var playerOneTurn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    //Set up background image
    func setBackground(){
        if let background = UIImage(named: "wallpaper"){
            self.view.backgroundColor = UIColor(patternImage: background)
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if currentSet <=  numberOfSet {
            diceShake()
        }else{
            return
        }
    }
    
    func diceShake(){
        let firstRandomNumber:Int = Int.random(in: 1...6)
        let secondRandomNumber:Int = Int.random(in: 1...6)
        if playerOneTurn == true {
            //Player One Turn
            playerOneDiceScore.text = String(firstRandomNumber+secondRandomNumber)
            playerDiceScores.playerOne = firstRandomNumber+secondRandomNumber
            playerOneImage.image = UIImage(named: "wait")
            playerTwoImage.image = UIImage(named: "yourTurn")
            firstDice.image = UIImage(named: String(firstRandomNumber))
            secondDice.image = UIImage(named: String(secondRandomNumber))
            infoLabel.text = "Player 2 Turn"
            gameTurn.text = "Set:\(currentSet)"
            playerOneTurn = false
        }else{
            // Player Two Turn
            playerDiceScores.playerTwo=firstRandomNumber+secondRandomNumber
            playerTwoDiceScore.text = String(firstRandomNumber+secondRandomNumber)
            firstDice.image = UIImage(named: String(firstRandomNumber))
            secondDice.image = UIImage(named: String(secondRandomNumber))
            playerTwoImage.image = UIImage(named: "wait")
            infoLabel.text = "Winner is..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
                if self.playerDiceScores.playerOne > self.playerDiceScores.playerTwo{
                    //Player One WIN
                    self.infoLabel.text = "Winner is PLAYER ONE"
                    self.playerScores.playerOne+=1
                    self.playerOneScore.text = String(self.playerScores.playerOne)
                }else if self.playerDiceScores.playerOne == self.playerDiceScores.playerTwo{
                    self.infoLabel.text = "Draw :)"
                }
                else{
                    //Player Two WIN
                    self.infoLabel.text = "Winner is PLAYER TWO"
                    self.playerScores.playerTwo+=1
                    self.playerTwoScore.text = String(self.playerScores.playerTwo)
                }
                self.currentSet+=1
                self.getDefault()
            }
        }
    }
    
    func getDefault(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            self.playerOneTurn = true
            if self.currentSet <= self.numberOfSet{
                self.infoLabel.text = "Player 1 Turn"
            }else{
                self.infoLabel.text = "GAME FINISH,Winner is \(self.playerScores.playerOne > self.playerScores.playerTwo ? "PLAYER 1" : "PLAYER 2")"
            }
            self.firstDice.image = UIImage(named: "unknownDice")
            self.secondDice.image = UIImage(named: "unknownDice")
            self.playerOneImage.image = UIImage(named: "yourTurn")
            self.playerOneDiceScore.text = "..."
            self.playerTwoDiceScore.text = "..."
            self.playerDiceScores.playerOne = 0
            self.playerDiceScores.playerTwo = 0
        }
    }
}

