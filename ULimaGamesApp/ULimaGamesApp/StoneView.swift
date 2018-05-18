//
//  StoneView.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/18/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit;

class StoneView: UIView {
    @IBOutlet var ContentView: UIView!
    @IBOutlet weak var PlayButton: UIButton!
    
    private var _stoneWasPlayed: Bool = false;
    
    var PlayedSymbol: String {
        get {
            if _stoneWasPlayed {
                return PlayButton.titleLabel!.text!;
            } else {
                return "";
            }
        }
    }
    
    var StoneWasPlayed: Bool {
        get {
            return _stoneWasPlayed;
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
        NSBundle.mainBundle().loadNibNamed("StoneView", owner: self, options: nil);
        addSubview(ContentView);
        ContentView.frame = self.bounds;
        ContentView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth];
        PlayButton.setTitle("", forState: .Normal);
    }
    
    func PlayStone(playSymbol: String) {
        PlayButton.setTitle(playSymbol, forState: .Normal);
        
        _stoneWasPlayed = true;
    }
}