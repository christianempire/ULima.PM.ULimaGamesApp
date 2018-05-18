//
//  GoController.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit;

class GoController: UIViewController {
    private let _player1Symbol = "⚪";
    private let _player2Symbol = "⚫";
    
    private var _gameIsOver = false;
    private var _grid = Grid();
    private var _itsPlayer1sTurn = true;
    @IBOutlet weak private var _scoreLabel: UILabel!
    @IBOutlet weak private var _statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DrawGrid();
        RestartGame();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func DrawGrid() {
        _grid.Build(self);
        
        for stone in _grid.Stones {
            stone.View.PlayButton.addTarget(self, action: "TapOnStone:", forControlEvents: .TouchUpInside);
        }
    }
    
    private func ProcessPlay() {
        let state = _grid.GetState();
        
        if state != GoStates.NoWinner {
            if state == _player1Symbol {
                _statusLabel.text = "\(_player1Symbol) wins!";
            } else if state == _player2Symbol {
                _statusLabel.text = "\(_player2Symbol) wins!";
            } else if state == GoStates.Tie {
                _statusLabel.text = "Tie!";
            } else {
                _statusLabel.text = "Game over!";
            }
            
            _gameIsOver = true;
            
            return;
        }
        
        _itsPlayer1sTurn = !_itsPlayer1sTurn;
        
        if _itsPlayer1sTurn {
            _statusLabel.text = "\(_player1Symbol)'s turn";
        } else {
            _statusLabel.text = "\(_player2Symbol)'s turn";
        }
        
        UpdateScores();
    }
    
    private func RedrawGrid() {
        _grid.Destroy();
        _grid = Grid();
        
        DrawGrid();
    }
    
    private func RestartGame() {
        _gameIsOver = false;
        _itsPlayer1sTurn = true;
        _statusLabel.text = "\(_player1Symbol)'s turn";
        
        UpdateScores();
    }
        
    @IBAction func TapOnResetButton(sender: AnyObject) {
        RedrawGrid();
        RestartGame();
    }
        
    func TapOnStone(sender: UIButton) {
        if _gameIsOver {
            return;
        }
        
        let identifier = sender.tag;
        let stoneView = _grid.GetStoneByIdentifier(identifier).View;
        
        if !stoneView.StoneWasPlayed {
            if _itsPlayer1sTurn {
                stoneView.PlayStone(_player1Symbol);
            } else {
                stoneView.PlayStone(_player2Symbol);
            }
            
            ProcessPlay();
        }
    }
    
    private func UpdateScores() {
        var scoresString = "";
        
        for (player, score) in _grid.GetScores() {
            scoresString += "\(player): \(score)  ";
        }
        
        _scoreLabel.text = scoresString;
    }
}
