//
//  ProfileViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    var contactData: Contact = Contact()
    var landingPageDelegate: ViewController!

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(onEditButtonTapped))

        loadProfileData()
    }

    @objc func onEditButtonTapped() {
        let editProfileVC = ContactViewController()
        editProfileVC.contactData = contactData
        editProfileVC.landingPageDelegate = landingPageDelegate
        editProfileVC.profileViewDelegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    func loadProfileData() {
        profileView.nameValueLabel.text = contactData.name
        profileView.emailValueLabel.text = "Email: \(contactData.email ?? "")"
        profileView.phoneValueLabel.text = "Phone: \(contactData.phone ?? "")"
    }

}
