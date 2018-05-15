//
//  CardView.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBOutlet private var ContentView: UIView!
    @IBOutlet weak private var CardBackLabel: UILabel!
    @IBOutlet weak private var CardValueLabel: UILabel!
    
    private var _cardIsRevealed: Bool = false;
    private var _cardObject: Card?;
    
    var CardIsRevealed: Bool {
        get {
            return _cardIsRevealed;
        }
    }
    
    var CardObject: Card? {
        get {
            return _cardObject;
        }
        
        set {
            _cardObject = newValue;
            
            CardValueLabel.text = newValue?.Value;
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
    
    // Initializes the view
    private func InitView() {
        NSBundle.mainBundle().loadNibNamed("CardView", owner: self, options: nil);
        addSubview(ContentView);
        ContentView.frame = self.bounds;
        ContentView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth];
        HideCard();
    }
    
    func HideCard() {
        CardBackLabel.hidden = false;
        CardValueLabel.hidden = true;
        
        _cardIsRevealed = false;
    }
    
    func RevealCard(){
        CardBackLabel.hidden = true;
        CardValueLabel.hidden = false;
        
        _cardIsRevealed = true;
    }
}
