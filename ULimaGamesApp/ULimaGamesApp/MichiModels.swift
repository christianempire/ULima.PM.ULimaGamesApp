//
//  MichiModels.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/15/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation;
import UIKit;

class Michi {
    private var _boardSize: Int;
    private var _squares: Array<Square>;
    
    var BoardSize: Int {
        get {
            return _boardSize;
        }
    }
    
    var Squares: Array<Square> {
        get {
            return _squares;
        }
    }
    
    init (boardSize: Int) {
        _boardSize = boardSize;
        _squares = Array<Square>();
        
        var squareIndex = 0;
        let initialX = 20;
        let initialY = 124;
        let squareMargin = 10;
        let squareSize = Int((360 - ((boardSize - 1) * squareMargin)) / boardSize);
        
        for i in 1...boardSize {
            for j in 1...boardSize {
                let view = SquareView();
                let x = initialX + (j - 1) * (squareMargin + squareSize);
                let y = initialY + (i - 1) * (squareMargin + squareSize);
                
                view.frame = CGRect(x: x, y: y, width: squareSize, height: squareSize);
                
                _squares.append(Square(view: view, xCoordinate: i, yCoordinate: j, identifier: squareIndex++));
            }
        }
    }
    
    func BuildBoard (vc: UIViewController) {
        for square in _squares {
            vc.view.addSubview(square.View);
        }
    }
    
    func DestroyBoard() {
        for square in _squares {
            square.View.removeFromSuperview();
        }
    }
    
    func GetSquareByCoordinates(xCoordinate: Int, _ yCoordinate: Int) -> Square {
        var squareIndex = 0;
        var squareFound = false;
        var square: Square?;
        
        while !squareFound && (squareIndex < _squares.count) {
            square = _squares[squareIndex];
            
            if (square!.XCoordinate == xCoordinate) && (square!.YCoordinate == yCoordinate) {
                squareFound = true;
            } else {
                squareIndex++;
            }
        }
        
        return square!;
    }
    
    func GetSquareByIdentifier(identifier: Int) -> Square {
        return _squares[identifier];
    }
    
    func GetState() -> String {
        var winnerFound = false;
        var winnerSymbol = "";
        var xIndex = 1;
        var yIndex = 1;
        var index = 1;
        var symbolFlag: String;
        var tempSquare: Square;
        
        // Analyze rows
        while !winnerFound && (xIndex <= _boardSize) {
            tempSquare = GetSquareByCoordinates(xIndex, yIndex);
            
            if tempSquare.View.SquareWasPlayed {
                symbolFlag = tempSquare.View.PlayedSymbol;
                winnerFound = true;
                yIndex = 1;
                
                while winnerFound && (yIndex <= _boardSize) {
                    tempSquare = GetSquareByCoordinates(xIndex, yIndex);
                    
                    if !tempSquare.View.SquareWasPlayed {
                        winnerFound = false;
                    } else if tempSquare.View.PlayedSymbol != symbolFlag {
                        winnerFound = false;
                    } else {
                        yIndex++;
                    }
                }
                
                if winnerFound {
                    winnerSymbol = symbolFlag;
                }
            }
            
            if !winnerFound {
                xIndex++;
                yIndex = 1;
            }
        }
        
        if winnerFound {
            return winnerSymbol;
        }
        
        // Analyze columns
        while !winnerFound && (yIndex <= _boardSize) {
            tempSquare = GetSquareByCoordinates(xIndex, yIndex);
            
            if tempSquare.View.SquareWasPlayed {
                symbolFlag = tempSquare.View.PlayedSymbol;
                winnerFound = true;
                xIndex = 1;
                
                while winnerFound && (xIndex <= _boardSize) {
                    tempSquare = GetSquareByCoordinates(xIndex, yIndex);
                    
                    if !tempSquare.View.SquareWasPlayed {
                        winnerFound = false;
                    } else if tempSquare.View.PlayedSymbol != symbolFlag {
                        winnerFound = false;
                    } else {
                        xIndex++;
                    }
                }
                
                if winnerFound {
                    winnerSymbol = symbolFlag;
                }
            }
            
            if !winnerFound {
                yIndex++;
                xIndex = 1;
            }
        }
        
        if winnerFound {
            return winnerSymbol;
        }
        
        // Analyze descending diagonal
        tempSquare = GetSquareByCoordinates(index, index);
        
        if tempSquare.View.SquareWasPlayed {
            symbolFlag = tempSquare.View.PlayedSymbol;
            winnerFound = true;
            
            while winnerFound && (index <= _boardSize) {
                tempSquare = GetSquareByCoordinates(index, index);
                
                if !tempSquare.View.SquareWasPlayed {
                    winnerFound = false;
                } else if tempSquare.View.PlayedSymbol != symbolFlag {
                    winnerFound = false;
                } else {
                    index++;
                }
            }
            
            if winnerFound {
                winnerSymbol = symbolFlag;
            }
        }
        
        // Analyze ascending diagonal
        index = 1
        tempSquare = GetSquareByCoordinates(index, _boardSize - index + 1);
        
        if tempSquare.View.SquareWasPlayed {
            symbolFlag = tempSquare.View.PlayedSymbol;
            winnerFound = true;
            
            while winnerFound && (index <= _boardSize) {
                tempSquare = GetSquareByCoordinates(index, _boardSize - index + 1);
                
                if !tempSquare.View.SquareWasPlayed {
                    winnerFound = false;
                } else if tempSquare.View.PlayedSymbol != symbolFlag {
                    winnerFound = false;
                } else {
                    index++;
                }
            }
            
            if winnerFound {
                winnerSymbol = symbolFlag;
            }
        }
        
        if winnerFound {
            return winnerSymbol;
        }
        
        // Analyze left squares
        var tie = true;
        
        xIndex = 1;
        yIndex = 1;
        
        while tie && (xIndex <= _boardSize) {
            while tie && (yIndex <= _boardSize) {
                if !GetSquareByCoordinates(xIndex, yIndex).View.SquareWasPlayed {
                    tie = false;
                } else {
                    yIndex++;
                }
            }
            
            if tie {
                xIndex++;
                yIndex = 1;
            }
        }
        
        if tie {
            return MichiStates.Tie;
        }
        
        return  MichiStates.NoWinner;
    }
}

class MichiStates {
    static let NoWinner = "NW";
    static let Tie = "TIE";
}

class Square {
    private let _view: SquareView;
    private let _xCoordinate: Int;
    private let _yCoordinate: Int;
    
    var Identifier: Int {
        get {
            return _view.PlayButton.tag;
        }
    }
    
    var View: SquareView {
        get {
            return _view;
        }
    }
    
    var XCoordinate: Int {
        get {
            return _xCoordinate;
        }
    }
    
    var YCoordinate: Int {
        get {
            return _yCoordinate;
        }
    }
    
    init (view: SquareView, xCoordinate: Int, yCoordinate: Int, identifier: Int) {
        _view = view;
        _view.PlayButton.tag = identifier;
        
        _xCoordinate = xCoordinate;
        _yCoordinate = yCoordinate;
    }
}