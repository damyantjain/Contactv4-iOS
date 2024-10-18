//
//  ContactTableViewCell.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var phoneTypeLabel: UILabel!
    var profilePhotoImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setUpNameLabel()
//        setUpEmailLabel()
//        setUpPhoneLabel()
        initConstraints()
    }

    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }

    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        wrapperCellView.addSubview(nameLabel)
    }

    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = emailLabel.font.withSize(16)
        wrapperCellView.addSubview(emailLabel)
    }

    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.font = phoneLabel.font.withSize(16)
        wrapperCellView.addSubview(phoneLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            //wrapper cell view
            wrapperCellView.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            wrapperCellView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -5),
            wrapperCellView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),

            //name label
            nameLabel.topAnchor.constraint(
                lessThanOrEqualTo: wrapperCellView.topAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(
                equalTo: wrapperCellView.leadingAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

//            //email label
//            emailLabel.topAnchor.constraint(
//                lessThanOrEqualTo: nameLabel.bottomAnchor, constant: 4),
//            emailLabel.leadingAnchor.constraint(
//                equalTo: wrapperCellView.leadingAnchor, constant: 8),
//            emailLabel.heightAnchor.constraint(equalToConstant: 20),
//
//            //phone label
//            phoneLabel.topAnchor.constraint(
//                lessThanOrEqualTo: emailLabel.bottomAnchor, constant: 4),
//            phoneLabel.leadingAnchor.constraint(
//                equalTo: wrapperCellView.leadingAnchor, constant: 8),
//            phoneLabel.heightAnchor.constraint(equalToConstant: 20),

            wrapperCellView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}