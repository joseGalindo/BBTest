//
//  ViewController.swift
//  BranchBTest
//
//  Created by Jose Galindo martinez on 03/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Logic
    var options = [Actionable]()
    var selected = [String : Actionable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Options"
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        self.mTableView.tableFooterView = UIView()
        
        self.options.append(contentsOf: self.loadData())
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let optns = sender as! [String : Actionable]
        let vc = segue.destination as! DetailViewController
        vc.selected = Array(optns.values).sorted(by: { (a1, a2) -> Bool in
            return a1.header! < a2.header!
        })
    }
    
    @IBAction func showNext(_ sender: Any) {
        if selected.count == 0 {
            self.showError("There is no selection")
        } else {
            self.performSegue(withIdentifier: "showDetail", sender: selected)
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "ReuseIdentifier")
        cell.textLabel?.text = options[indexPath.row].header!
        if let _ = selected[options[indexPath.row].header!] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let elem = options[indexPath.row]
        if let _ = selected[elem.header!] {
            cell?.accessoryType = .none
            selected[elem.header!] = nil
        } else {
            selected[elem.header!] = elem
            cell?.accessoryType = .checkmark
        }
    }
}

