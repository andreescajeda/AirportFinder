//
//  ListController.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var airports: [Airport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        tableView.backgroundColor = .background
        tableView.register(AirportTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let airport = airports[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AirportTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.codeLabel.text = "\(airport.code)"
        cell.nameLabel.text = "\(airport.name)"
        cell.locationLabel.text = "\(airport.location.latitude), \(airport.location.longitude)"
        cell.cityLabel.text = "\(airport.city), \(airport.countryCode)"
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 + 20
    }
}
