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
    private var _squares: Array<Square>;
    
    init (boardSize: Int) {
        _squares = Array<Square>();
        
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
                
                _squares.append(Square(view: view, xCoordinate: i, yCoordinate: j));
            }
        }
    }
    
    func DestroyBoard() {
        for square in _squares {
            square.View.removeFromSuperview();
        }
    }
    
    func BuildBoard (vc: UIViewController) {
        for square in _squares {
            vc.view.addSubview(square.View);
        }
    }
}

class Square {
    private let _view: SquareView;
    private let _xCoordinate: Int;
    private let _yCoordinate: Int;
    
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
    
    init (view: SquareView, xCoordinate: Int, yCoordinate: Int) {
        _view = view;
        _xCoordinate = xCoordinate;
        _yCoordinate = yCoordinate;
    }
}