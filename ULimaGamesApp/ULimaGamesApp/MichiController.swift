//
//  MichiController.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class MichiController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak private var _sizeTextField: UITextField!
    @IBOutlet weak private var _statusLabel: UILabel!
    
    private let _boardSizes = [3, 4, 5];
    private let _player1Symbol = "🐶";
    private let _player2Symbol = "🎃";
    
    private var _board = Michi(boardSize: 3);
    private var _gameIsOver = false;
    private var _itsPlayer1sTurn = true;
    private var _sizePicker = UIPickerView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        InitSizeSelector();
        DrawBoard();
        RestartGame();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _boardSizes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(_boardSizes[row]);
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _sizeTextField.text = String(_boardSizes[row]);
        _sizeTextField.resignFirstResponder();
        
        RedrawBoard(_boardSizes[row]);
        RestartGame();
    }
    
    private func ProcessPlay() {
        let state = _board.GetState();
        
        if state != MichiStates.NoWinner {
            if state == _player1Symbol {
                _statusLabel.text = "\(_player1Symbol) wins!";
            } else if state == _player2Symbol {
                _statusLabel.text = "\(_player2Symbol) wins!";
            } else if state == MichiStates.Tie {
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
    }
    
    private func DrawBoard() {
        _board.BuildBoard(self);
        
        for square in _board.Squares {
            square.View.PlayButton.addTarget(self, action: "TapOnSquare:", forControlEvents: .TouchUpInside);
        }
    }
    
    private func InitSizeSelector() {
        _sizePicker.delegate = self;
        _sizePicker.dataSource = self;
        _sizeTextField.inputView = _sizePicker;
        _sizeTextField.text = "3";
    }
    
    private func RedrawBoard(size: Int) {
        _board.DestroyBoard();
        _board = Michi(boardSize: size);
        
        DrawBoard();
    }
    
    private func RestartGame() {
        _gameIsOver = false;
        _itsPlayer1sTurn = true;
        _statusLabel.text = "\(_player1Symbol)'s turn";
    }
    
    func TapOnSquare(sender: UIButton) {
        if _gameIsOver {
            return;
        }
        
        let identifier = sender.tag;
        let squareView = _board.GetSquareByIdentifier(identifier).View;
        
        if !squareView.SquareWasPlayed {
            if _itsPlayer1sTurn {
                squareView.PlaySquare(_player1Symbol);
            } else {
                squareView.PlaySquare(_player2Symbol);
            }
            
            ProcessPlay();
        }
    }
    
    @IBAction func TapOnResetButton(sender: AnyObject) {
        RedrawBoard(Int(_sizeTextField.text!)!);
        RestartGame();
    }
}
