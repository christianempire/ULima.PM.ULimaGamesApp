//
//  BlackjackController.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class BlackjackController: UIViewController {
    
    @IBOutlet weak var HouseCard1: CardView!
    @IBOutlet weak var HouseCard2: CardView!
    @IBOutlet weak var HouseCard3: CardView!
    @IBOutlet weak var HouseCard4: CardView!
    @IBOutlet weak var PlayerCard1: CardView!
    @IBOutlet weak var PlayerCard2: CardView!
    @IBOutlet weak var PlayerCard3: CardView!
    @IBOutlet weak var PlayerCard4: CardView!
    @IBOutlet weak var StatusLabel: UILabel!
    
    // Game flags...
    private var _gameIsOver: Bool = false;
    private var _itsPlayersTurn: Bool = true;
    private var _playerChoseToStand: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PlayerCard3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "TapOnPlayerCard3:"));
        PlayerCard4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "TapOnPlayerCard4:"));
        
        Blackjack();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initializes game
    func Blackjack() {
        _gameIsOver = false;
        _itsPlayersTurn = true;
        _playerChoseToStand = false;
        
        let deck = Deck();
        
        HouseCard1.CardObject = deck.DrawCard();
        HouseCard1.RevealCard();
        HouseCard2.CardObject = deck.DrawCard();
        HouseCard2.RevealCard();
        HouseCard3.CardObject = deck.DrawCard();
        HouseCard3.HideCard();
        HouseCard4.CardObject = deck.DrawCard();
        HouseCard4.HideCard();
        PlayerCard1.CardObject = deck.DrawCard();
        PlayerCard1.RevealCard();
        PlayerCard2.CardObject = deck.DrawCard();
        PlayerCard2.RevealCard();
        PlayerCard3.CardObject = deck.DrawCard();
        PlayerCard3.HideCard();
        PlayerCard4.CardObject = deck.DrawCard();
        PlayerCard4.HideCard();
        
        StatusLabel.text = "Blackjack";
        
        ProcessPlay();
    }
    
    // Analyzes the state of the game and makes the house play or ends the game
    func ProcessPlay() {
        let houseTotal = GetHouseTotal();
        let playerTotal = GetPlayerTotal();
        
        // 1. Check for Blackjack
        if houseTotal == 21 {
            _gameIsOver = true
            
            if playerTotal == 21 {
                StatusLabel.text = "Tie";
            } else {
                StatusLabel.text = "House wins";
            }
            
            return;
        } else if playerTotal == 21 {
            _gameIsOver = true
            
            if houseTotal == 21 {
                StatusLabel.text = "Tie";
            } else {
                StatusLabel.text = "Player wins";
            }
            
            return;
        }
        
        // 2. Check for busting
        if houseTotal > 21 {
            StatusLabel.text = "Player wins";
            
            _gameIsOver = true;
            
            return;
        } else if playerTotal > 21 {
            StatusLabel.text = "House wins";
            
            _gameIsOver = true;
            
            return;
        }
        
        // 3. Check for plays left
        if _itsPlayersTurn {
            if _playerChoseToStand {
                _itsPlayersTurn = false;
            } else if !PlayerCard3.CardIsRevealed || !PlayerCard4.CardIsRevealed {
                return;
            }
        } else {
            if !HouseCard3.CardIsRevealed {
                // House plays card 3
                HouseCard3.RevealCard();
                
                _itsPlayersTurn = true;
                
                ProcessPlay();
                
                return;
            } else if !HouseCard4.CardIsRevealed {
                // House plays card 4
                HouseCard4.RevealCard();
                
                _itsPlayersTurn = true;
                
                ProcessPlay();
                
                return;
            }
        }
        
        // 4. Declare winner whoever is closer to Blackjack
        _gameIsOver = true;
        
        let difference = houseTotal - playerTotal;
        
        if difference > 0 {
            StatusLabel.text = "House wins";
        } else if difference == 0 {
            StatusLabel.text = "Tie";
        } else {
            StatusLabel.text = "Player wins";
        }
    }
    
    // Helpers...
    func GetHouseTotal() -> Int {
        var total = 0
        var numberOfAces = 0;
        
        if HouseCard1.CardObject!.IsAce {
            numberOfAces += 1;
        } else {
            total += HouseCard1.CardObject!.Weight;
        }
        
        if HouseCard2.CardObject!.IsAce {
            numberOfAces += 1;
        } else {
            total += HouseCard2.CardObject!.Weight;
        }
        
        if HouseCard3.CardIsRevealed {
            if HouseCard3.CardObject!.IsAce {
                numberOfAces += 1;
            } else {
                total += HouseCard3.CardObject!.Weight;
            }
        }
        
        if HouseCard4.CardIsRevealed {
            if HouseCard4.CardObject!.IsAce {
                numberOfAces += 1;
            } else {
                total += HouseCard4.CardObject!.Weight;
            }
        }
        
        if numberOfAces > 0 {
            return total + GetOptimalAcesContribution(total, numberOfAces);
        } else {
            return total;
        }
    }
    
    func GetPlayerTotal() -> Int {
        var total = 0
        var numberOfAces = 0;
        
        if PlayerCard1.CardObject!.IsAce {
            numberOfAces += 1;
        } else {
            total += PlayerCard1.CardObject!.Weight;
        }
        
        if PlayerCard2.CardObject!.IsAce {
            numberOfAces += 1;
        } else {
            total += PlayerCard2.CardObject!.Weight;
        }
        
        if PlayerCard3.CardIsRevealed {
            if PlayerCard3.CardObject!.IsAce {
                numberOfAces += 1;
            } else {
                total += PlayerCard3.CardObject!.Weight;
            }
        }
        
        if PlayerCard4.CardIsRevealed {
            if PlayerCard4.CardObject!.IsAce {
                numberOfAces += 1;
            } else {
                total += PlayerCard4.CardObject!.Weight;
            }
        }
        
        if numberOfAces > 0 {
            return total + GetOptimalAcesContribution(total, numberOfAces);
        } else {
            return total;
        }
    }
    
    func GetOptimalAcesContribution(total: Int, _ numberOfAces: Int) -> Int {
        var possibleContributions = Array<Int>()
        
        if numberOfAces >= 1 && numberOfAces <= 4 {
            if numberOfAces <= 1 {
                possibleContributions.append(1);
                possibleContributions.append(11);
            }
            
            if numberOfAces <= 2 {
                possibleContributions.append(2);
                possibleContributions.append(12);
            }
            
            if numberOfAces <= 3 {
                possibleContributions.append(3);
                possibleContributions.append(13);
            }
            
            if numberOfAces <= 4 {
                possibleContributions.append(4);
                possibleContributions.append(14);
            }
            
            let totalPossibilities = possibleContributions.count;
            var index = 0;
            var found = false;
            var possibility = 0;
            
            // Find blackjack
            while !found && (index < totalPossibilities) {
                if total + possibleContributions[index] == 21 {
                    possibility = possibleContributions[index];
                    found = true;
                } else {
                    index++;
                }
            }
            
            // Find closest possibility lower than Blackjack
            if !found {
                var min = 21;
                
                for pC in possibleContributions {
                    let newTotal = total + pC;
                    
                    if (newTotal < 21) && (21 - newTotal < min) {
                        min = 21 - newTotal;
                        possibility = pC;
                        found = true;
                    }
                }
            }
            
            // Find closest possibility higher than Blackjack
            if !found {
                var max = 0;
                
                for pC in possibleContributions {
                    let newTotal = total + pC;
                    
                    if (newTotal > 21) && (newTotal - 21 < max) {
                        max = newTotal - 21;
                        possibility = pC;
                    }
                }
            }
            
            return possibility;
            
        } else {
            return 0;
        }
    }
    
    // Game actions...
    func TapOnPlayerCard3(sender: UITapGestureRecognizer) {
        if !_gameIsOver && _itsPlayersTurn && !PlayerCard3.CardIsRevealed {
            PlayerCard3.RevealCard();
            
            _itsPlayersTurn = false;
            
            ProcessPlay();
        }
    }
    
    func TapOnPlayerCard4(sender: UITapGestureRecognizer) {
        if !_gameIsOver && _itsPlayersTurn && !PlayerCard4.CardIsRevealed {
            PlayerCard4.RevealCard();
            
            _itsPlayersTurn = false;
            
            ProcessPlay();
        }
    }
    
    @IBAction func TapOnStandButton(sender: UIButton) {
        if !_gameIsOver && _itsPlayersTurn && !_playerChoseToStand {
            _playerChoseToStand = true;
            _itsPlayersTurn = false;
            
            ProcessPlay();
        }
    }
    
    @IBAction func TapOnResetButton(sender: UIButton) {
        Blackjack();
    }
    
}
