//
//  MeteorCell.swift
//  Meteors
//
//  Created by Ulaş Sancak on 1.10.2021.
//

import UIKit

class MeteorCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemFill
        return label
    }()
    
    private let massLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemFill
        return label
    }()
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "·"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemFill
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        nameLabel.text = "Aachen"
        dateLabel.text = "Sep 6, 1956"
        massLabel.text = "0.54 kg"
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(separatorLabel)
        stackView.addArrangedSubview(massLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8.0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: 8.0),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6.0)
        ])
    }
    
}
