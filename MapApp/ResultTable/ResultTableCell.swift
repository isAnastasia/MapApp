//
//  ResultTableCell.swift
//  MapApp
//
//  Created by Anastasia Gorbunova on 08.08.2024.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {
    static let identifier = "ResultTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 16
        backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
