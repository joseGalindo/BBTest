//
//  TVCTextPicker.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class TVCTextPicker: UITableViewCell {

    static let IDENTIFIER = String(describing: TVCTextPicker.self)
    static let size : CGFloat = 44.0
    
    // UI
    @IBOutlet weak var textInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAsPhone() {
        textInput.keyboardType = .numberPad
        textInput.tag = 17
    }
    
}
