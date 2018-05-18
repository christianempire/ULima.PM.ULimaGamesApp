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
    private var _size: Int;
    private var _stones: Array<Stone>;
    
    var Size: Int {
        get {
            return _size;
        }
    }
    
    var Stones: Array<Stone> {
        get {
            return _stones;
        }
    }
    
    init (size: Int) {
        _size = size;
        _stones = Array<Stone>();
        
        // TODO
    }
    
    func Build (vc: UIViewController) {
        for stones in _stones {
            vc.view.addSubview(stones.View);
        }
    }
    
    func Destroy() {
        for square in _stones {
            square.View.removeFromSuperview();
        }
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