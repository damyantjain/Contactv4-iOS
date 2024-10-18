//
//  AddContactView.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class ContactView: UIView {

    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpNameTextField()
        setUpEmailTextField()
        setUpPhoneTextField()

        initConstraints()
    }

    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }

    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }

    func setUpPhoneTextField() {
        phoneTextField = UITextField()
        phoneTextField.placeholder = "Phone number"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .phonePad
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTextField)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([

            //name field
            nameTextField.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            nameTextField.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),

            //email field
            emailTextField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),

            phoneTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneTextField.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            phoneTextField.widthAnchor.constraint(equalToConstant: 300),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
