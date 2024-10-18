//
//  ProfileView.swift
//  Contact-iOS
//
//  Created by Damyant Jain on 9/25/24.
//

import UIKit

class ProfileView: UIView {
    var nameValueLabel: UILabel!
    var emailValueLabel: UILabel!
    var phoneValueLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpProfileValueLabel()
        setUpEmailValueLabel()
        setUpPhoneValueLabel()

        initConstraints()
    }

    func setUpProfileValueLabel() {
        nameValueLabel = UILabel()
        nameValueLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameValueLabel)
    }

    func setUpEmailValueLabel() {
        emailValueLabel = UILabel()
        emailValueLabel.font = emailValueLabel.font.withSize(18)
        emailValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailValueLabel)
    }

    func setUpPhoneValueLabel() {
        phoneValueLabel = UILabel()
        phoneValueLabel.font = phoneValueLabel.font.withSize(18)
        phoneValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneValueLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([

            //Name Label
            nameValueLabel.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameValueLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),

            //Email Label
            emailValueLabel.topAnchor.constraint(
                equalTo: nameValueLabel.bottomAnchor, constant: 30),
            emailValueLabel.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            //Phone Label
            phoneValueLabel.topAnchor.constraint(
                equalTo: emailValueLabel.bottomAnchor, constant: 18),
            phoneValueLabel.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
