//
//  TVCImage.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class TVCImage: UITableViewCell {

    static let IDENTIFIER = String(describing: TVCImage.self)
    static let size : CGFloat = 140.0
    @IBOutlet weak var imageToLoad: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPhotoType() {
        let url = URL(string: Constants.VEGETA_IMG)
        loadImage(with: url!, into: imageToLoad)
    }
}
