//
//  TVCPicker.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class TVCPicker: UITableViewCell {

    static let IDENTIFIER = String(describing: TVCPicker.self)
    static let size : CGFloat = 160.0
    
    // UI
    @IBOutlet weak var mDtaePicker: UIDatePicker!
    @IBOutlet weak var textInput: UITextField!
    
    //
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        formatter.dateFormat = "dd-MM-yyyy"
        textInput.text = formatter.string(from: mDtaePicker.date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func changeDate(_ sender: Any) {
        textInput.text = formatter.string(from: mDtaePicker.date)
    }
    
    
}
