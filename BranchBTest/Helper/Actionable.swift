//
//  Actionable.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation

protocol Actionable : Decodable {
    var header: String? { get }
    var value: String? { get set }
    var type: Constants.OptionType? { get }
}

struct DataWrapper : Decodable {
    var options : [Element]?
}

struct Element : Actionable {
    var header: String?
    var type: Constants.OptionType?
    var value: String?
    
    mutating func setValue(otherValue : String) {
        self.value = otherValue
    }
}
