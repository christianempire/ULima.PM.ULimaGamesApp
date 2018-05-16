//
//  SquareView.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/15/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit;

class SquareView: UIView {
    @IBOutlet private var ContentView: UIView!
    @IBOutlet weak private var PlayLabel: UILabel!
    
    private var _squareWasPlayed: Bool = false;
    
    var playedSymbol: String {
        get {
            if _squareWasPlayed {
                return PlayLabel.text!;
            } else {
                return "";
            }
        }
    }
    
    var SquareWasPlayed: Bool {
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
        NSBundle.mainBundle().loadNibNamed("SquareView", owner: self, options: nil);
        addSubview(ContentView);
        ContentView.frame = self.bounds;
        ContentView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth];
        PlayLabel.frame = CGRect(x: 0, y: 0, width: ContentView.frame.width, height: ContentView.frame.height);
        PlayLabel.hidden = true;
    }
    
    func PlaySquare(playSymbol: String) {
        PlayLabel.hidden = false;
        PlayLabel.text = playSymbol;
        
        _squareWasPlayed = true;
    }
}