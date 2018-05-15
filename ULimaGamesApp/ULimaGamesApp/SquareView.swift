//
//  SquareView.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/15/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class SquareView: UIView {
    @IBOutlet private var ContentView: UIView!
    @IBOutlet weak private var PlayLabel: UILabel!
    
    private var _squareWasPlayed: Bool = false;
    
    var SquareIsPlayed: Bool {
        get {
            return _squareWasPlayed;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        InitView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        InitView();
    }
    
    private func InitView() {
        
    }
    
    func PlaySquare(playSymbol: String) {
        
        
        _squareWasPlayed = true;
    }
}