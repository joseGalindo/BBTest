//
//  DetailViewController.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    // Logic
    var selected : [Actionable]?
    let colors = Constants.COLORS
    var isMale = true
    var colorsSelected = [false, false, false,false ,false]
    var indexPathSelected : IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cells
        let photoNib = UINib.init(nibName: "TVCImage", bundle: nil)
        let pickerNib = UINib.init(nibName: "TVCPicker", bundle: nil)
        let tPickerNib = UINib.init(nibName: "TVCTextPicker", bundle: nil)
        self.tableView.register(photoNib, forCellReuseIdentifier: TVCImage.IDENTIFIER)
        self.tableView.register(pickerNib, forCellReuseIdentifier: TVCPicker.IDENTIFIER)
        self.tableView.register(tPickerNib, forCellReuseIdentifier: TVCTextPicker.IDENTIFIER)
        self.tableView.keyboardDismissMode = .interactive
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return selected!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selected![section].type! {
        case .Camera, .Photo, .Name, .Phone, .Birthdate:
            return 1
        case .Gender:
            return 2
        case .Color:
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = selected![section].header
        return label
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let action = selected![indexPath.section]
        switch action.type! {
        case .Camera:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCImage.IDENTIFIER) as! TVCImage
            return cell
        case .Photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCImage.IDENTIFIER) as! TVCImage
            cell.setPhotoType()
            return cell
        case .Name:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCTextPicker.IDENTIFIER) as! TVCTextPicker
            cell.textInput.delegate = self
            return cell
        case .Phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCTextPicker.IDENTIFIER) as! TVCTextPicker
            cell.textInput.delegate = self
            cell.setAsPhone()
            return cell
        case .Birthdate:
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCPicker.IDENTIFIER) as! TVCPicker
            cell.textInput.delegate = self
            return cell
        case .Gender:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "GenderTVC")
            cell.textLabel?.text = Constants.GENDER[indexPath.row]
            if isMale && indexPath.row == 0 {
                cell.accessoryType = .checkmark
            }
            if !isMale && indexPath.row == 1 {
                cell.accessoryType = .checkmark
            }
            return cell
        case .Color:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "ColorTVC")
            cell.textLabel?.text = Constants.COLORS[indexPath.row]
            if colorsSelected[indexPath.row] {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let action = selected![indexPath.section]
        switch action.type! {
        case .Camera, .Photo:
            return TVCImage.size
        case .Name, .Phone:
            return TVCTextPicker.size
        case .Birthdate:
            return TVCPicker.size
        case .Gender:
            return 44
        case .Color:
            return 44
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = selected![indexPath.section]
        switch action.type! {
        case .Camera:
            #if TARGET_OS_IPHONE
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.indexPathSelected = indexPath
            self.present(imagePicker, animated: true, completion: nil)
            #else
            self.showError("Cannot lauch camera, I'm a simulator")
            #endif
            break
        case .Photo, .Name, .Phone, .Birthdate:
         break
        case .Gender:
            self.isMale = indexPath.row == 0
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            break
        case .Color:
            colorsSelected[indexPath.row].toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            break
        }
    }
}

extension DetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxInput = textField.tag == 17 ? 10 : 35
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= maxInput
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = self.tableView.cellForRow(at: indexPathSelected) as! TVCImage
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cell.imageToLoad.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
