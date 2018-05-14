//
//  BlackjackModels.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation;

class Card {
    let IsAce: Bool;
    let Value: String;
    let Weight: Int;
    
    init(isAce: Bool, value: String, weight: Int) {
        IsAce = isAce;
        Value = value;
        Weight = weight;
    }
}

class Deck {
    private var _cards: Array<Card>;
    
    // Initializes the deck with all the cards
    init() {
        _cards = Array<Card>();
        // Spades
        _cards.append(Card(isAce: true, value: "A♠️", weight: 1));
        _cards.append(Card(isAce: false, value: "2♠️", weight: 2));
        _cards.append(Card(isAce: false, value: "3♠️", weight: 3));
        _cards.append(Card(isAce: false, value: "4♠️", weight: 4));
        _cards.append(Card(isAce: false, value: "5♠️", weight: 5));
        _cards.append(Card(isAce: false, value: "6♠️", weight: 6));
        _cards.append(Card(isAce: false, value: "7♠️", weight: 7));
        _cards.append(Card(isAce: false, value: "8♠️", weight: 8));
        _cards.append(Card(isAce: false, value: "9♠️", weight: 9));
        _cards.append(Card(isAce: false, value: "10♠️", weight: 10));
        _cards.append(Card(isAce: false, value: "J♠️", weight: 10));
        _cards.append(Card(isAce: false, value: "Q♠️", weight: 10));
        _cards.append(Card(isAce: false, value: "K♠️", weight: 10));
        // Diamonds
        _cards.append(Card(isAce: true, value: "A♦️", weight: 1));
        _cards.append(Card(isAce: false, value: "2♦️", weight: 2));
        _cards.append(Card(isAce: false, value: "3♦️", weight: 3));
        _cards.append(Card(isAce: false, value: "4♦️", weight: 4));
        _cards.append(Card(isAce: false, value: "5♦️", weight: 5));
        _cards.append(Card(isAce: false, value: "6♦️", weight: 6));
        _cards.append(Card(isAce: false, value: "7♦️", weight: 7));
        _cards.append(Card(isAce: false, value: "8♦️", weight: 8));
        _cards.append(Card(isAce: false, value: "9♦️", weight: 9));
        _cards.append(Card(isAce: false, value: "10♦️", weight: 10));
        _cards.append(Card(isAce: false, value: "J♦️", weight: 10));
        _cards.append(Card(isAce: false, value: "Q♦️", weight: 10));
        _cards.append(Card(isAce: false, value: "K♦️", weight: 10));
        // Clubs
        _cards.append(Card(isAce: true, value: "A♣️", weight: 1));
        _cards.append(Card(isAce: false, value: "2♣️", weight: 2));
        _cards.append(Card(isAce: false, value: "3♣️", weight: 3));
        _cards.append(Card(isAce: false, value: "4♣️", weight: 4));
        _cards.append(Card(isAce: false, value: "5♣️", weight: 5));
        _cards.append(Card(isAce: false, value: "6♣️", weight: 6));
        _cards.append(Card(isAce: false, value: "7♣️", weight: 7));
        _cards.append(Card(isAce: false, value: "8♣️", weight: 8));
        _cards.append(Card(isAce: false, value: "9♣️", weight: 9));
        _cards.append(Card(isAce: false, value: "10♣️", weight: 10));
        _cards.append(Card(isAce: false, value: "J♣️", weight: 10));
        _cards.append(Card(isAce: false, value: "Q♣️", weight: 10));
        _cards.append(Card(isAce: false, value: "K♣️", weight: 10));
        // Hearts
        _cards.append(Card(isAce: true, value: "A♥️", weight: 1));
        _cards.append(Card(isAce: false, value: "2♥️", weight: 2));
        _cards.append(Card(isAce: false, value: "3♥️", weight: 3));
        _cards.append(Card(isAce: false, value: "4♥️", weight: 4));
        _cards.append(Card(isAce: false, value: "5♥️", weight: 5));
        _cards.append(Card(isAce: false, value: "6♥️", weight: 6));
        _cards.append(Card(isAce: false, value: "7♥️", weight: 7));
        _cards.append(Card(isAce: false, value: "8♥️", weight: 8));
        _cards.append(Card(isAce: false, value: "9♥️", weight: 9));
        _cards.append(Card(isAce: false, value: "10♥️", weight: 10));
        _cards.append(Card(isAce: false, value: "J♥️", weight: 10));
        _cards.append(Card(isAce: false, value: "Q♥️", weight: 10));
        _cards.append(Card(isAce: false, value: "K♥️", weight: 10));
    }
    
    // Draws a random card from the deck, this card is automatically removed from the deck
    func DrawCard() -> Card? {
        if _cards.isEmpty {
            return nil;
        }
        
        let _randomIndex = Int(arc4random_uniform(UInt32(_cards.count)));
        
        return _cards.removeAtIndex(_randomIndex);
    }
}