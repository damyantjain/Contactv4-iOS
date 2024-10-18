//
//  LandingView.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class LandingView: UIView {

    var contactsTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpContactsTableView()
        initConstraints()
    }

    func setUpContactsTableView() {
        contactsTableView = UITableView()
        contactsTableView.register(
            ContactTableViewCell.self, forCellReuseIdentifier: "contacts")
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contactsTableView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            contactsTableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            contactsTableView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contactsTableView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
