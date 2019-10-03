//
//  StateDetailTableViewController.swift
//  Representative-master
//
//  Created by Eric Lanza on 1/16/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit



class StateDetailTableViewController: UITableViewController {
    
    
    //Computed Property
    
    var representatives: [Representive] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var state: String?
    
    override func viewDidLoad() {
        if let state = state {
        RepresentativeController.searchRepresientatives(forState: state) { (newArray) in
            self.representatives = newArray
            
            }
        }
    }
    
    
     //MARK: - Table view data source
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return representatives.count
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell else { return UITableViewCell() }
    
            cell.representative = representatives[indexPath.row]
    
            return cell
        }
    
    
    
    
} // end of class







