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
    @IBOutlet weak var PlayButton: UIButton!
    
    private var _squareWasPlayed: Bool = false;
    
    var PlayedSymbol: String {
        get {
            if _squareWasPlayed {
                return PlayButton.titleLabel!.text!;
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
        PlayButton.setTitle("", forState: .Normal);
    }
    
    func PlaySquare(playSymbol: String) {
        PlayButton.setTitle(playSymbol, forState: .Normal);
        
        _squareWasPlayed = true;
    }
}