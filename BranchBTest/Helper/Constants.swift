//
//  Constants.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    static let OPTIONS = ["Cámara", "Foto", "Nombre completo", "Número telefónico", "Fecha de nacimiento", "Sexo", "Color favorito"]
    static let COLORS = ["White", "Blue", "Green", "Red", "Yellow"]
    static let VEGETA_IMG = "http://http2.mlstatic.com/vegeta-tamano-real-para-armar-en-papercraft-D_NQ_NP_892880-MLA26232224460_102017-F.jpg"
    static let GENDER = ["MALE", "FEMALE"]
    
    enum OptionType : Int, Decodable {
        case Camera = 0
        case Photo
        case Name
        case Phone
        case Birthdate
        case Gender
        case Color
    }
}

extension UIViewController {
    
    func showError(_ message : String) {
        let alertc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertc, animated: true, completion: nil)
    }
    
    func loadData() -> [Actionable] {
        let pathRes = Bundle.main.path(forResource: "Data", ofType: "json")
        var array = [Actionable]()
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: pathRes!), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(DataWrapper.self, from: data)
            array.append(contentsOf: jsonData.options!)
        } catch let error {
            print(error)
        }
        return array
    }
}
