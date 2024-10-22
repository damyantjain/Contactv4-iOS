//
//  AddContactView.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class ContactView: UIView {

    var contentWrapper: UIScrollView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupContentWrapper()
        setUpNameTextField()
        setUpEmailTextField()
        setUpPhoneTextField()

        initConstraints()
    }

    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
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

            //scroll view
            contentWrapper.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.heightAnchor),

            //name field
            nameTextField.topAnchor.constraint(
                equalTo: contentWrapper.topAnchor, constant: 12),
            nameTextField.centerXAnchor.constraint(
                equalTo: contentWrapper.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),

            //email field
            emailTextField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(
                equalTo: contentWrapper.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),

            phoneTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneTextField.centerXAnchor.constraint(
                equalTo: contentWrapper.centerXAnchor),
            phoneTextField.widthAnchor.constraint(equalToConstant: 300),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
