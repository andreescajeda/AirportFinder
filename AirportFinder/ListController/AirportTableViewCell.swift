//
//  ItemView.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import UIKit

@IBDesignable class AirportTableViewCell: UITableViewCell {
    
    @IBInspectable var codeLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 15, weight: .light)
        label.textColor = .gray
        
        return label
    }()
    
    @IBInspectable var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .light)
        
        return label
    }()
    
    @IBInspectable var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlue
        
        return label
    }()
    
    @IBInspectable var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 13, weight: .light)
        label.textColor = .gray
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cardView = UIView()
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.layer.cornerRadius = 7
        
        addSubview(cardView)
        cardView.anchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 8, paddingLeft: 0, width: 0, height: 0)
        
        cardView.addSubview(codeLabel)
        codeLabel.anchor(top: cardView.topAnchor, right: cardView.rightAnchor, bottom: nil, left: cardView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        cardView.addSubview(nameLabel)
        nameLabel.anchor(top: codeLabel.bottomAnchor, right: cardView.rightAnchor, bottom: nil, left: cardView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        cardView.addSubview(cityLabel)
        cityLabel.anchor(top: nameLabel.bottomAnchor, right: cardView.rightAnchor, bottom: nil, left: cardView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        cardView.addSubview(locationLabel)
        locationLabel.anchor(top: cityLabel.bottomAnchor, right: cardView.rightAnchor, bottom: nil, left: cardView.leftAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
