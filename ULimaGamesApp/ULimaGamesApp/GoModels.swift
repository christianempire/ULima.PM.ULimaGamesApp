//
//  GoModels.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/18/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation;
import UIKit;

class Grid {
    private var _stones: Array<Stone>;
    
    var Size: Int {
        get {
            return 10;
        }
    }
    
    var Stones: Array<Stone> {
        get {
            return _stones;
        }
    }
    
    init () {
        _stones = Array<Stone>();
    }
    
    func Build (vc: UIViewController) {
        let initialX = 20;
        let initialY = 124;
        let lineMargin = Int(360 / Size);
        
        // Build grid
        for i in 0...Size {
            let x = initialX + (i * lineMargin);
            
            let line = UILabel(frame: CGRect(x: x - 1, y: initialY, width: 2, height: 360));
            
            line.backgroundColor = UIColor.brownColor();
            
            vc.view.addSubview(line);
        }
        
        for i in 0...Size {
            let y = initialY + (i * lineMargin);
            
            let line = UILabel(frame: CGRect(x: initialX, y: y - 1, width: 360, height: 2));
            
            line.backgroundColor = UIColor.brownColor();
            
            vc.view.addSubview(line);
        }
        
        // Create stones
        var stoneIndex = 0;
        
        for i in 0...Size {
            for j in 0...Size {
                let view = StoneView();
                let x = initialX + (i * lineMargin) - 10;
                let y = initialY + (j * lineMargin) - 10;
                
                view.frame = CGRect(x: x, y: y, width: 20, height: 20);
                
                vc.view.addSubview(view);
                
                _stones.append(Stone(view: view, xCoordinate: i, yCoordinate: j, identifier: stoneIndex++));
            }
        }
    }
    
    func Destroy() {
        for square in _stones {
            square.View.removeFromSuperview();
        }
    }
    
    func GetScores() -> [String: Int] {
        var scores = [String: Int]();
        
        scores["⚪"] = 2;
        scores["⚫"] = 3;
        
        return scores;
    }
    
    func GetState() -> String {
        
        
        return GoStates.NoWinner;
    }
    
    func GetStoneByCoordinates(xCoordinate: Int, _ yCoordinate: Int) -> Stone {
        var stoneIndex = 0;
        var stoneFound = false;
        var stone: Stone?;
        
        while !stoneFound && (stoneIndex < _stones.count) {
            stone = _stones[stoneIndex];
            
            if (stone!.XCoordinate == xCoordinate) && (stone!.YCoordinate == yCoordinate) {
                stoneFound = true;
            } else {
                stoneIndex++;
            }
        }
        
        return stone!;
    }
    
    func GetStoneByIdentifier(identifier: Int) -> Stone {
        return _stones[identifier];
    }
}

class GoStates {
    static let NoWinner = "NW";
    static let Tie = "TIE";
}

class Stone {
    private let _view: StoneView;
    private let _xCoordinate: Int;
    private let _yCoordinate: Int;
    
    var Identifier: Int {
        get {
            return _view.PlayButton.tag;
        }
    }
    
    var View: StoneView {
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
    
    init (view: StoneView, xCoordinate: Int, yCoordinate: Int, identifier: Int) {
        _view = view;
        _view.PlayButton.tag = identifier;
        
        _xCoordinate = xCoordinate;
        _yCoordinate = yCoordinate;
    }
}