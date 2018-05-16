//
//  MichiController.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class MichiController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak private var _sizeTextField: UITextField!
    
    private let _boardSizes = [3, 4, 5];
    
    private var _board = Michi(boardSize: 3);
    private var _sizePicker = UIPickerView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        InitSizeSelector();
        
        _sizeTextField.text = "3";
        _board.BuildBoard(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _boardSizes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(_boardSizes[row]);
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _sizeTextField.text = String(_boardSizes[row]);
        _sizeTextField.resignFirstResponder();
        
        RedrawBoard(_boardSizes[row]);
    }
    
    private func RedrawBoard(size: Int) {
        _board.DestroyBoard();
        _board = Michi(boardSize: size);
        _board.BuildBoard(self);
    }
    
    private func InitSizeSelector() {
        _sizePicker.delegate = self;
        _sizePicker.dataSource = self;
        _sizeTextField.inputView = _sizePicker;
    }
    
}
